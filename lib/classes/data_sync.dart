import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/classes/total_data.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/services/check_connection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import 'package:yoyaku/services/get_within_same_month.dart';

class DataSync extends ChangeNotifier {
  static final YoyakuDatabase _localDatabase = YoyakuDatabase();
  static Map? exchangeRates;
  List<Item> allItems = [];
  final String _userId;
  final String username;

  DataSync(this._userId, this.username) {
    syncDatabase();
  }

  void syncDatabase() async {
    bool isConnected = await checkConnection();
    if (!isConnected) return;

    // Sync local to server;
    notifyListeners();
  }

  Future<List<Item>> get getAllItems async => await _localDatabase.allItems;

  Future<List<Item>> get getAllUnCanceledItems async =>
      await _localDatabase.allUnCanceledItems;

  Future<List<Item>> get getCanceledItems async =>
      await _localDatabase.allCanceledItems;

  Future<List<Item>> get getDeliveredItems async =>
      await _localDatabase.allDeliveredItems;

  Map? get getExchangeRate => exchangeRates;

  Stream<List<Item>> dataStream() {
    return _localDatabase.watchEntries();
  }

  Future<List<Item>> getUpcommingItems() async {
    List<Item> allItems = await _localDatabase.allUnCanceledItems;
    return allItems
        .where(
          (element) =>
              getDateInSameMonth(DateTime.now(), element.releaseDate) &&
              !element.delivered,
        )
        .toList();
  }

  Future<List<Item>> getUpcommingPayments() async {
    List<Item> allItems = await _localDatabase.allUnCanceledItems;
    return allItems
        .where(
          (element) =>
              getDateInSameMonth(DateTime.now(), element.releaseDate) &&
              !element.paid,
        )
        .toList();
  }

  Future<Map<String, List<Item>>> getMontlyItems() async {
    final DateFormat formatter = DateFormat.yMMMM();
    List<Item> allItems = await _localDatabase.allMontlyItems;
    Map<String, List<Item>> result = {};

    for (Item item in allItems) {
      final String itemMonth = formatter.format(item.releaseDate);

      if (result.containsKey(itemMonth)) {
        result[itemMonth]!.add(item);
      } else {
        result[itemMonth] = [item];
      }
    }

    return result;
  }

  Future<TotalData> getTotalData(dynamic rates) async {
    List<Item> allItems = await _localDatabase.allItems;

    double totalSpend = 0;
    double totalVat = 0;
    double totalShipping = 0;
    double totalCollection = 0;
    double totalPrice = 0;
    double totalDebt = 0;
    int totalOrders = 0;
    int mangaAmount = 0;
    int figureAmount = 0;
    int gameAmount = 0;
    int otherAmount = 0;
    int canceledAmount = 0;
    int importAmount = 0;

    for (Item item in allItems) {
      ItemData itemData = ItemData(item, rates);

      if (!itemData.canceled) {
        totalSpend += itemData.totalRaw;
        totalVat += itemData.vatRaw;
        totalShipping += itemData.shippingRaw;
        totalPrice += itemData.priceRaw;

        if (itemData.delivered) {
          totalCollection += itemData.totalRaw;
        }
        totalOrders += 1;

        switch (itemData.type) {
          case 'Manga':
            mangaAmount += 1;
            break;
          case 'Figure':
            figureAmount += 1;
            break;
          case 'Game':
            gameAmount += 1;
            break;
          default:
            otherAmount += 1;
            break;
        }

        if (itemData.import) {
          importAmount += 1;
        }

        if (!itemData.paid) {
          totalDebt += itemData.totalRaw;
        }
      } else {
        canceledAmount += 1;
      }
    }

    return TotalData(
      totalSpend: totalSpend,
      totalVat: totalVat,
      totalShipping: totalShipping,
      totalCollection: totalCollection,
      totalOrders: totalOrders,
      mangaAmount: mangaAmount,
      figureAmount: figureAmount,
      gameAmount: gameAmount,
      otherAmount: otherAmount,
      canceledAmount: canceledAmount,
      importAmount: importAmount,
      totalDebt: totalDebt,
      totalPrice: totalPrice,
    );
  }

  void updateItem(Item entry) {
    _localDatabase.updateItem(entry);
    notifyListeners();
  }

  void addItem({
    required int type,
    required String title,
    required DateTime dateBought,
    required DateTime releaseDate,
    required String currency,
    required double price,
    required double shipping,
    required Uint8List image,
    required String link,
    required bool paid,
    required bool delivered,
    required bool canceled,
    required bool import,
  }) async {
    await _localDatabase.addItem(
      ItemsCompanion(
        type: Value(type),
        title: Value(title),
        dateBought: Value(dateBought.toUtc()),
        releaseDate: Value(releaseDate.toUtc()),
        currency: Value(currency),
        price: Value(price.parseToPrecision(2)),
        shipping: Value(shipping.parseToPrecision(2)),
        image: Value(image),
        link: Value(link),
        paid: Value(paid),
        delivered: Value(delivered),
        canceled: Value(canceled),
        import: Value(import),
        uuid: Value(const Uuid().v1()),
      ),
    );
    notifyListeners();
  }

  Future<Item> getItemById(String uuid) async {
    return await _localDatabase.itemByUuid(uuid);
  }

  Future<List<Item>> getItemsByDay(DateTime day) async {
    List<Item> items = [];
    for (Item item in await _localDatabase.allUnCanceledItems) {
      if (isSameDay(item.releaseDate, day)) {
        items.add(item);
      }
    }
    return items;
  }

  void reload() async {
    allItems = await _localDatabase.allItems;
  }

  close() {
    _localDatabase.close();
  }
}

extension DoubleParsing on double {
  /// Parces double to N decimal places
  double parseToPrecision(int precision) {
    return double.parse(
      toStringAsPrecision(precision),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

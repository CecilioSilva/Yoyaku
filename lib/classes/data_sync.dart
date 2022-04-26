import 'package:amiamu/models/database_model.dart';
import 'package:amiamu/services/check_connection.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';

class DataSync extends ChangeNotifier {
  static final AmiAmuDatabase _localDatabase = AmiAmuDatabase();
  List<Item> allItems = [];

  DataSync() {
    syncDatabase();
  }

  void syncDatabase() async {
    bool isConnected = await checkConnection();
    if (!isConnected) return;

    // Sync local to server;
    notifyListeners();
  }

  Future<List<Item>> get getAllItems async => await _localDatabase.allItems;

  Stream<List<Item>> dataStream() {
    return _localDatabase.watchEntries();
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
        uuid: Value(Uuid().v1()),
      ),
    );
    notifyListeners();
  }

  Future<Item> getItemById(String uuid) async {
    return await _localDatabase.itemByUuid(uuid);
  }

  Future<List<Item>> getItemsByDay(DateTime day) async {
    List<Item> items = [];
    for (Item item in await _localDatabase.allItems) {
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

    //TODO: sync to cloud database;
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

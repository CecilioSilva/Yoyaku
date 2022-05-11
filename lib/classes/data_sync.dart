import 'dart:developer';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:drift/drift.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/classes/total_data.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/services/check_connection.dart';
import 'package:yoyaku/services/get_within_same_month.dart';

class DataSync extends ChangeNotifier {
  static final YoyakuDatabase _localDatabase = YoyakuDatabase();
  static Map? exchangeRates;
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
    syncDatabase();
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
    syncDatabase();
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

  void saveDatabase() async {
    List<Item> allItems = await _localDatabase.allItems;
    List<List<dynamic>> rows = <List<dynamic>>[];
    List<List> images = [];

    for (int i = allItems.length - 1; i > 0; i--) {
      log('$i/${allItems.length}', name: 'Index');
      List<dynamic> row = [];
      Item currentItem = allItems[i];

      row.add(currentItem.id); //0
      row.add(currentItem.uuid); //1
      row.add(currentItem.type); //2
      row.add(currentItem.title); //3
      row.add(currentItem.dateBought); //4
      row.add(currentItem.releaseDate); //5
      row.add(currentItem.currency); //6
      row.add(currentItem.price); //7
      row.add(currentItem.shipping); //8
      images.add([currentItem.uuid, currentItem.image]);
      row.add(currentItem.link); //9
      row.add(currentItem.delivered); //10
      row.add(currentItem.import); //11
      row.add(currentItem.paid); //12
      row.add(currentItem.canceled); //13
      rows.add(row);
    }

    if (await Permission.manageExternalStorage.request().isGranted) {
      String csv = const ListToCsvConverter().convert(rows);

      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat("yy-MM-dd_HH-mm");
      final String formatted = formatter.format(now);

      final _localPath = await getApplicationDocumentsDirectory();
      final directory = _localPath.path;

      List<File> imageFiles = [];

      await Directory('$directory/backup_$formatted/images')
          .create(recursive: true);
      for (List image in images) {
        final file =
            File('$directory/backup_$formatted/images/${image[0]}.jpg');
        file.create(recursive: true);
        file.writeAsBytesSync(image[1]);
        imageFiles.add(file);
      }

      final dataFile = File('$directory/backup_$formatted/yoyaku_data.csv');
      dataFile.create(recursive: true);
      dataFile.writeAsStringSync(csv);

      final dataDir = Directory('$directory/backup_$formatted/');
      final zipFile = File('$directory/backup_$formatted.zip');
      await ZipFile.createFromDirectory(
        sourceDir: dataDir,
        zipFile: zipFile,
        recurseSubDirs: true,
      );

      Uint8List data = await zipFile.readAsBytes();
      await FileSaver.instance
          .saveAs('yoyaku_backup_$formatted', data, 'zip', MimeType.ZIP);
    }
  }

  Future<bool> importDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    final _localPath = await getApplicationDocumentsDirectory();
    final directory = _localPath.path;
    Directory destinationDir = await Directory(
      '$directory/import/temp',
    ).create(
      recursive: true,
    );

    final currentUuids = await _localDatabase.allItemUUIDs();

    if (result == null) {
      log('No File selected', name: 'ImportDatabase');
      Fluttertoast.showToast(
          msg: 'No file selected',
          backgroundColor: Colors.red,
          textColor: Colors.white);
      return false;
    }

    try {
      File zipFile = File(result.files.single.path as String);

      await ZipFile.extractToDirectory(
        zipFile: zipFile,
        destinationDir: destinationDir,
      );
    } on Exception {
      log('Failed Archive extracting', name: 'ImportDatabase');
      Fluttertoast.showToast(
        msg: 'Failed extracting archive',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    }

    try {
      String imagesPath = '$directory/import/temp/images';
      String dataPath = '$directory/import/temp/yoyaku_data.csv';

      File data = File(dataPath);
      String dataText = await data.readAsString();
      List<List<dynamic>> rows = const CsvToListConverter().convert(dataText);

      for (int i = 0; i < rows.length; i++) {
        List<dynamic> row = rows[i];

        if (!currentUuids.contains(row[1])) {
          File image = File('$imagesPath/${row[1]}.jpg');
          Uint8List imageBytes = await image.readAsBytes();

          await _localDatabase.addItem(
            ItemsCompanion(
              type: Value(row[2]),
              title: Value(row[3]),
              dateBought: Value(DateTime.parse(row[4])),
              releaseDate: Value(DateTime.parse(row[5])),
              currency: Value(row[6]),
              price: Value(row[7]),
              shipping: Value(row[8]),
              image: Value(imageBytes),
              link: Value(row[9]),
              paid: Value(row[12] == 'true'),
              delivered: Value(row[10] == 'true'),
              canceled: Value(row[13] == 'true'),
              import: Value(row[11] == 'true'),
              uuid: Value(row[1]),
            ),
          );
        }
      }
    } catch (e) {
      log('Failed Data parsing', name: 'ImportDatabase');
      print(Directory('$directory/import/temp').listSync());
      print(e);
      Fluttertoast.showToast(
        msg: 'Failed Getting data',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return false;
    } finally {
      await destinationDir.delete(recursive: true);
    }

    Fluttertoast.showToast(
      msg: 'Added items successfully',
      backgroundColor: Colors.green,
      textColor: Colors.white,
      gravity: ToastGravity.CENTER,
    );

    syncDatabase();
    return true;
  }

  void close() {
    _localDatabase.close();
  }

  void deleteItem(String uuid) {
    _localDatabase.deleteItem(uuid);
    syncDatabase();
  }

  void dropDatabase() {
    _localDatabase.deleteAllItems();
    syncDatabase();
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

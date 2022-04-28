import 'dart:developer';

import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/services/get_currency.dart';
import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

class ItemData {
  static double importPercentage = 4.7;
  static double handlingFee = 12;

  late String uuid;
  late String type;
  late String title;
  late String releaseDate;
  late String dateBought;
  late String currency;
  late String price;
  late String shipping;
  late Uint8List image;
  late String link;
  late bool paid;
  late bool delivered;
  late bool canceled;
  late bool import;
  late String daysSinceBought;
  late String daysUntilRelease;
  late String totalPrice;
  late Map exchangeRates;

  ItemData(Item data, rates) {
    exchangeRates = rates;
    uuid = data.uuid;
    type = ['Figure', 'Manga', 'Game', 'Other'][data.type];
    title = data.title;
    releaseDate = formatDate(data.releaseDate);
    dateBought = formatDate(data.dateBought);
    currency = getCurrency(data.currency);
    price = formatMoney(currency, data.price);
    shipping = formatMoney(currency, data.shipping);
    image = data.image;
    link = data.link;
    paid = data.paid;
    delivered = data.delivered;
    canceled = data.canceled;
    import = data.import;
    daysSinceBought = getDateDifferenceInDays(
      data.dateBought,
      DateTime.now(),
    );
    daysUntilRelease = getDateDifferenceInDays(
      DateTime.now(),
      data.releaseDate,
    );
    totalPrice = getTotalPrice(
      data.price,
      data.shipping,
      data.currency,
      data.import,
    );
  }

  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat.yMMMMd('en_US');
    String formatted = formatter.format(date);
    return formatted;
  }

  String formatMoney(String currency, double money) {
    return '$currency ${money.toStringAsFixed(2)}';
  }

  String getDateDifferenceInDays(DateTime date1, DateTime date2) {
    Duration difference = date1.difference(date2);
    int days = difference.inDays;
    if (days < 0) {
      return '0';
    }
    return days.toString();
  }

  double getEuro(double price, String currency) {
    try {
      return price / exchangeRates[currency];
    } catch (e) {
      log(e.toString());
    }

    return price;
  }

  String getTotalPrice(
      double price, double shipping, String currency, bool import) {
    var priceInEuro = getEuro(price, currency);
    var shippingInEuro = getEuro(shipping, currency);
    var totalPriceInEuro = priceInEuro + shippingInEuro;

    if (!import) {
      return '≈ €${totalPriceInEuro.toStringAsFixed(2)}';
    }

    double vat = totalPriceInEuro / 100 * 21;
    if (priceInEuro < 150) {
      double total = totalPriceInEuro + vat + handlingFee;
      return '≈ €${total.toStringAsFixed(2)}';
    } else {
      double importCost = totalPriceInEuro / 100 * importPercentage;
      double total = totalPriceInEuro + vat + importCost + handlingFee;
      return '≈ €${total.toStringAsFixed(2)}';
    }
  }
}

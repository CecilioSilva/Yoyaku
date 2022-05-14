import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemCostReceipt extends StatelessWidget {
  final double itemPrice;
  final double shippingPrice;
  final String currency;
  final bool import;

  const ItemCostReceipt({
    Key? key,
    required this.itemPrice,
    required this.shippingPrice,
    required this.currency,
    required this.import,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rates = context.watch<Map?>();
    double rate = rates![currency] ?? 1;
    final Size size = MediaQuery.of(context).size;

    final double fontSize = size.width * 0.06;

    if (import) {
      double total = (itemPrice + shippingPrice);
      double vat = (total / 100) * 21;
      bool isExpansive = !(total / rate < 150);

      double importc = isExpansive ? (total / 100) * 4.7 : 0;
      double handling = isExpansive ? 10 : 4;

      double vatCost = vat / rate;
      double totalCost = (total / rate) + (vat / rate) + (importc / rate);
      double itemCost = itemPrice / rate;
      double shippingCost = shippingPrice / rate;
      double handlingCost = handling;
      double importCost = (importc / rate);

      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ImportReceiptItem(
              title: 'Item Cost',
              value: itemPrice,
              eurValue: itemCost,
              fontSize: fontSize,
              currency: currency,
            ),
            ImportReceiptItem(
              title: 'Shipping',
              value: shippingPrice,
              eurValue: shippingCost,
              fontSize: fontSize,
              currency: currency,
            ),
            ImportReceiptItem(
              title: 'VAT(21%)',
              value: vat,
              eurValue: vatCost,
              fontSize: fontSize,
              currency: currency,
            ),
            ImportReceiptItem(
              title: 'Handling',
              value: handlingCost,
              eurValue: handlingCost,
              fontSize: fontSize,
              currency: 'EUR',
            ),
            ImportReceiptItem(
              title: 'Import Cost',
              value: importc,
              eurValue: importCost,
              fontSize: fontSize,
              currency: currency,
            ),
            TotalReceiptCost(
              value: totalCost,
              fontSize: fontSize + 2,
            ),
          ],
        ),
      );
    } else {
      final double totalCost = (itemPrice + shippingPrice) / rate;
      final double itemCost = itemPrice / rate;
      final double shippingCost = shippingPrice / rate;

      return SingleChildScrollView(
        child: Column(
          children: [
            NormalReceiptItem(
              title: 'Item Cost',
              value: itemCost,
              fontSize: fontSize,
            ),
            NormalReceiptItem(
              title: 'Shipping Cost',
              value: shippingCost,
              fontSize: fontSize,
            ),
            TotalReceiptCost(
              value: totalCost,
              fontSize: fontSize + 2,
            ),
          ],
        ),
      );
    }
  }
}

class NormalReceiptItem extends StatelessWidget {
  final String title;
  final double value;
  final double fontSize;
  final Color color;

  const NormalReceiptItem({
    Key? key,
    required this.title,
    required this.value,
    required this.fontSize,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title ',
          style: GoogleFonts.inconsolata(
            fontSize: fontSize,
            color: color,
          ),
        ),
        const Spacer(),
        Text(
          '€${(value).toStringAsFixed(2)}',
          style: GoogleFonts.inconsolata(
            fontSize: fontSize,
            color: color,
          ),
        )
      ],
    );
  }
}

class ImportReceiptItem extends StatelessWidget {
  final String title;
  final double value;
  final double eurValue;
  final double fontSize;
  final Color color;
  final String currency;

  const ImportReceiptItem({
    Key? key,
    required this.title,
    required this.value,
    required this.eurValue,
    required this.fontSize,
    required this.currency,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width * 0.285;

    return Row(
      children: [
        SizedBox(
          width: width,
          child: Text(
            '$title ',
            style: GoogleFonts.inconsolata(
              fontSize: fontSize - 2,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: Text(
            (value).toStringAsFixed(2),
            textAlign: TextAlign.end,
            style: GoogleFonts.inconsolata(
              fontSize: fontSize,
              color: color,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            currency,
            style: GoogleFonts.inconsolata(
              fontSize: fontSize,
              color: color,
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: Text(
            '€${(eurValue).toStringAsFixed(2)}',
            textAlign: TextAlign.end,
            style: GoogleFonts.inconsolata(
              fontSize: fontSize,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}

class TotalReceiptCost extends StatelessWidget {
  final double value;
  final double fontSize;
  final Color color;
  const TotalReceiptCost({
    Key? key,
    required this.value,
    required this.fontSize,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 100,
                height: 2,
                color: Colors.red,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Total Cost: ',
                style: GoogleFonts.inconsolata(
                  fontSize: fontSize,
                  color: color,
                ),
              ),
              const Spacer(),
              Text(
                '€${(value).toStringAsFixed(2)}',
                style: GoogleFonts.inconsolata(
                  fontSize: fontSize,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

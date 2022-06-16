import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/extras/custom_button.dar.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/pages/item_page.dart';

class OrderTotalScreen extends StatelessWidget {
  final String orderId;
  final List<Item> items;

  const OrderTotalScreen({
    Key? key,
    required this.orderId,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final rates = context.watch<Map?>();

    List<Widget> receiptItems = [];
    double total = 0;
    bool import = false;
    String link = "";

    for (var item in items) {
      ItemData itemData = ItemData(item, rates);
      receiptItems.add(ItemReceipt(
        title: itemData.title,
        eurValue: itemData.priceRaw,
        fontSize: size.width * 0.06,
        image: itemData.image,
        data: itemData,
      ));
      total += itemData.priceRaw;
      import = itemData.import;
      link = Uri.parse(itemData.link).host;
    }

    bool isExpansive = !(total < 150);

    double vat = (total / 100) * 21;
    double importc = isExpansive ? (total / 100) * 4.7 : 0;
    double handling = isExpansive ? 10 : 4;
    double totalCost = total + vat + importc + (import ? handling : 0);

    return Scaffold(
      backgroundColor: const Color(0xFF03071e),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
        ),
        backgroundColor: Colors.orange,
        title: FittedBox(
          child: Text(
            'Order: $orderId',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 3, color: Colors.orange),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageSlideshow(
                    height: size.width,
                    width: size.width,
                    indicatorColor: Colors.deepOrange,
                    indicatorBackgroundColor: const Color(0xFF03071e),
                    autoPlayInterval: 3000,
                    children: items
                        .map(
                          (e) => Image.memory(
                            e.image,
                            fit: BoxFit.cover,
                          ),
                        )
                        .toList(),
                    isLoop: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: receiptItems,
              ),
              TotalReceiptCost(
                fontSize: size.width * 0.06 + 2,
                value: total,
              ),
              const Divider(
                thickness: 4,
                color: Colors.purple,
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: import
                    ? [
                        ReceiptItem(
                          title: "VAT(21%)",
                          eurValue: vat,
                        ),
                        ReceiptItem(
                          title: "Handling",
                          eurValue: handling,
                        ),
                        ReceiptItem(
                          title: "Import Cost",
                          eurValue: importc,
                        ),
                        TotalReceiptCost(
                          value: totalCost,
                          fontSize: size.width * 0.06 + 2,
                        ),
                      ]
                    : [
                        TotalReceiptCost(
                          value: totalCost,
                          fontSize: size.width * 0.06 + 2,
                        ),
                      ],
              ),
              const SizedBox(
                height: 20,
              ),
              YoyakuButton(
                text: link,
                color: Colors.purple,
                onPressed: () async {
                  await launchUrlString(
                    'https://$link',
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ItemReceipt extends StatelessWidget {
  final String title;
  final double eurValue;
  final double fontSize;
  final Color color;
  final Uint8List image;
  final ItemData data;

  const ItemReceipt({
    Key? key,
    required this.title,
    required this.eurValue,
    required this.fontSize,
    required this.image,
    required this.data,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width * 0.24;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Size size = MediaQuery.of(context).size;
            showDialog(
              context: context,
              builder: (BuildContext context) => Hero(
                tag: data.uuid,
                child: Center(
                  child: SizedBox(
                    child: ClipRRect(
                      child: Image.memory(data.image),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: size.width * 0.8,
                    height: size.width * 0.8,
                  ),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: Hero(
              tag: title,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(
                      image,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) => ItemPage(data: data)),
                ),
              );
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  title,
                  style: GoogleFonts.inconsolata(
                    fontSize: 22,
                    color: Colors.amber.shade400,
                  ),
                ),
              ),
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
        ),
      ],
    );
  }
}

class ReceiptItem extends StatelessWidget {
  final String title;
  final double eurValue;
  final Color color;

  const ReceiptItem({
    Key? key,
    required this.title,
    required this.eurValue,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double width = size.width * 0.24;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: GoogleFonts.inconsolata(
                fontSize: 22,
                color: color,
              ),
            ),
          ),
        ),
        SizedBox(
          width: width,
          child: Text(
            '€${(eurValue).toStringAsFixed(2)}',
            textAlign: TextAlign.end,
            style: GoogleFonts.inconsolata(
              fontSize: size.width * 0.06,
              color: color,
            ),
          ),
        ),
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

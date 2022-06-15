import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/cards/item_gridcard_mini.dart';
import 'package:yoyaku/components/extras/custom_button.dar.dart';
import 'package:yoyaku/components/extras/custom_error.dart';
import 'package:yoyaku/components/extras/loading.dart';
import 'package:yoyaku/components/extras/non_found.dart';
import 'package:yoyaku/models/database_model.dart';

class OrderView extends StatefulWidget {
  final Future<Map<String, List<Item>>> itemFuture;

  const OrderView({Key? key, required this.itemFuture}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final List<bool> _isOpen = [];

  List<ExpansionPanel> getExpansionPanels(List keyList, dynamic data) {
    List<ExpansionPanel> panels = [];
    var size = MediaQuery.of(context).size;
    final rates = context.watch<Map?>();
    for (var i = 0; i < keyList.length; i++) {
      _isOpen.add(true);
      List<Item> itemList = data[i];
      double totalCost = 0;

      for (var i = 0; i < itemList.length; i++) {
        Item element = itemList[i];
        totalCost += ItemData(element, rates).priceRaw;
      }

      panels.add(
        ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: const Color(0xFF03071e),
          headerBuilder: ((context, isExpanded) => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Order: ${keyList[i]}",
                      style: TextStyle(
                        color: isExpanded ? Colors.orange : Colors.red,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '≈ € ${totalCost.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ],
              )),
          body: Column(
            children: [
              SizedBox(
                height: size.height * 0.15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, itemIndex) {
                    Item item = itemList[itemIndex];
                    ItemData data = ItemData(item, rates);
                    return ItemGridMiniCard(data);
                  },
                ),
              ),
              YoyakuButton(
                text: "Open Order",
                onPressed: () {},
                color: Colors.pink,
              ),
            ],
          ),
          isExpanded: _isOpen[i],
        ),
      );
    }

    return panels;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<Map<String, List<Item>>>(
      future: widget.itemFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot<Map<String, List<Item>>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return CustomError(error: snapshot.error);
          } else if (snapshot.hasData) {
            List keyList = snapshot.data!.keys.toList();

            if (keyList.isEmpty) return const NonFound();

            return RefreshIndicator(
              backgroundColor: const Color(0xFF03071e),
              color: Colors.orange,
              onRefresh: () async {
                setState(() {});
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 10,
                        right: 8,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Orders',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: size.width * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ExpansionPanelList(
                        dividerColor: Colors.orange,
                        elevation: 0,
                        animationDuration: const Duration(milliseconds: 800),
                        children: getExpansionPanels(
                          keyList,
                          snapshot.data!.values.toList(),
                        ),
                        expansionCallback: (i, isOpen) => setState(() {
                          _isOpen[i] = !isOpen;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const NonFound();
          }
        } else {
          return const Loading();
        }
      },
    );
  }
}

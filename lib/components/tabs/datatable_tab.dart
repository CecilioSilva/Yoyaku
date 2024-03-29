import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/extras/type_tag.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/pages/item_page.dart';
import 'package:yoyaku/pages/update_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DatatableTab extends StatefulWidget {
  const DatatableTab({Key? key}) : super(key: key);

  @override
  State<DatatableTab> createState() => _DatatableTabState();
}

class _DatatableTabState extends State<DatatableTab> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return FutureBuilder<List<Item>>(
      future: Provider.of<DataSync>(context).getAllItems,
      initialData: const [],
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 10,
                  right: 8,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      'Datatable',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('#')),
                        DataColumn(label: Text('Image')),
                        DataColumn(label: Text('Title')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Total Price')),
                        DataColumn(label: Text('Release Date')),
                        DataColumn(label: Text('Date Bought')),
                        DataColumn(
                          label: Text('Days until Release'),
                          numeric: true,
                        ),
                        DataColumn(label: Text('Paid')),
                        DataColumn(label: Text('Delivered')),
                        DataColumn(label: Text('Canceled')),
                        DataColumn(label: Text('Import')),
                        DataColumn(label: Text('Link')),
                        DataColumn(label: Text('Order Id')),
                        DataColumn(
                          label: Text('Days since Bought'),
                          numeric: true,
                        ),
                        DataColumn(
                          label: Text('Price'),
                          numeric: true,
                        ),
                        DataColumn(
                          label: Text('Shipping'),
                          numeric: true,
                        ),
                        DataColumn(label: Text('Edit')),
                      ],
                      rows: getDataRows(context, snapshot.data),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  List<DataRow> getDataRows(BuildContext context, List<Item>? data) {
    int count = 0;
    return data!.map(
      (e) {
        count += 1;
        bool isAlternate = count % 2 == 0;

        final rates = context.watch<Map?>();
        ItemData data = ItemData(e, rates);
        return DataRow(
          onLongPress: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => ItemPage(data: data)),
              ),
            );
          },
          color: MaterialStateProperty.all(
            isAlternate ? Colors.transparent : Colors.orange.withOpacity(0.1),
          ),
          cells: [
            DataCell(
              Text(
                data.id.toString(),
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 18,
                ),
              ),
            ),
            DataCell(
              Hero(
                tag: data.title,
                child: Image.memory(data.image, width: 50, height: 50),
              ),
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
            ),
            DataCell(
              Text(
                data.title,
                style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            DataCell(TypeTag(data.type)),
            DataCell(Text(
              data.totalPrice,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 18,
              ),
            )),
            DataCell(Text(data.releaseDate)),
            DataCell(Text(data.dateBought)),
            DataCell(Text(data.daysUntilRelease)),
            DataCell(Checkbox(
              value: data.paid,
              onChanged: (value) {},
              checkColor: Colors.white,
              activeColor: Colors.redAccent,
            )),
            DataCell(Checkbox(
              value: data.delivered,
              onChanged: (value) {},
              checkColor: Colors.white,
              activeColor: Colors.redAccent,
            )),
            DataCell(Checkbox(
              value: data.canceled,
              onChanged: (value) {},
              checkColor: Colors.white,
              activeColor: Colors.redAccent,
            )),
            DataCell(Checkbox(
              value: data.import,
              onChanged: (value) {},
              checkColor: Colors.white,
              activeColor: Colors.redAccent,
            )),
            DataCell(
              GestureDetector(
                onTap: () async {
                  await launchUrlString(
                    data.link,
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Text(
                  Uri.parse(data.link).host,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            DataCell(Text(data.orderId)),
            DataCell(Text(data.daysSinceBought)),
            DataCell(Text(data.price)),
            DataCell(Text(data.shipping)),
            DataCell(
              IconButton(
                onPressed: () async {
                  Item item =
                      await Provider.of<DataSync>(context, listen: false)
                          .getItemById(
                    data.uuid,
                  );

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => UpdatePage(item: item)),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        );
      },
    ).toList();
  }
}

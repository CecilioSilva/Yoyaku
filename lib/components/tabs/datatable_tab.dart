import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/classes/item_data.dart';
import 'package:yoyaku/components/extras/type_tag.dart';
import 'package:yoyaku/models/database_model.dart';
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
  int rowCount = -1;

  @override
  Widget build(BuildContext context) {
    rowCount = -1;

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
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Image')),
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Release Date')),
                      DataColumn(label: Text('Date Bought')),
                      DataColumn(label: Text('Total Price')),
                      DataColumn(
                        label: Text('Days until Release'),
                        numeric: true,
                      ),
                      DataColumn(label: Text('Paid')),
                      DataColumn(label: Text('Delivered')),
                      DataColumn(label: Text('Canceled')),
                      DataColumn(label: Text('Import')),
                      DataColumn(label: Text('Link')),
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
            ],
          );
        }
      }),
    );
  }

  List<DataRow> getDataRows(BuildContext context, List<Item>? data) {
    return data!.map(
      (e) {
        final rates = context.watch<Map?>();
        ItemData data = ItemData(e, rates);
        return DataRow(
          cells: [
            DataCell(Image.memory(data.image, width: 50, height: 50)),
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
            DataCell(Text(data.releaseDate)),
            DataCell(Text(data.dateBought)),
            DataCell(Text(
              data.totalPrice,
              style: const TextStyle(
                color: Colors.green,
                fontSize: 18,
              ),
            )),
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
                  await launchUrlString(data.link);
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
            DataCell(Text(data.daysSinceBought)),
            DataCell(Text(data.price)),
            DataCell(Text(data.shipping)),
            DataCell(IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => UpdatePage(uuid: data.uuid)),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.orange,
              ),
            )),
          ],
        );
      },
    ).toList();
  }
}

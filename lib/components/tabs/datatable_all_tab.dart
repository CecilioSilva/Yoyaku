import 'package:amiamu/classes/data_sync.dart';
import 'package:amiamu/classes/item_data.dart';
import 'package:amiamu/components/type_tag.dart';
import 'package:amiamu/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DatatableTab extends StatelessWidget {
  const DatatableTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
      future: Provider.of<DataSync>(context).getAllItems,
      initialData: [],
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Image')),
                DataColumn(label: Text('Title')),
                DataColumn(label: Text('Type')),
                DataColumn(label: Text('Release Date')),
                DataColumn(label: Text('Date Bought')),
                DataColumn(label: Text('Total Price')),
                DataColumn(label: Text('Days until Release')),
                DataColumn(label: Text('Paid')),
                DataColumn(label: Text('Delivered')),
                DataColumn(label: Text('Canceled')),
                DataColumn(label: Text('Import')),
                DataColumn(label: Text('Link')),
                DataColumn(label: Text('Days since Bought')),
                DataColumn(label: Text('Price')),
                DataColumn(label: Text('Shipping')),
                DataColumn(label: Text('Edit')),
              ],
              rows: snapshot.data!.map(
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
                          //TODO: Add Item Editing
                          print('Editing ${data.uuid}');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.orange,
                        ),
                      )),
                    ],
                  );
                },
              ).toList(),
            ),
          );
        }
      }),
    );
  }
}

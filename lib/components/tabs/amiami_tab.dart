import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:yoyaku/classes/amiami_api.dart';
import 'package:yoyaku/components/extras/loading.dart';
import 'package:yoyaku/components/extras/non_found.dart';
import 'package:yoyaku/components/form_fields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:yoyaku/models/database_model.dart';
import 'package:yoyaku/pages/amiami_add_page.dart';

class AmiAmiTab extends StatefulWidget {
  const AmiAmiTab({Key? key}) : super(key: key);

  @override
  State<AmiAmiTab> createState() => _AmiAmiTabState();
}

class _AmiAmiTabState extends State<AmiAmiTab> {
  String _searchQuery = '';
  List<AmiAmiItem> _items = [];

  bool loading = false;
  bool loadingItem = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Visibility(
                visible: !loadingItem,
                child: Column(
                  children: [
                    CustomTextFormField(
                      title: 'Search AmiAmi',
                      onChanged: (value) => setState(() {
                        _searchQuery = value;
                      }),
                      initialValue: _searchQuery,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4,
                        right: 4,
                        top: 4,
                        bottom: 30.0,
                      ),
                      child: SizedBox(
                        width: size.width,
                        height: size.width * 0.15,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              !loading ? Colors.red : Colors.grey,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            try {
                              AmiAmiResultSet? result = await searchAmiAmi(
                                _searchQuery,
                              );
                              if (result != null) {
                                _items = result.items;
                              } else {
                                _items = [];
                                Fluttertoast.showToast(
                                  msg: 'Timedout',
                                  gravity: ToastGravity.CENTER,
                                );
                              }
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: 'Error searching',
                                gravity: ToastGravity.CENTER,
                              );
                              _searchQuery = '';
                            }

                            loading = false;
                            setState(() {});
                          },
                          child: const Text(
                            'Search AmiAmi',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _items.isNotEmpty && !loading && !loadingItem,
                child: Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: size.width,
                          height: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.orange),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_items[index].imageUrl),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                        color: Colors.orange,
                                      ),
                                      width: 45,
                                      height: 45,
                                      child: IconButton(
                                        onPressed: () async {
                                          AmiAmiItem amiItem = _items[index];

                                          final item = Item(
                                            id: 0,
                                            uuid: '',
                                            type: 0,
                                            title: amiItem.productName,
                                            dateBought: DateTime.now(),
                                            releaseDate: amiItem.releaseDate,
                                            currency: 'JPY',
                                            price: double.parse(amiItem.price),
                                            shipping: 0,
                                            image: await getNetworkImageBytes(
                                                  amiItem.imageUrl,
                                                ) ??
                                                Uint8List(1),
                                            link: amiItem.productUrl,
                                            delivered: false,
                                            import: true,
                                            paid: false,
                                            canceled: false,
                                          );

                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: ((context) =>
                                                  AmiAmiAddPage(
                                                    item: item,
                                                  )),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: !loading && _items.isEmpty,
                child: const NonFound(),
              ),
              Center(
                child: Visibility(
                  child: const Loading(),
                  visible: loading || loadingItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Uint8List?> getNetworkImageBytes(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  } catch (_) {
    return null;
  }
}

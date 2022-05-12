import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/extras/custom_button.dar.dart';
import 'package:yoyaku/components/form_fields/custom_checkbox_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_datepicker_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_dropdown_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_imagepicker_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_number_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_text_form_field.dart';
import 'package:yoyaku/models/database_model.dart';

class AmiAmiAddPage extends StatefulWidget {
  final Item item;

  const AmiAmiAddPage({Key? key, required this.item}) : super(key: key);

  @override
  State<AmiAmiAddPage> createState() => _AmiAmiAddPageState();
}

class _AmiAmiAddPageState extends State<AmiAmiAddPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  int _type = 0;
  DateTime _dateBought = DateTime.now();
  DateTime _releaseDate = DateTime.now();
  String _currency = 'EUR';
  double _price = 0;
  double _shipping = 0;
  Uint8List? _image;
  String _link = '';
  bool _delivered = false;
  bool _paid = false;
  bool _canceled = false;
  bool _import = false;

  @override
  void initState() {
    super.initState();

    _title = widget.item.title;
    _type = widget.item.type;
    _dateBought = widget.item.dateBought;
    _releaseDate = widget.item.releaseDate;
    _currency = widget.item.currency;
    _price = widget.item.price;
    _shipping = widget.item.shipping;
    _image = widget.item.image;
    _link = widget.item.link;
    _delivered = widget.item.delivered;
    _paid = widget.item.paid;
    _canceled = widget.item.canceled;
    _import = widget.item.import;
  }

  bool validateForm() {
    if (_title == '') {
      Fluttertoast.showToast(
        msg: 'Please fill in a title',
        gravity: ToastGravity.CENTER,
      );
      return false;
    } else if (_image == null) {
      Fluttertoast.showToast(
        msg: 'Please select an image',
        gravity: ToastGravity.CENTER,
      );
      return false;
    } else if (_link == '') {
      Fluttertoast.showToast(
        msg: 'Please fill in a link',
        gravity: ToastGravity.CENTER,
      );
      return false;
    } else {
      try {
        Uri.parse(_link);
        return true;
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Please fill in a valid link',
          gravity: ToastGravity.CENTER,
        );
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataSync = Provider.of<DataSync>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF03071e),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
        ),
        backgroundColor: Colors.orange,
        title: const Text('Add AmiAmi Item'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      CustomTextFormField(
                        title: 'Title',
                        onChanged: (value) => _title = value,
                        initialValue: _title,
                      ),
                      CustomDropDownField(
                        title: 'Type',
                        initalValue: _type.toString(),
                        items: [
                          CustomDropdownValue(value: '0', name: 'Figure'),
                          CustomDropdownValue(value: '1', name: 'Manga'),
                          CustomDropdownValue(value: '2', name: 'Game'),
                          CustomDropdownValue(value: '3', name: 'Other'),
                        ],
                        onChanged: (value) {
                          _type = int.parse(value!);
                        },
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomDatePickerFormField(
                              initialValue: _dateBought,
                              title: 'Date Bought',
                              onChanged: (DateTime date) {
                                _dateBought = date;
                              },
                            ),
                            CustomDatePickerFormField(
                              initialValue: _releaseDate,
                              title: 'Release Date',
                              onChanged: (DateTime date) {
                                _releaseDate = date;
                              },
                            ),
                          ],
                        ),
                      ),
                      CustomDropDownField(
                        title: 'Currency',
                        initalValue: _currency,
                        items: [
                          CustomDropdownValue(value: 'JPY', name: 'JPY'),
                          CustomDropdownValue(value: 'EUR', name: 'EUR'),
                          CustomDropdownValue(value: 'USD', name: 'USD'),
                          CustomDropdownValue(value: 'GBP', name: 'GBP'),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _currency = value!;
                          });
                        },
                      ),
                      CustomNumberFormField(
                        title: 'Price',
                        onChanged: (value) => _price = value,
                        initialValue: _price,
                        currency: _currency,
                      ),
                      CustomNumberFormField(
                        title: 'Shipping',
                        onChanged: (value) => _shipping = value,
                        initialValue: _shipping,
                        currency: _currency,
                      ),
                      CustomImageFormField(
                        initialValue: _image,
                        title: 'Image',
                        onChanged: (Uint8List value) {
                          _image = value;
                        },
                      ),
                      CustomTextFormField(
                        title: 'Link',
                        onChanged: (value) {
                          _link = value;
                        },
                        initialValue: _link,
                      ),
                      CustomCheckboxFormField(
                        title: 'Delivered',
                        onChanged: (value) {
                          _delivered = value;
                        },
                        initalValue: _delivered,
                      ),
                      CustomCheckboxFormField(
                        title: 'Paid',
                        onChanged: (value) {
                          _paid = value;
                        },
                        initalValue: _paid,
                      ),
                      CustomCheckboxFormField(
                        title: 'Canceled',
                        onChanged: (value) {
                          _canceled = value;
                        },
                        initalValue: _canceled,
                      ),
                      CustomCheckboxFormField(
                        title: 'Import',
                        onChanged: (value) {
                          _import = value;
                        },
                        initalValue: _import,
                      ),
                      YoyakuButton(
                        text: 'Add Item',
                        onPressed: () {
                          if (!validateForm()) return;

                          dataSync.addItem(
                            type: _type,
                            title: _title,
                            dateBought: _dateBought,
                            releaseDate: _releaseDate,
                            currency: _currency,
                            price: _price,
                            shipping: _shipping,
                            image: _image!,
                            link: _link,
                            paid: _paid,
                            delivered: _delivered,
                            canceled: _canceled,
                            import: _import,
                          );

                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

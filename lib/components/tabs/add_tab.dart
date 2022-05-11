import 'dart:typed_data';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/form_fields/custom_checkbox_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_datepicker_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_dropdown_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_imagepicker_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_number_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddTab extends StatefulWidget {
  const AddTab({Key? key}) : super(key: key);

  @override
  State<AddTab> createState() => _AddTabState();
}

class _AddTabState extends State<AddTab> {
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

    return Padding(
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
                            title: 'Date Bought',
                            onChanged: (DateTime date) {
                              _dateBought = date;
                            },
                          ),
                          CustomDatePickerFormField(
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
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                          ),
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
                          child: const Text(
                            'Add item',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

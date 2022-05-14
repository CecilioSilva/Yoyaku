import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/components/extras/item_cost_reciept.dart';
import 'package:yoyaku/components/form_fields/custom_checkbox_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_dropdown_form_field.dart';
import 'package:yoyaku/components/form_fields/custom_number_form_field.dart';
import 'package:yoyaku/services/get_currency.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  double _itemPrice = 0;
  double _shippingPrice = 0;
  String _currency = 'EUR';
  bool _import = true;

  @override
  Widget build(BuildContext context) {
    final rates = context.watch<Map?>();

    return Scaffold(
      backgroundColor: const Color(0xFF03071e),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
        ),
        backgroundColor: Colors.orange,
        title: const FittedBox(
          child: Text(
            'Invoer Calculator',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  ItemCostReceipt(
                    itemPrice: _itemPrice,
                    shippingPrice: _shippingPrice,
                    currency: _currency,
                    import: _import,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    children: [
                      Visibility(
                        visible: _import,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CustomDropDownField(
                                initalValue: _currency,
                                title: 'Currency',
                                items: [
                                  CustomDropdownValue(
                                      value: 'JPY', name: 'JPY'),
                                  CustomDropdownValue(
                                      value: 'EUR', name: 'EUR'),
                                  CustomDropdownValue(
                                      value: 'USD', name: 'USD'),
                                  CustomDropdownValue(
                                      value: 'GBP', name: 'GBP'),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _currency = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  child: Center(
                                    child: Text(
                                      '€ 1 = ${getCurrency(_currency)} ${rates![_currency] ?? 1}',
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomNumberFormField(
                        title: 'Item Price',
                        onChanged: (value) {
                          setState(() {
                            _itemPrice = value;
                          });
                        },
                        initialValue: _itemPrice,
                        currency: _currency,
                      ),
                      CustomNumberFormField(
                        title: 'Shipping Cost',
                        onChanged: (value) {
                          setState(() {
                            _shippingPrice = value;
                          });
                        },
                        initialValue: _shippingPrice,
                        currency: _currency,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomCheckboxFormField(
                            title: 'Import',
                            onChanged: (value) {
                              setState(() {
                                _import = value;
                                if (!value) {
                                  _currency = 'EUR';
                                }
                              });
                            },
                            initalValue: _import,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

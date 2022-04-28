import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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

  Widget getCalculation() {
    final rates = context.watch<Map?>();
    double rate = rates![_currency] ?? 1;

    if (!_import) {
      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  'Total Cost: €${((_itemPrice + _shippingPrice) / rate).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 35,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  'Item Cost: €${(_itemPrice / rate).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 35,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  'Shipping Cost: €${(_shippingPrice / rate).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      double total = (_itemPrice + _shippingPrice) / rate;
      double vat = (total / 100) * 21;
      double handlingFee = 12;
      double importCost = 0;

      if (!(total < 150)) {
        importCost = (total / 100) * 4.7;
      }

      return SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: Text(
                  'Total Cost: €${((total + vat + handlingFee + importCost).toStringAsFixed(2))} ',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 35,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  'Item Cost: €${(_itemPrice / rate).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 35,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  'Shipping Cost: €${(_shippingPrice / rate).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 35,
                  ),
                ),
              ),
              FittedBox(
                child: Text(
                  'VAT(21%): €${(vat).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 35,
                  ),
                ),
              ),
              Text(
                'Handling Fee: €${(handlingFee).toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.pink,
                  fontSize: 35,
                ),
              ),
              Text(
                'Import Cost: €${(importCost).toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.purple,
                  fontSize: 35,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCalculation(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomDropDownField(
                    initalValue: _currency,
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
                    });
                  },
                  initalValue: _import,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

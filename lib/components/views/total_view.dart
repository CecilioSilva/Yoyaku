import 'package:flutter/material.dart';
import 'package:yoyaku/classes/total_data.dart';
import 'package:yoyaku/components/extras/custom_error.dart';
import 'package:yoyaku/components/extras/loading.dart';
import 'package:yoyaku/components/extras/non_found.dart';

class TotalView extends StatelessWidget {
  final Future<TotalData> totalFuture;
  const TotalView({Key? key, required this.totalFuture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
                'Total',
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
          child: FutureBuilder<TotalData>(
            future: totalFuture,
            builder: (BuildContext context, AsyncSnapshot<TotalData> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return CustomError(error: snapshot.error);
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                          child: Row(children: [
                        customCard(
                          'Total Spend',
                          '€ ${snapshot.data!.totalSpend.toStringAsFixed(2)}',
                          context,
                        ),
                      ])),
                      Expanded(
                          child: Row(
                        children: [
                          customCard(
                            'Total Debt',
                            '€ ${snapshot.data!.totalDebt.toStringAsFixed(2)}',
                            context,
                          ),
                          customCard(
                            'Total Collection',
                            '€ ${snapshot.data!.totalCollection.toStringAsFixed(2)}',
                            context,
                          ),
                        ],
                      )),
                      Expanded(
                        child: Row(
                          children: [
                            customCard(
                                'Total Price',
                                '€ ${snapshot.data!.totalPrice.toStringAsFixed(2)}',
                                context),
                            customCard(
                                'Total Shipping',
                                '€ ${snapshot.data!.totalShipping.toStringAsFixed(2)}',
                                context),
                            customCard(
                                'Total Vat',
                                '€ ${snapshot.data!.totalVat.toStringAsFixed(2)}',
                                context),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            customCard(
                              'Total Orders',
                              '${snapshot.data!.totalOrders}',
                              context,
                            ),
                            customCard(
                              'Import Amount',
                              '${snapshot.data!.importAmount}',
                              context,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            customCard(
                              'Figures',
                              '${snapshot.data!.figureAmount}',
                              context,
                            ),
                            customCard(
                              'Manga',
                              '${snapshot.data!.mangaAmount}',
                              context,
                            ),
                            customCard(
                              'Games',
                              '${snapshot.data!.gameAmount}',
                              context,
                            ),
                            customCard(
                              'Other',
                              '${snapshot.data!.otherAmount}',
                              context,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                    ],
                  );
                } else {
                  return const NonFound();
                }
              } else {
                return const Loading();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget customCard(String title, String value, context) {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Color.fromARGB(255, 5, 12, 49),
            gradient: const LinearGradient(
              colors: [
                Colors.orange,
                Colors.orangeAccent,
                Colors.red,
                Colors.redAccent
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 0.2, 0.5, 0.8],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    value,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 5, 12, 49),
                      fontSize: size.width * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FittedBox(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

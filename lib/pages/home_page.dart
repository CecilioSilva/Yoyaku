import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yoyaku/components/tabs/calendar_tab.dart';
import 'package:yoyaku/components/tabs/category_tab.dart';
import 'package:yoyaku/components/tabs/collection_tab.dart';
import 'package:yoyaku/components/tabs/datatable_tab.dart';
import 'package:yoyaku/components/tabs/gallery_tab.dart';
import 'package:yoyaku/components/tabs/items_tab.dart';
import 'package:yoyaku/components/tabs/montly_tab.dart';
import 'package:yoyaku/components/tabs/total_tab.dart';
import 'package:yoyaku/components/tabs/upcomming_items_tab.dart';
import 'package:yoyaku/components/tabs/all_tab.dart';
import 'package:yoyaku/components/tabs/canceled_items_tab.dart';
import 'package:yoyaku/components/tabs/upcomming_payments.dart';
import 'package:yoyaku/pages/calculator_page.dart';
import 'package:yoyaku/pages/util_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<Widget>> tabs = const [
    [Tab(icon: Icon(Icons.list_alt)), AllTab()],
    [Tab(icon: Icon(Icons.calendar_today_rounded)), CalendarTab()],
    [Tab(icon: Icon(Icons.local_shipping)), UpcommingTab()],
    [Tab(icon: Icon(Icons.payment)), UpcommingPaymentTab()],
    [Tab(icon: Icon(Icons.image_outlined)), GalleryTab()],
    [Tab(icon: Icon(Icons.calendar_month)), MontlyTab()],
    [Tab(icon: Icon(Icons.collections_bookmark)), CollectionTab()],
    [Tab(icon: Icon(Icons.category)), CategoryTab()],
    [Tab(icon: Icon(Icons.receipt_long)), TotalTab()],
    [Tab(icon: Icon(Icons.cancel_outlined)), CanceledTab()],
    [Tab(icon: Icon(Icons.select_all)), ItemsTab()],
    [Tab(icon: Icon(Icons.data_object_rounded)), DatatableTab()],
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: const Color(0xFF03071e),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.orange,
          ),
          backgroundColor: Colors.orange,
          title: const Text('Yoyaku'),
          centerTitle: true,
          bottom: TabBar(
            isScrollable: true,
            indicatorColor: Colors.red,
            indicatorWeight: 3,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey.shade300,
            tabs: tabs.map((e) => e[0]).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((e) => e[1]).toList(),
        ),
        floatingActionButton: SpeedDial(
          buttonSize: const Size(65, 65),
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(
            size: 30,
            color: Colors.white,
          ),
          overlayOpacity: 0.5,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              labelBackgroundColor: Colors.red,
              label: 'Add Item',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UtilPage(),
                  ),
                );
              },
            ),
            SpeedDialChild(
              backgroundColor: Colors.orangeAccent,
              child: const Icon(
                Icons.calculate_outlined,
                color: Colors.white,
              ),
              labelBackgroundColor: Colors.orangeAccent,
              label: 'Calculator',
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalculatorPage(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

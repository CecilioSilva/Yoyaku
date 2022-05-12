import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:yoyaku/classes/yoyaku_tab.dart';
import 'package:yoyaku/components/extras/custom_speed_dial_child.dart';
import 'package:yoyaku/components/tabs/all_tab.dart';
import 'package:yoyaku/components/tabs/calendar_tab.dart';
import 'package:yoyaku/components/tabs/canceled_items_tab.dart';
import 'package:yoyaku/components/tabs/category_tab.dart';
import 'package:yoyaku/components/tabs/collection_tab.dart';
import 'package:yoyaku/components/tabs/datatable_tab.dart';
import 'package:yoyaku/components/tabs/gallery_tab.dart';
import 'package:yoyaku/components/tabs/items_tab.dart';
import 'package:yoyaku/components/tabs/montly_tab.dart';
import 'package:yoyaku/components/tabs/total_tab.dart';
import 'package:yoyaku/components/tabs/upcomming_items_tab.dart';
import 'package:yoyaku/components/tabs/upcomming_payments.dart';
import 'package:yoyaku/pages/calculator_page.dart';
import 'package:yoyaku/pages/settings_page.dart';
import 'package:yoyaku/pages/util_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<YoyakuTab> tabs = [
    YoyakuTab(Icons.list_alt, const AllTab()),
    YoyakuTab(Icons.calendar_today_rounded, const CalendarTab()),
    YoyakuTab(Icons.local_shipping, const UpcommingTab()),
    YoyakuTab(Icons.payment, const UpcommingPaymentTab()),
    YoyakuTab(Icons.image_outlined, const GalleryTab()),
    YoyakuTab(Icons.calendar_month, const MontlyTab()),
    YoyakuTab(Icons.collections_bookmark, const CollectionTab()),
    YoyakuTab(Icons.category, const CategoryTab()),
    YoyakuTab(Icons.receipt_long, const TotalTab()),
    YoyakuTab(Icons.cancel_outlined, const CanceledTab()),
    YoyakuTab(Icons.select_all, const ItemsTab()),
    YoyakuTab(Icons.data_object_rounded, const DatatableTab()),
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
            tabs: tabs.map((e) => e.getHeader).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((e) => e.getTab).toList(),
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
            customSpeedDialChild(
              context,
              Colors.red,
              Icons.add,
              'Add item',
              const UtilPage(),
            ),
            customSpeedDialChild(
              context,
              Colors.orangeAccent,
              Icons.calculate_outlined,
              'Calculator',
              const CalculatorPage(),
            ),
            customSpeedDialChild(
              context,
              Colors.pink.shade700,
              Icons.settings,
              'Settings',
              const SettingsPage(),
            ),
          ],
        ),
      ),
    );
  }
}

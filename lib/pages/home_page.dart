import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/yoyaku_tab.dart';
import 'package:yoyaku/components/extras/custom_speed_dial_child.dart';
import 'package:yoyaku/components/extras/navigation_drawer.dart';
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

import '../classes/data_sync.dart';
import '../classes/item_data.dart';
import '../services/get_exchange_rate.dart';
import '../services/notification_api.dart';
import 'item_page.dart';

class HomePage extends StatefulWidget {
  final int initalIndex;
  const HomePage({Key? key, this.initalIndex = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<YoyakuTab> tabs = [
    YoyakuTab(
      Icons.list_alt,
      const AllTab(),
      'All Active Items',
    ),
    YoyakuTab(
      Icons.calendar_today_rounded,
      const CalendarTab(),
      'Calendar',
    ),
    YoyakuTab(
      Icons.local_shipping,
      const UpcommingTab(),
      'Upcoming Items',
    ),
    YoyakuTab(
      Icons.payment,
      const UpcommingPaymentTab(),
      'Upcoming Payments',
    ),
    YoyakuTab(
      Icons.image_outlined,
      const GalleryTab(),
      'Item Gallery',
    ),
    YoyakuTab(
      Icons.calendar_month,
      const MontlyTab(),
      'Montly Items',
    ),
    YoyakuTab(
      Icons.collections_bookmark,
      const CollectionTab(),
      'Current Collection',
    ),
    YoyakuTab(
      Icons.category,
      const CategoryTab(),
      'Item Categories',
    ),
    YoyakuTab(
      Icons.receipt_long,
      const TotalTab(),
      'Total statistics',
    ),
    YoyakuTab(
      Icons.cancel_outlined,
      const CanceledTab(),
      'Canceled Items',
    ),
    YoyakuTab(
      Icons.select_all,
      const ItemsTab(),
      'All Items',
    ),
    YoyakuTab(
      Icons.data_object_rounded,
      const DatatableTab(),
      'Item Datatable',
    ),
  ];

  @override
  void initState() {
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      final data = await Provider.of<DataSync>(context, listen: false)
          .getItemById(payload);

      final rates = await getExchange();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => ItemPage(data: ItemData(data, rates))),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.initalIndex,
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
        drawer: NavigationDrawerWidget(
          items: tabs,
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

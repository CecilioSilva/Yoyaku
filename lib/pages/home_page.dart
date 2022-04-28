import 'package:amiamu/components/tabs/calendar_tab.dart';
import 'package:amiamu/components/tabs/datatable_all_tab.dart';
import 'package:amiamu/components/tabs/gridview_all_tab.dart';
import 'package:amiamu/components/tabs/gridview_upcomming.dart';
import 'package:amiamu/components/tabs/listview_all_tab.dart';
import 'package:amiamu/components/tabs/listview_canceled_tab.dart';
import 'package:amiamu/pages/util_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<Widget>> tabs = const [
    [Tab(icon: Icon(Icons.list_alt)), ListViewTab()],
    [Tab(icon: Icon(Icons.apps)), GridViewTab()],
    [Tab(icon: Icon(Icons.calendar_today_rounded)), CalendarTab()],
    [Tab(icon: Icon(Icons.cancel_outlined)), ListViewCanceledTab()],
    [Tab(icon: Icon(Icons.local_shipping)), GridViewUpcommingTab()],
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
          title: const Text('AmiAmu'),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.red,
            tabs: tabs.map((e) => e[0]).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((e) => e[1]).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UtilPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

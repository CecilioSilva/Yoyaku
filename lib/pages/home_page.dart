import 'package:amiamu/components/tabs/calendar_tab.dart';
import 'package:amiamu/components/tabs/datatable_all_tab.dart';
import 'package:amiamu/components/tabs/gridview_all_tab.dart';
import 'package:amiamu/components/tabs/listview_all_tab.dart';
import 'package:amiamu/pages/util_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFF03071e),
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.orange,
          ),
          backgroundColor: Colors.orange,
          title: const Text('AmiAmu'),
          centerTitle: true,
          bottom: const TabBar(
            indicatorColor: Colors.red,
            tabs: [
              Tab(icon: Icon(Icons.list_alt)),
              Tab(icon: Icon(Icons.calendar_today_rounded)),
              Tab(icon: Icon(Icons.grid_3x3)),
              Tab(icon: Icon(Icons.data_object_rounded)),
            ],
          ),
        ),
        body: const TabBarView(children: [
          ListViewTab(),
          CalendarTab(),
          GridViewTab(),
          DatatableTab(),
        ]),
        floatingActionButton: FloatingActionButton(
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

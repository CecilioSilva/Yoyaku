import 'package:yoyaku/components/tabs/add_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UtilPage extends StatefulWidget {
  const UtilPage({Key? key}) : super(key: key);

  @override
  State<UtilPage> createState() => _UtilPageState();
}

class _UtilPageState extends State<UtilPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
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
              Tab(icon: Icon(Icons.add)),
            ],
          ),
        ),
        body: const TabBarView(children: [
          AddTab(),
        ]),
      ),
    );
  }
}

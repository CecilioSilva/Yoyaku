import 'package:yoyaku/components/tabs/add_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yoyaku/components/tabs/amiami_tab.dart';

class UtilPage extends StatefulWidget {
  const UtilPage({Key? key}) : super(key: key);

  @override
  State<UtilPage> createState() => _UtilPageState();
}

class _UtilPageState extends State<UtilPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
            tabs: [
              const Tab(icon: Icon(Icons.add)),
              Tab(
                  icon: Image.asset(
                'assets/amiami.png',
                width: 100,
                height: 100,
              )),
            ],
          ),
        ),
        body: const TabBarView(children: [
          AddTab(),
          AmiAmiTab(),
        ]),
      ),
    );
  }
}

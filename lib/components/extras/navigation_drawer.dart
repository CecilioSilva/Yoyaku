import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yoyaku/classes/yoyaku_tab.dart';
import 'package:yoyaku/components/tabs/add_tab.dart';
import 'package:yoyaku/components/tabs/amiami_tab.dart';
import 'package:yoyaku/pages/calculator_page.dart';
import 'package:yoyaku/pages/home_page.dart';
import 'package:yoyaku/pages/settings_page.dart';
import 'package:yoyaku/services/get_card_gradient.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final List<YoyakuTab> items;
  const NavigationDrawerWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 20);

    List<Widget> result = [
      buildHeader(),
      const SizedBox(
        height: 10,
      )
    ];

    for (int i = 0; i < items.length; i++) {
      YoyakuTab tab = items[i];
      Widget item = CustomMenuTabItem(
        icon: tab.getIcon,
        id: i,
        title: tab.getName,
      );
      result.add(item);
    }

    result.addAll([
      const SizedBox(
        height: 10,
      ),
      const Divider(
        color: Colors.redAccent,
      ),
      CustomMenuItem(
        icon: const Icon(Icons.add, color: Colors.white),
        route: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Item',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.orange,
          ),
          body: const AddTab(),
          backgroundColor: const Color(0xFF03071e),
        ),
        title: 'Add Item',
      ),
      CustomMenuItem(
        icon: Image.asset(
          'assets/amiami.png',
          width: 30,
          height: 30,
        ),
        route: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add AmiAmi Item',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.orange,
          ),
          backgroundColor: const Color(0xFF03071e),
          body: const AmiAmiTab(),
        ),
        title: 'Add AmiAmi Item',
      ),
    ]);

    result.addAll([
      const SizedBox(
        height: 10,
      ),
      const Divider(
        color: Colors.redAccent,
      ),
      const CustomMenuItem(
        icon: Icon(Icons.calculate_outlined, color: Colors.white),
        route: CalculatorPage(),
        title: 'Calculator',
      ),
      const CustomMenuItem(
        icon: Icon(Icons.settings_outlined, color: Colors.white),
        route: SettingsPage(),
        title: 'Settings',
      ),
    ]);

    result.addAll([
      const SizedBox(
        height: 10,
      ),
      const Divider(
        color: Colors.redAccent,
      ),
      Padding(
        padding: padding,
        child: Text(
          'Yoyaku Ver 1.5 © Cecilio Silva Monteiro',
          style: GoogleFonts.inconsolata(color: Colors.red),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
    ]);

    return SafeArea(
      child: Drawer(
        child: Material(
          color: const Color(0xFF03071e),
          child: ListView(
            children: result,
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(gradient: getCardGradient(false)),
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Row(
          children: const [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/icon.png'),
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              'Yoyaku',
              style: TextStyle(fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}

class CustomMenuTabItem extends StatelessWidget {
  const CustomMenuTabItem({
    Key? key,
    required this.icon,
    required this.id,
    required this.title,
  }) : super(key: key);

  final IconData icon;
  final int id;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: const TextStyle(color: Colors.orange),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => HomePage(initalIndex: id)),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CustomMenuItem extends StatelessWidget {
  const CustomMenuItem({
    Key? key,
    required this.icon,
    required this.route,
    required this.title,
  }) : super(key: key);

  final Widget icon;
  final Widget route;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: icon,
          title: Text(
            title,
            style: const TextStyle(color: Colors.orange),
          ),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => route),
              ),
            );
          },
        ),
      ],
    );
  }
}

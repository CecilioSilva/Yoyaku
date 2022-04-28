import 'package:amiamu/classes/data_sync.dart';
import 'package:amiamu/pages/home_page.dart';
import 'package:amiamu/services/get_exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(
    FutureProvider<Map?>(
      initialData: initalRates,
      create: (context) => getExchange(),
      child: ChangeNotifierProvider<DataSync>(
        create: (context) => DataSync(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'AmiAmu',
      home: const HomePage(),
    );
  }
}

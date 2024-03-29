import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/pages/home_page.dart';
import 'package:yoyaku/services/get_exchange_rate.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.orange,
        ),
      ),
      title: 'Yoyaku',
      home: const HomePage(),
    );
  }
}

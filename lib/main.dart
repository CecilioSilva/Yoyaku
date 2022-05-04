import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/extras/gradient_text.dart';
import 'package:yoyaku/pages/home_page.dart';
import 'package:yoyaku/services/get_card_gradient.dart';
import 'package:yoyaku/services/get_exchange_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(
    Phoenix(
      child: const Yoyaku(),
    ),
  );
}

class Yoyaku extends StatefulWidget {
  const Yoyaku({Key? key}) : super(key: key);

  @override
  State<Yoyaku> createState() => _YoyakuState();
}

class _YoyakuState extends State<Yoyaku> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    if (user != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.fromSwatch(
            accentColor: Colors.orange,
          ),
        ),
        title: 'Yoyaku',
        home: FutureProvider<Map?>(
          initialData: initalRates,
          create: (context) => getExchange(),
          child: ChangeNotifierProvider<DataSync>(
            create: (context) => DataSync(
              user.id,
              user.displayName ?? user.email,
            ),
            child: const HomePage(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: Colors.orange,
        ),
      ),
      title: 'Yoyaku',
      home: Scaffold(
        backgroundColor: const Color(0xFF03071e),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/icon.png',
                          width: 200,
                          height: 200,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF03071e).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GradientText(
                        'Yoyaku',
                        gradient: getCardGradient(false),
                        style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 65,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                              onPressed: () async {
                                await _googleSignIn.signIn();
                                setState(() {});
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/google.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Sign in with google',
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.grey),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

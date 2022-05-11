import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/extras/confirm_dialog.dar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF03071e),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.orange,
        ),
        backgroundColor: Colors.orange,
        title: const FittedBox(
          child: Text(
            'Settings',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final GoogleSignIn _googleSignIn = GoogleSignIn(
                  scopes: ['email'],
                );
                await _googleSignIn.signOut();

                Phoenix.rebirth(context);
              },
              child: const Text(
                'Logout',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Provider.of<DataSync>(context, listen: false).saveDatabase();
              },
              child: const Text(
                'Save database',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    name: 'Data Deletion',
                    description: 'Are you sure you want to delete all data',
                    onConfirm: () {
                      Provider.of<DataSync>(context, listen: false)
                          .dropDatabase();

                      Fluttertoast.showToast(
                        msg: 'Deleted all data',
                        gravity: ToastGravity.CENTER,
                      );
                    },
                    confirmText: 'Delete data',
                    cancelText: 'Cancel',
                  ),
                );
              },
              child: const Text(
                'Drop database',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Provider.of<DataSync>(context, listen: false).importDatabase();
              },
              child: const Text(
                'Import Database',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

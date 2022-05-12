import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:yoyaku/classes/data_sync.dart';
import 'package:yoyaku/components/extras/confirm_dialog.dar.dart';
import 'package:yoyaku/components/extras/custom_button.dar.dart';
import 'package:yoyaku/services/notification_api.dart';
import 'package:yoyaku/services/yoyaku_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool allTab = false;

  void getValues() async {
    allTab = await getPreference(YoyakuPreferenceType.allTab);
  }

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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            YoyakuButton(
              color: Colors.orange,
              onPressed: () async {
                Provider.of<DataSync>(context, listen: false).saveDatabase();
              },
              text: 'Export database',
            ),
            YoyakuButton(
              onPressed: () async {
                Provider.of<DataSync>(context, listen: false).importDatabase();
              },
              color: Colors.orange,
              text: 'Import Database',
            ),
            YoyakuButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationDialog(
                    name: 'Data Deletion',
                    description: 'Are you sure you want to delete all data',
                    onConfirm: () async {
                      Provider.of<DataSync>(context, listen: false)
                          .dropDatabase();

                      NotificationApi.cancelAll();

                      final _localPath =
                          await getApplicationDocumentsDirectory();
                      final directory = _localPath.path;
                      Directory('$directory/notification/images').delete(
                        recursive: true,
                      );

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
              color: Colors.red,
              text: 'Clear Data',
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails({
    required Uint8List image,
    required String uuid,
  }) async {
    final _localPath = await getApplicationDocumentsDirectory();
    final directory = _localPath.path;

    await Directory('$directory/notification/images').create(recursive: true);
    final file = File('$directory/notification/images/$uuid.jpg');
    file.create(recursive: true);
    file.writeAsBytesSync(image);

    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap('$directory/notification/images/$uuid.jpg'),
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'yoyaku',
        'Upcoming',
        channelDescription: 'Yoyaku upcoming item notification',
        importance: Importance.high,
        playSound: false,
        styleInformation: styleInformation,
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
    );

    final details = await _notification.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
    }

    await _notification.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    required String payload,
    required DateTime scheduledDate,
    required Uint8List image,
  }) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Amsterdam'));

    var time = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    _notification.zonedSchedule(
      id,
      title,
      body,
      time,
      await _notificationDetails(image: image, uuid: payload),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.wallClockTime,
    );
  }

  static void cancel(int id) => _notification.cancel(id);

  static void cancelAll() async => _notification.cancelAll();
}

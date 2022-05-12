import 'dart:developer';

import '../classes/item_data.dart';
import '../models/database_model.dart';
import 'get_exchange_rate.dart';
import 'notification_api.dart';

void addItemNotification(Item data) async {
  final rates = await getExchange();
  ItemData item = ItemData(data, rates);

  final releaseDate = data.releaseDate;

  if (releaseDate.difference(DateTime.now()).inDays > 11) {
    final date = DateTime(
      releaseDate.year,
      releaseDate.month,
      releaseDate.day,
      12,
    );

    // final date1 = date.subtract(const Duration(days: 1));
    // NotificationApi.showScheduledNotification(
    //   id: item.id,
    //   title: '${item.type} Release',
    //   body: item.title,
    //   payload: item.uuid,
    //   scheduledDate: date1,
    //   image: item.image,
    // );
    // log('Added notification for ${item.uuid} on $date1');

    final date2 = date.subtract(const Duration(days: 10));
    NotificationApi.showScheduledNotification(
      id: item.id,
      title: 'Upcoming ${item.type} Release',
      body: item.title,
      payload: item.uuid,
      scheduledDate: date2,
      image: item.image,
    );
    log('Added notification for ${item.uuid} on $date2');
  } else {
    log('Didn\'t add notification for ${item.uuid}');
  }
}

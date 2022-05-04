import 'package:intl/intl.dart';

DateTime getAmiAmiDate(String? date) {
  if (date != null) {
    String dateWithoutTime = date.substring(0, 10);
    List<String> dateElements = dateWithoutTime.split('/');
    String result = dateElements.reversed.join('/');
    try {
      DateTime dateTimeResult = DateFormat('d/M/y').parse(result);
      return dateTimeResult;
    } catch (e) {
      return DateTime.now();
    }
  } else {
    return DateTime.now();
  }
}

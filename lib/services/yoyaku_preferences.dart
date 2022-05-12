import 'package:shared_preferences/shared_preferences.dart';

enum YoyakuPreferenceType {
  allTab,
  calendarTab,
  upcomingTab,
  upcomingPaymentTab,
  galleryTab,
  monthlyTab,
  collectionTab,
  categoryTab,
  totalTab,
  canceledTab,
  itemsTab,
  datatableTab,
}

Future<bool> getPreference(
  YoyakuPreferenceType type, {
  bool defaultValue = true,
}) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(type.name) ?? defaultValue;
}

void setPreference(YoyakuPreferenceType type, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(type.name, value);
}

Future<bool> togglePreference(
  YoyakuPreferenceType type, {
  bool defaultValue = true,
}) async {
  final bool currentValue = await getPreference(
    type,
    defaultValue: defaultValue,
  );
  final bool newValue = !currentValue;
  setPreference(type, newValue);

  return newValue;
}

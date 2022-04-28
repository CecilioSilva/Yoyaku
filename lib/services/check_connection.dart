import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  var result = await Connectivity().checkConnectivity();

  if (result == ConnectivityResult.wifi) {
    log("internet connection is from wifi");
    return true;
  } else if (result == ConnectivityResult.mobile) {
    log("Internet connection is from Mobile data");
    return false;
  } else if (result == ConnectivityResult.none) {
    log("No internet connection");
    return false;
  }
  return false;
}

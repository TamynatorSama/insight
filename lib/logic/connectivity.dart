import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityA extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  startMonitoring() async {
    await initConnectivity();
    _connectivity.onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        _isConnected = false;
        notifyListeners();
      } else {
        await _updateConnectivityStatus().then((value) {
          _isConnected = value;
          notifyListeners();
        });
      }
    });
  }

  Future<void> initConnectivity() async {
    try {
      var status = await _connectivity.checkConnectivity();

      if (status == ConnectivityResult.none) {
        _isConnected = false;
        notifyListeners();
      } else {
        _isConnected = true;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<bool> _updateConnectivityStatus() async {
    bool isOnline = false;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    return isOnline;
  }
}

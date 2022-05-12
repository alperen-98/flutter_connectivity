import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionUtil {
  static final ConnectionUtil _singleton = new ConnectionUtil._internal();
  ConnectionUtil._internal();

  factory ConnectionUtil() {
    return _singleton;
  }

  bool hasConnection = false;

  StreamController connectionChangeController = StreamController();

  final Connectivity _connectivity = Connectivity();
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
  }

  void _connectionChange(ConnectivityResult result) {
    hasInternetConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  Future<bool> hasInternetConnection() async {
    bool previousConnection = hasConnection;
    var connectivityResult = await (Connectivity().checkConnectivity());
    // connected to wifi or mobile
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      hasConnection = true;
    }
    // no connection
    else {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }
}

import 'package:flutter/material.dart';
import '../keys/global_key.dart';
import '../utils/connection_util.dart';

class ConnectionProvider extends ChangeNotifier {
  ConnectionProvider() {
    //Create instance
    ConnectionUtil connectionStatus = ConnectionUtil();
    //Initialize
    connectionStatus.initialize();
    //Listen for connection change
    connectionStatus.connectionChange.listen(connectionChanged);
  }

  bool hasInterNetConnection = false;

  void connectionChanged(dynamic hasConnection) {
    hasInterNetConnection = hasConnection;
    print('connection: $hasInterNetConnection');
    if (!hasInterNetConnection) {
      showNetworkErrorDialog();
    }
  }

  void showNetworkErrorDialog() {
    BuildContext context = GlobalContextKey.instance.globalKey.currentContext!;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('No Internet Connection'),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (hasInterNetConnection) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

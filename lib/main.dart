import 'package:flutter/material.dart';
import 'package:flutter_connectivity/view_models/connection_view_model.dart';
import 'package:flutter_connectivity/views/home_screen.dart';
import 'package:provider/provider.dart';
import 'keys/global_key.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ConnectionProvider(),
        )
      ],
      child: Consumer<ConnectionProvider>(
        builder: (BuildContext context, ConnectionProvider connectionProvider, _) {
          return MyApp();
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          centerTitle: true,
        ),
      ),
      navigatorKey: GlobalContextKey.instance.globalKey,
      home: HomeScreen(),
    );
  }
}

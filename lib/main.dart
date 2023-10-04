import 'package:flutter/material.dart';

//import 'home.dart';
import 'loginView.dart';

void main() {
  //debugEmulateFlutterTesterEnvironment = true;
  runApp(App());
  } 

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SublimeArce',
      debugShowCheckedModeBanner: false,
      home: loginView(),
    );
  }
}

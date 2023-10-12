import 'package:ejercicio1/desingView.dart';
import 'package:ejercicio1/homeView.dart';
import 'package:ejercicio1/productsView.dart';
import 'package:ejercicio1/registerView.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'loginView.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    loginView.tag: (context) => loginView(),
    homeView.tag: (context) => homeView(),
    Home.tag: (context) => Home(),
    registerView.tag: (context) => registerView(),
    desingView.tag: (context) => desingView(),
    productsView.tag: (context) => productsView(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SublimeArce',
      debugShowCheckedModeBanner: false,
      home: loginView(),
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

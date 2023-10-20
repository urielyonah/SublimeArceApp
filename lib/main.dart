import 'package:ejercicio1/vistas/desingView.dart';
import 'package:ejercicio1/vistas/homeView.dart';
import 'package:ejercicio1/vistas/productsView.dart';
import 'package:ejercicio1/vistas/registerView.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'vistas/loginView.dart';

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

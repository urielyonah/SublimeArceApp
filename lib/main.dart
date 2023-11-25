import 'package:ejercicio1/vistas/desingView.dart';
import 'package:ejercicio1/vistas/homeView.dart';
import 'package:ejercicio1/vistas/productsView.dart';
import 'package:ejercicio1/vistas/registerView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'vistas/loginView.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura que Flutter se inicialice

  final prefs = await SharedPreferences.getInstance();
  final userName = prefs.getString('userName') ?? '';
  final userEmail = prefs.getString('userEmail') ?? '';
  final userId = prefs.getInt('userId') ?? 0;

  runApp(App(
    userName: userName,
    userEmail: userEmail,
    userId: userId,
  ));
}

class App extends StatelessWidget {
  final String userName;
  final String userEmail;
  final int userId;

  App({required this.userName, required this.userEmail, required this.userId});

  Map<String, WidgetBuilder> _buildRoutes() {
    return {
      loginView.tag: (context) => loginView(),
      homeView.tag: (context) => homeView(),
      'home': (context) => Home(),
      registerView.tag: (context) => registerView(),
      desingView.tag: (context) => desingView(),
      productsView.tag: (context) => productsView(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SublimeArce',
      debugShowCheckedModeBanner: false,
      home: loginView(),
      routes: _buildRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

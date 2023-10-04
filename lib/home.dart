import 'package:flutter/material.dart';
import 'homeView.dart';
import 'desingView.dart';
import 'productsView.dart';
//import 'loginView.dart'; // Importa la vista de inicio de sesión

class Home extends StatefulWidget {
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

Widget _getSelectedWidget(int index) {
  switch (index) {
    case 0:
      return _homeView();
    case 1:
      return _productsView();
    case 2:
      return _desingView();
    default:
      return Text('Página no encontrada');
  }
}

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getSelectedWidget(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.production_quantity_limits_rounded),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services),
            label: 'Diseños',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class _homeView  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return homeView();
  }
}

class _productsView  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return productsView();
  }
}

class _desingView  extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return desingView();
  }
}



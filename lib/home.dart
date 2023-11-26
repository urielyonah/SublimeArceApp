import 'package:ejercicio1/bd/UserData.dart';
import 'package:ejercicio1/vistas/cartView.dart';

import 'drawer.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class home extends StatefulWidget {
  final Function currentIndex;
  const home({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
            widget.currentIndex(i);
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        iconSize: 25,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining), label: 'Pedidos'),
        ]);
  }
}

class Home extends StatefulWidget {
  static String tag = "Home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  home? myBNB;
  @override
  void initState() {
    myBNB = home(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartView()),
                );
              },
              icon: Icon(Icons.shopping_cart))
        ],
        title: Text('SublimArce'),
        centerTitle: true,
        backgroundColor:
            Colors.blue, // Personaliza el color de acuerdo a tu empresa
      ),
      drawer: drawer(userName: UserData().userName, userEmail: UserData().userEmail),
      bottomNavigationBar: myBNB,
      body: Routes(index: index, userId: 0),
    );
  }
}

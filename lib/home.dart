import 'drawer.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class home extends StatefulWidget {
  final Function currentIndex;
  const home({super.key, required this.currentIndex});

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

void main() => runApp(const Home());

class Home extends StatefulWidget {
  static String tag = "Home";
  const Home({super.key});

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
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart))
        ],
        title: Text('SublimArce'),
        centerTitle: true,
        backgroundColor:
            Colors.blue, // Personaliza el color de acuerdo a tu empresa
      ),
      drawer: drawer(),
      bottomNavigationBar: myBNB,
      body: Routes(index: index),
    );
  }
}

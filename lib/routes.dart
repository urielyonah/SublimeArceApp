import 'package:ejercicio1/vistas/desingView.dart';
import 'package:ejercicio1/vistas/homeView.dart';
import 'package:ejercicio1/vistas/productsView.dart';
import 'package:flutter/material.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [homeView(), desingView(), productsView()];
    return myList[index];
  }
}

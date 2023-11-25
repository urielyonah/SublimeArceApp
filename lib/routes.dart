import 'package:ejercicio1/vistas/desingView.dart';
import 'package:ejercicio1/vistas/homeView.dart';
import 'package:ejercicio1/vistas/productsView.dart';
import 'package:ejercicio1/vistas/pedidosView.dart';
import 'package:flutter/material.dart';

class Routes extends StatelessWidget {
  final int index;
  final int userId;

  const Routes({super.key, required this.index, required this.userId});

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      homeView(),
      ListaPedidosView(),
      desingView(),
      productsView()
    ];
    return myList[index];
  }
}

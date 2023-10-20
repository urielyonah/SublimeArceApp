import 'package:flutter/material.dart';
//import 'dart:async';

class productsView extends StatelessWidget {
  static String tag = "productsView";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(136, 129, 15, 163),
                ),
                child: Center(
                  child: Text(
                    "Productos",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                height: 100,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(20),
                  children: <Widget>[
                    Producto(
                      "Nombre del artículo 1",
                      "assets/camisacafe.jpg",
                      "Descripción del producto",
                      "\$precio",
                    ),
                    Producto(
                      "Nombre del artículo 2",
                      "assets/camisagris.jpg",
                      "Descripción del producto",
                      "\$precio",
                    ),
                    Producto(
                      "Nombre del artículo 3",
                      "assets/camisanegra.jpg",
                      "Descripción del producto",
                      "\$precio",
                    ),
                    // Agrega más productos aquí
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Producto extends StatelessWidget {
  final String nombre;
  final String imagen;
  final String descripcion;
  final String precio;

  Producto(this.nombre, this.imagen, this.descripcion, this.precio);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Card(
        child: Column(
          children: [
            Text(nombre,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Image.asset(imagen, width: 80, height: 150),
            Text(descripcion),
            Text(precio),
            ElevatedButton(
              onPressed: () {
                // Agrega aquí la lógica para comprar el producto
              },
              child: Text("Comprar"),
            ),
          ],
        ),
      ),
    );
  }
}

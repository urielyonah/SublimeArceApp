import 'package:flutter/material.dart';

class Camisa extends StatefulWidget {
  final int id;
  final String modelo;
  final String tallas;
  final String color;
  final String imagen;
  final String descripcion;
  final double precio;
  final int stock;

  Camisa(this.id, this.modelo, this.tallas, this.color, this.precio,
      this.descripcion, this.stock, this.imagen);

  factory Camisa.fromJson(Map<String, dynamic> json) {
    if (json['ID-CAMISAS'] == null ||
        json['MODELO'] == null ||
        json['TALLAS'] == null ||
        json['COLOR'] == null ||
        json['PRECIO'] == null ||
        json['DESCRIPCION'] == null ||
        json['stock'] == null ||
        json['IMAGEN'] == null) {
      // Maneja el caso en el que uno o más campos sean nulos, por ejemplo, asignando valores predeterminados o lanzando una excepción.
      return Camisa(
          0,
          'Modelo no disponible',
          'Tallas no disponibles',
          'color no disponible',
          0.00,
          'Descripcion no disponible',
          0,
          'Imagen no disponible');
    } else {
      return Camisa(
          json['ID-CAMISAS'] as int,
          json['MODELO'] as String,
          json['TALLAS'] as String,
          json['COLOR'] as String,
          json['PRECIO'] as double,
          json['DESCRIPCION'] as String,
          json['stock'] as int,
          json['IMAGEN'] as String);
    }
  }

  @override
  State<Camisa> createState() => _ProductoState();
}

class CartItem {
  final Camisa producto;
  int cantidad;

  CartItem(this.producto, this.cantidad);
}

class _ProductoState extends State<Camisa> {
  int cantidad = 1;
  void incrementarCantidad() {
    setState(() {
      cantidad++;
    });
  }

  void decrementarCantidad() {
    if (cantidad > 1) {
      setState(() {
        cantidad--;
      });
    }
  }

  /* void agregarAlCarrito(Camisa camisa) {
    // Agrega el producto al carrito
    // ...

    // Navega a la vista de cartView.dart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartView(productos: [camisa]),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Card(
        child: Row(
          children: [
            Image.network(
              widget.imagen,
              width: 150,
              height: 150,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.modelo,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.descripcion),
                  Text("\$ ${widget.precio}"),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          decrementarCantidad();
                        },
                      ),
                      Text('$cantidad'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          incrementarCantidad();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

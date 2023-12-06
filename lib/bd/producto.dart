import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ejercicio1/vistas/cartView.dart';
import 'package:ejercicio1/bd/UserData.dart';

class Producto extends StatefulWidget {
  final int id;
  final String nombre;
  final double precio;
  final String imagen;
  final String descripcion;
  final String categoria;
  final int stock;

  Producto(this.id, this.nombre, this.imagen, this.descripcion, this.precio,
      this.categoria, this.stock);

  factory Producto.fromJson(Map<String, dynamic> json) {
    if (json['ID-PRODUCTOS'] == null ||
        json['NOMBRE'] == null ||
        json['IMAGEN'] == null ||
        json['DESCRIPCION'] == null ||
        json['PRECIO'] == null ||
        json['CATEGORIA'] == null ||
        json['stock'] == null) {
      // Maneja el caso en el que uno o más campos sean nulos, por ejemplo, asignando valores predeterminados o lanzando una excepción.
      return Producto(0, 'Nombre no disponible', 'imagen_no_disponible.jpg',
          'Descripción no disponible', 0.00, 'Categoria no disponible', 0);
    } else {
      return Producto(
        json['ID-PRODUCTOS'] as int,
        json['NOMBRE'] as String,
        json['IMAGEN'] as String,
        json['DESCRIPCION'] as String,
        json['PRECIO'] as double,
        json['CATEGORIA'] as String,
        json['stock'] as int,
      );
    }
  }

  @override
  State<Producto> createState() => _ProductoState();
}

class CartItem {
  final Producto producto;
  int cantidad;

  CartItem(this.producto, this.cantidad);
}

class _ProductoState extends State<Producto> {
  int cantidad = 1;
  void incrementarCantidad() {
    setState(() {
      if (cantidad < widget.stock) {
        cantidad++;
      }
    });
  }

  void decrementarCantidad() {
    if (cantidad > 1) {
      setState(() {
        cantidad--;
      });
    }
  }

  void agregarAlCarrito(Producto producto) async {
    // Agrega el producto al carrito
    //final url = ''; // Reemplaza con la URL de tu backend

    // Crea un mapa con la información del producto y la cantidad
    final Map<String, dynamic> data = {
      'idproducto': producto.id.toString(),
      'cantidad': cantidad.toString(),
      'precio': (producto.precio * cantidad).toString(),
      'idcliente': UserData().userId.toString(),

      // ... (otros campos según sea necesario)
    };
    //print(data);
    // Realiza la solicitud HTTP
    try {
      final response = await http.post(
        Uri.parse(
            'https://apisublimarce.onrender.com/insertarproductoapedidos'),
        body: data,
      );
      print(response.body);
      if (response.statusCode == 200) {
        print('Pedido agregado con éxito');
      } else {
        print('Error al agregar el pedido: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error al realizar la solicitud HTTP: $error');
    }

    // Navega a la vista de cartView.dart
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartView(),
      ),
    );
  }

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
                    widget.nombre,
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
                  ElevatedButton(
                    onPressed: () {
                      agregarAlCarrito(widget);
                    },
                    child: Text("Agregar al carrito"),
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

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ejercicio1/bd/UserData.dart';
import 'dart:convert';
import 'package:ejercicio1/bd/pdf.dart'; // Asegúrate de proporcionar la ruta correcta
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Carrito> carritos = [];
  List<int> cantidades = [];

  @override
  void initState() {
    super.initState();
    CargarCarrito();
  }

  void CargarCarrito() async {
    final response = await http.get(Uri.parse(
        "https://apisublimarce.onrender.com/carrito/${UserData().userId}"));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data['carrito'] != null) {
        final List<dynamic> carritoData = List.from(data['carrito']);
        for (final item in carritoData) {
          final carrito = Carrito.fromJson(item);
          carritos.add(carrito);
          cantidades.add(carrito.cantidad);
        }
        setState(() {});
      } else {
        print('La lista de carrito esta vacia');
      }
    } else {
      print('Error al cargar el carrito: ${response.statusCode}');
    }
  }

  Future<void> cambiarEstadoPedido(List<int> pedidoIds) async {
    final response = await http.put(
      Uri.parse('https://apisublimarce.onrender.com/cambiarStatus'),
      body: jsonEncode({'pedidoIds': pedidoIds}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Estado de los pedidos cambiado con éxito');
    } else {
      print(
          'Error al cambiar el estado de los pedidos: ${response.statusCode}');
    }
  }

  void eliminarPedido(int index) async {
    // Obtén el ID del pedido que deseas eliminar
    int pedidoId = carritos[index].id;

    // Realiza la petición HTTP para eliminar el pedido
    final response = await http.delete(
      Uri.parse('https://apisublimarce.onrender.com/deleteCarrito/$pedidoId'),
    );

    if (response.statusCode == 200) {
      // Elimina el pedido de la lista local
      setState(() {
        carritos.removeAt(index);
        cantidades.removeAt(index);
      });

      print('Pedido eliminado con éxito');
    } else {
      print('Error al eliminar el pedido: ${response.statusCode}');
    }
  }

  int cantidad = 0;
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

  @override
  Widget build(BuildContext context) {
    // Calcular el total
    double total = 0;
    for (int i = 0; i < carritos.length; i++) {
      total += carritos[i].precioProductos * cantidades[i];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carritos.length,
              itemBuilder: (context, index) {
                final carrito = carritos[index];
                return Card(
                  child: ListTile(
                    title: Text(carrito.nombreProductos),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                carrito.imagenProductos,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                                width:
                                    8), // Añade un espacio entre la imagen y el texto
                            Expanded(
                              child: Text(
                                "Descripción: ${carrito.descripcionProductos}",
                                maxLines:
                                    3, // Limita el número de líneas para controlar la altura
                                overflow: TextOverflow
                                    .ellipsis, // Maneja el desbordamiento del texto
                              ),
                            ),
                          ],
                        ),
                        Text("Precio: \$${carrito.precioProductos}"),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (cantidades[index] > 1) {
                                    cantidades[index] = cantidades[index] - 1;
                                  }
                                });
                              },
                            ),
                            Text('\ ${cantidades[index]}'),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  if (cantidades[index] <
                                      carrito.stockProductos) {
                                    cantidades[index] = cantidades[index] + 1;
                                  }
                                });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                eliminarPedido(index);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$${total.toStringAsFixed(2)}'),
                ElevatedButton(
                  onPressed: () {
                    // Obtén la lista de IDs de pedidos que deseas cambiar de estado
                    List<int> pedidoIds =
                        carritos.map((carrito) => carrito.id).toList();

                    // Llama a la función cambiarEstadoPedido con la lista de IDs
                    cambiarEstadoPedido(pedidoIds);
                    generarPDF(carritos);
                  },
                  child: Text('Realizar Pedido'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Carrito {
  final int id;
  final int idCamisasServicios;

  int cantidad;
  final double precio;
  final String status;
  final int idCliente;
  final String modelo;
  final String talla;
  final String color;
  final String descripcion;
  final int stock;
  final String imagen;
  final String tipoServicio;
  final String size;
  final String calidad;
  final String area;
  final String nombreProductos;
  final double precioProductos;
  final String descripcionProductos;
  final String categoriaProductos;
  final int stockProductos;
  final String imagenProductos;

  Carrito(
      this.id,
      this.idCamisasServicios,
      this.cantidad,
      this.precio,
      this.status,
      this.idCliente,
      this.modelo,
      this.talla,
      this.color,
      this.descripcion,
      this.stock,
      this.imagen,
      this.tipoServicio,
      this.size,
      this.calidad,
      this.area,
      this.nombreProductos,
      this.precioProductos,
      this.descripcionProductos,
      this.categoriaProductos,
      this.stockProductos,
      this.imagenProductos);

  factory Carrito.fromJson(Map<String, dynamic> json) {
    return Carrito(
        json['ID-PEDIDOS'] as int? ?? 0,
        json['ID-CAMISAS-SERVICIOS'] as int? ?? 0,
        json['CANTIDAD'] as int? ?? 0,
        json['PRECIO'] != null ? json['PRECIO']!.toDouble() : 0.0,
        json['STATUS'] as String? ?? '',
        json['ID-CLIENTE'] as int? ?? 0,
        json['MODELO'] as String? ?? '',
        json['TALLAS'] as String? ?? '',
        json['COLOR'] as String? ?? '',
        json['DESCRIPCION'] as String? ?? '',
        json['stock'] as int? ?? 0,
        json['IMAGEN'] as String? ?? '',
        json['TIPO-SERVICIO'] as String? ?? '',
        json['tamaño'] as String? ?? '',
        json['calidad'] as String? ?? '',
        json['AREA'] as String? ?? '',
        json['NOMBRE-PRODUCTOS'] as String? ?? '',
        json['PRECIO-PRODUCTOS'] != null
            ? json['PRECIO-PRODUCTOS']!.toDouble()
            : 0.0,
        json['DESCRIPCION-PRODUCTOS'] as String? ?? '',
        json['CATEGORIA-PRODUCTOS'] as String? ?? '',
        json['STOCK-PRODUCTOS'] as int? ?? 0,
        json['IMAGEN-PRODUCTOS'] as String? ?? '');
  }
}

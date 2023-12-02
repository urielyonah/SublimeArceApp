import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ejercicio1/bd/UserData.dart';
import 'dart:convert';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Carrito> carritos = [];

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
        }
        setState(() {});
      } else {
        print('La lista de carrito esta vacia');
      }
    } else {
      print('Error al cargar el carrito: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: carritos.length, // Usa widget.productos en lugar de carrito
        itemBuilder: (context, index) {
          final carrito =
              carritos[index]; // Usa widget.productos en lugar de carrito
          return Card(
            child: ListTile(
              title: Text(carrito.nombreProductos),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Descripción: ${carrito.descripcion}"),
                  Text("Precio: \$${carrito.precio}"),
                  // Puedes agregar más detalles según la estructura de tu Producto
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetallesCarritoView(carrito: carrito),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class Carrito {
  final int id;
  final int idCamisasServicios;

  final int cantidad;
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
      this.nombreProductos);

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
    );
  }
}

class DetallesCarritoView extends StatelessWidget {
  final Carrito carrito;

  DetallesCarritoView({required this.carrito});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Pedido'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Número de Pedido: ${carrito.id}'),
            SizedBox(height: 8),
            Text('Cantidad: ${carrito.cantidad}'),
            SizedBox(height: 8),
            Text('Estado: ${carrito.status}'),
            SizedBox(height: 16),
            Text('Nombre de Productos: ${carrito.nombreProductos}'),
            if (carrito.idCamisasServicios != null) ...[
              Text('ID de Camisas/Servicios: ${carrito.idCamisasServicios}'),
              Text('Modelo: ${carrito.modelo}'),
              Text('Talla: ${carrito.talla}'),
              Text('Color: ${carrito.color}'),
              Text('Descripción: ${carrito.descripcion}'),
              Text('Stock: ${carrito.stock}'),
              Text('Tipo de Servicio: ${carrito.tipoServicio}'),
              Text('Tamaño: ${carrito.size}'),
              Text('Calidad: ${carrito.calidad}'),
              Text('Área: ${carrito.area}'),

              // Agrega más detalles específicos para camisas/servicios aquí si es necesario
            ],

            SizedBox(height: 16),

            // Precio total
            Text('Precio Total: \$${carrito.precio.toStringAsFixed(2)}'),

            // Agrega más detalles aquí si es necesario
          ],
        ),
      ),
    );
  }
}

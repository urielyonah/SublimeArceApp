import 'package:ejercicio1/bd/UserData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListaPedidosView extends StatefulWidget {
  @override
  _ListaPedidosViewState createState() => _ListaPedidosViewState();
}

class _ListaPedidosViewState extends State<ListaPedidosView> {
  List<Pedido> pedidos = [];

  @override
  void initState() {
    super.initState();
    cargarPedidos();
  }

  void cargarPedidos() async {
    final response = await http.get(Uri.parse(
        "https://apisublimarce.onrender.com/pedido/${UserData().userId}"));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      if (data['pedidos'] != null) {
        final List<dynamic> pedidosData = List.from(data['pedidos']);

        for (final item in pedidosData) {
          final pedido = Pedido.fromJson(item);
          pedidos.add(pedido);
        }

        setState(() {});
      } else {
        print('La lista de pedidos es nula.');
      }
    } else {
      print('Error al cargar los pedidos: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: pedidos.length,
        itemBuilder: (context, index) {
          final pedido = pedidos[index];
          return Card(
            child: ListTile(
              title: Text('Pedido #${pedido.id}'),
              subtitle: Text(
                  'Cantidad: ${pedido.cantidad}, Precio: \$${pedido.precio.toStringAsFixed(2)}, Estado: ${pedido.status}'),
              onTap: () {
                // Navegar a la vista de detalles del pedido
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetallesPedidoView(pedido: pedido),
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

class Pedido {
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

  Pedido(
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

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
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

class DetallesPedidoView extends StatelessWidget {
  final Pedido pedido;

  DetallesPedidoView({required this.pedido});

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
            Text('Número de Pedido: ${pedido.id}'),
            SizedBox(height: 8),
            Text('Cantidad: ${pedido.cantidad}'),
            SizedBox(height: 8),
            Text('Estado: ${pedido.status}'),
            SizedBox(height: 16),
            Text('Nombre de Productos: ${pedido.nombreProductos}'),
            if (pedido.idCamisasServicios != null) ...[
              Text('ID de Camisas/Servicios: ${pedido.idCamisasServicios}'),
              Text('Modelo: ${pedido.modelo}'),
              Text('Talla: ${pedido.talla}'),
              Text('Color: ${pedido.color}'),
              Text('Descripción: ${pedido.descripcion}'),
              Text('Stock: ${pedido.stock}'),
              Text('Tipo de Servicio: ${pedido.tipoServicio}'),
              Text('Tamaño: ${pedido.size}'),
              Text('Calidad: ${pedido.calidad}'),
              Text('Área: ${pedido.area}'),

              // Agrega más detalles específicos para camisas/servicios aquí si es necesario
            ],

            SizedBox(height: 16),

            // Precio total
            Text('Precio Total: \$${pedido.precio.toStringAsFixed(2)}'),

            // Agrega más detalles aquí si es necesario
          ],
        ),
      ),
    );
  }
}

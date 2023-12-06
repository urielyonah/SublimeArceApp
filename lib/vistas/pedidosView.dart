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
        'https://apisublimarce.onrender.com/pedido/${UserData().userId}'));

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

  void eliminarPedido(int index) async {
    // Obtén el ID del pedido que deseas eliminar
    int pedidoId = pedidos[index].id;

    // Realiza la petición HTTP para eliminar el pedido
    final response = await http.delete(
      Uri.parse('https://apisublimarce.onrender.com/deleteCarrito/$pedidoId'),
    );

    if (response.statusCode == 200) {
      // Elimina el pedido de la lista local
      setState(() {
        pedidos.removeAt(index);
      });

      print('Pedido eliminado con éxito');
    } else {
      print('Error al eliminar el pedido: ${response.statusCode}');
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
                    builder: (context) => DetallesPedidoView(
                      pedido: pedido,
                      eliminarPedidoFunc: () {
                        eliminarPedido(index);
                      },
                    ),
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
  final int cantidad;
  final double precio;
  final String status;
  final int idCamisasServicios;
  final int idCamisas;
  final int idServicios;
  final double precioCamisasServicios;
  final String CamisasModelo;
  final String CamisasTalla;
  final String CamisasColor;
  final double CamisasPrecio;
  final String CamisasDescripcion;
  final int CamisasStock;
  final String CamisasImagen;
  final String TipoServicio;
  final String ServicioCalidad;
  final double ServicioPrecio;
  final String ServicioSize;
  final String ServicioArea;
  final String ServicioImagen;
  final String nombreProductos;
  final double precioProductos;
  final String descripcionProductos;
  final String categoriaProductos;
  final int stockProductos;
  final String imagenProductos;

  Pedido(
      this.id,
      this.cantidad,
      this.precio,
      this.status,
      this.idCamisasServicios,
      this.idCamisas,
      this.idServicios,
      this.precioCamisasServicios,
      this.CamisasModelo,
      this.CamisasTalla,
      this.CamisasColor,
      this.CamisasPrecio,
      this.CamisasDescripcion,
      this.CamisasStock,
      this.CamisasImagen,
      this.TipoServicio,
      this.ServicioCalidad,
      this.ServicioPrecio,
      this.ServicioSize,
      this.ServicioArea,
      this.ServicioImagen,
      this.nombreProductos,
      this.precioProductos,
      this.descripcionProductos,
      this.categoriaProductos,
      this.stockProductos,
      this.imagenProductos);

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
        json['ID-PEDIDOS'] as int? ?? 0,
        json['CANTIDAD'] as int? ?? 0,
        json['PRECIO'] != null ? json['PRECIO']!.toDouble() : 0.0,
        json['STATUS'] as String? ?? '',
        json['ID-CAMISAS-SERVICIOS'] as int? ?? 0,
        json['CS_ID_CAMISAS'] as int? ?? 0,
        json['CS_ID_SERVICIOS'] as int? ?? 0,
        json['PRECIO-CAMISAS-SERVICIOS'] != null
            ? json['PRECIO-CAMISAS-SERVICIOS']!.toDouble()
            : 0.0,
        json['MODELO'] as String? ?? '',
        json['TALLAS'] as String? ?? '',
        json['COLOR'] as String? ?? '',
        json['CAMISAS_PRECIO'] != null
            ? json['CAMISAS_PRECIO']!.toDouble()
            : 0.0,
        json['DESCRIPCION'] as String? ?? '',
        json['CAMISAS_STOCK'] as int? ?? 0,
        json['CAMISAS_IMAGEN'] as String? ?? '',
        json['TIPO-SERVICIO'] as String? ?? '',
        json['CALIDAD'] as String? ?? '',
        json['SERVICIOS_PRECIO'] != null
            ? json['SERVICIOS_PRECIO']!.toDouble()
            : 0.0,
        json['TAMAÑO'] as String? ?? '',
        json['AREA'] as String? ?? '',
        json['SERVICIOS_IMAGEN'] as String? ?? '',
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

class DetallesPedidoView extends StatelessWidget {
  final Pedido pedido;
  final Function eliminarPedidoFunc; // Sin parámetros

  DetallesPedidoView({required this.pedido, required this.eliminarPedidoFunc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Pedido'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Table(
                columnWidths: {
                  0: FlexColumnWidth(
                      1), // Ajusta el ancho de la primera columna
                  1: FlexColumnWidth(
                      1), // Ajusta el ancho de la segunda columna
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Número de Pedido:'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Cantidad:'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Estado:'),
                        ),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${pedido.id}'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${pedido.cantidad}'),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${pedido.status}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (pedido.idCamisasServicios != null) ...[
                Card(
                  child: ListTile(
                    title: Text(pedido.CamisasModelo),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                pedido.CamisasImagen,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Descripcion: ${pedido.CamisasDescripcion}",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Color: ${pedido.CamisasColor}"),
                                Text("Talla: ${pedido.CamisasTalla}"),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(pedido.TipoServicio),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              child: Image.network(
                                pedido.ServicioImagen,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Calidad: ${pedido.ServicioCalidad}",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("Tamaño: ${pedido.ServicioSize}"),
                                Text("Area: ${pedido.ServicioArea}"),
                              ],
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 16),
              Card(
                child: ListTile(
                  title: Text(pedido.nombreProductos),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            child: Image.network(
                              pedido.imagenProductos,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Descripción: ${pedido.descripcionProductos}",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text("Precio: \$${pedido.precioProductos}"),
                      Row(
                        children: [
                          Text('\ ${pedido.cantidad}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Precio Total: '),
                        Text("\$${pedido.precio.toStringAsFixed(2)}")
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          eliminarPedidoFunc();
                        },
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            Text('Eliminar Pedido'),
                          ],
                        )),
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

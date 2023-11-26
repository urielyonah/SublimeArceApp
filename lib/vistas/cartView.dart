import 'package:flutter/material.dart';
import 'package:ejercicio1/bd/producto.dart';

class CartView extends StatefulWidget {
  final List<Producto> productos; // Lista de productos disponibles
  //final CartItem? itemToAdd; // Elemento a agregar al carrito

  const CartView({Key? key, this.productos = const []}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<CartItem> carrito = []; // Descomenta esta línea para inicializar la lista de carrito

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount:
            widget.productos.length, // Usa widget.productos en lugar de carrito
        itemBuilder: (context, index) {
          final item = widget
              .productos[index]; // Usa widget.productos en lugar de carrito
          return ListTile(
            title: Text(item.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Descripción: ${item.descripcion}"),
                Text("Precio: \$${item.precio}"),
                // Puedes agregar más detalles según la estructura de tu Producto
              ],
            ),
          );
        },
      ),
    );
  }
}

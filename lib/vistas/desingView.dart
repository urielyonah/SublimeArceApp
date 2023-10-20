import 'package:flutter/material.dart';
import 'cartView.dart';

class desingView extends StatelessWidget {
  static String tag = "designView";

  // Lista de ejemplo de productos
  final List<Producto> products = [
    Producto("Camisa 1", "assets/camisacafe.jpg", "Descripción 1", "\$20.00"),
    Producto("Camisa 2", "assets/camisagris.jpg", "Descripción 2", "\$25.00"),
    Producto("Camisa 3", "assets/camisanegra.jpg", "Descripción 3", "\$18.00"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Regresar a la página anterior
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => cartView()),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ],
        title: Text('Camisas'),
        centerTitle: true,
        backgroundColor:
            Colors.purple, // Personaliza el color de acuerdo a tu empresa
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: Image.asset(product.imagen),
              title: Text(product.nombre),
              subtitle: Text(product.descripcion),
              trailing: Text(product.precio),
              onTap: () {
                // Navegar a la vista de detalles del producto
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetallesProductoView(product: product),
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

class Producto {
  final String nombre;
  final String imagen;
  final String descripcion;
  final String precio;

  Producto(this.nombre, this.imagen, this.descripcion, this.precio);
}

class DetallesProductoView extends StatelessWidget {
  final Producto product;

  DetallesProductoView({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nombre),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(product.imagen),
            Text("Nombre: ${product.nombre}"),
            Text("Descripción: ${product.descripcion}"),
            Text("Precio: ${product.precio}"),
          ],
        ),
      ),
    );
  }
}

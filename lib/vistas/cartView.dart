import 'package:flutter/material.dart';

class Product {
  final String nombre;
  final double precio;
  final String imagen;
  int cantidad;

  Product(this.imagen, this.nombre, this.precio, this.cantidad);
}

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<Product> carrito = [
    Product('camisanegra.jpg', 'Producto 1', 10.0, 1),
    Product('camisagris.jpg', 'Producto 2', 15.0, 1),
    Product('camisacafe.jpg', 'Producto 3', 20.0, 1),
  ];

  void incrementarCantidad(int index) {
    setState(() {
      carrito[index].cantidad++;
    });
  }

  void decrementarCantidad(int index) {
    setState(() {
      if (carrito[index].cantidad > 1) {
        carrito[index].cantidad--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrito de compras"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          // Botones de ordenación
          Divider(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    carrito.sort((a, b) => a.nombre.compareTo(b.nombre));
                  });
                },
                child: Text('Ordenar por Nombre'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    carrito.sort((a, b) => a.precio.compareTo(b.precio));
                  });
                },
                child: Text('Ordenar por Precio'),
              ),
            ],
          ),
          // Lista de productos en el carrito
          Expanded(
            child: ListView.builder(
              itemCount: carrito.length,
              itemBuilder: (context, index) {
                final producto = carrito[index];
                return ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(producto.imagen),
                  ),
                  title: Text(producto.nombre),
                  subtitle: Text('\$${producto.precio.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize
                        .min, // Asegura que el Row no intente ocupar todo el espacio disponible
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          decrementarCantidad(index);
                        },
                      ),
                      Text('${producto.cantidad}'),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          incrementarCantidad(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(
                            () {
                              carrito.remove(producto);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Subtotal o Total
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: \$${carrito.fold(0.0, (total, producto) => total + (producto.cantidad * producto.precio)).toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16), // Espacio entre el Text y el botón
                ElevatedButton(
                  onPressed: () {
                    // Agrega aquí la lógica para cotizar o ordenar
                  },
                  child: Text('Cotizar u Ordenar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

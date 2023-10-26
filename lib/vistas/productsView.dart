import 'package:flutter/material.dart';
import 'cartView.dart';

class productsView extends StatelessWidget {
  static String tag = "productsView";
  final List<Producto> products = [
    Producto("Nombre del artículo 1", "assets/camisacafe.jpg",
        "Descripción del producto", "\$precio"),
    Producto("Nombre del artículo 2", "assets/camisagris.jpg",
        "Descripción del producto", "\$precio"),
    Producto("Nombre del artículo 3", "assets/camisanegra.jpg",
        "Descripción del producto", "\$precio"),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.blueAccent,
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
                        MaterialPageRoute(builder: (context) => CartView()),
                      );
                    },
                    icon: Icon(Icons.shopping_cart),
                  ),
                ],
                title: Text('Productos'),
                centerTitle: true,
                backgroundColor: Colors
                    .purple, // Personaliza el color de acuerdo a tu empresa

                bottom: TabBar(
                  tabs: <Widget>[
                    new Tab(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text('camisas'),
                      ),
                    ),
                    new Tab(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text('bolsas'),
                      ),
                    ),
                    new Tab(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text('tazas'),
                      ),
                    ),
                  ],
                )),
            body: TabBarView(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: products
                        .map((product) => Producto(
                              product.nombre,
                              product.imagen,
                              product.descripcion,
                              product.precio,
                            ))
                        .toList(),
                  ),
                ),
                Container(
                  child: Text("bolsas"),
                ),
                Container(
                  child: Text("tazas"),
                ),
              ],
            )));
  }
}

class Producto extends StatefulWidget {
  final String nombre;
  final String imagen;
  final String descripcion;
  final String precio;

  Producto(this.nombre, this.imagen, this.descripcion, this.precio);

  @override
  _ProductoState createState() => _ProductoState();
}

class _ProductoState extends State<Producto> {
  int cantidad = 0;

  void incrementarCantidad() {
    setState(() {
      cantidad++;
    });
  }

  void decrementarCantidad() {
    if (cantidad > 0) {
      setState(() {
        cantidad--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Card(
        child: Row(
          children: [
            Image.asset(widget.imagen, width: 150, height: 150),
            SizedBox(width: 10), // Espacio entre la imagen y el contenido
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.nombre,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(widget.descripcion),
                  Text(widget.precio),
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
                      // Aquí puedes agregar el producto al carrito con la cantidad seleccionada
                      print('Agregado al carrito: ${widget.nombre} x$cantidad');
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

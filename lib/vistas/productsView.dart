import 'package:flutter/material.dart';
import 'cartView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class productsView extends StatefulWidget {
  static String tag = "productsView";
  @override
  _productsViewState createState() => _productsViewState();
}

class _productsViewState extends State<productsView> {
  List<Producto> camisas = [];
  List<Producto> bolsas = [];
  List<Producto> tazas = [];
  List<Producto> productosEnCarrito = [];


  @override
  void initState() {
    super.initState();
    // Llama a la función para cargar los productos desde tu servidor al iniciar la pantalla.
    cargarProductos();
  }

  void cargarProductos() async {
    final response = await http
        .get(Uri.parse('https://apisublimarce.onrender.com/getproductos'));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      print(data);

      // Llena las listas de productos según la categoría.
      for (final item in data) {
        final producto = Producto.fromJson(item);
        if (producto.categoria == 'CAMISAS') {
          camisas.add(producto);
        } else if (producto.categoria == 'BOLSAS') {
          bolsas.add(producto);
        } else if (producto.categoria == 'TAZAS') {
          tazas.add(producto);
        }
      }

      setState(() {
        // No es necesario actualizar 'products' ya que ahora estás usando listas separadas.
      });
    } else {
      print('Error al cargar productos: ${response.statusCode}');
    }
  }

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
                  MaterialPageRoute(
                    builder: (context) => CartView(carrito: productosEnCarrito),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ],
          title: Text('Productos'),
          centerTitle: true,
          backgroundColor: Colors.purple,
          bottom: TabBar(
            tabs: <Widget>[
              new Tab(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text('CAMISAS'),
                ),
              ),
              new Tab(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text('TAZAS'),
                ),
              ),
              new Tab(
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text('BOLSAS'),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: camisas
                    .map((product) => Producto(
                          product.id,
                          product.nombre,
                          product.imagen,
                          product.descripcion,
                          product.precio.toDouble(),
                          product.categoria,
                          product.cantidad,
                        ))
                    .toList(),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: tazas
                    .map((product) => Producto(
                          product.id,
                          product.nombre,
                          product.imagen,
                          product.descripcion,
                          product.precio.toDouble(),
                          product.categoria,
                          product.cantidad,
                        ))
                    .toList(),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: bolsas
                    .map((product) => Producto(
                          product.id,
                          product.nombre,
                          product.imagen,
                          product.descripcion,
                          product.precio.toDouble(),
                          product.categoria,
                          product.cantidad,
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Producto extends StatefulWidget {
  final int id;
  final String nombre;
  final String imagen;
  final String descripcion;
  final double precio;
  final String categoria;
  int cantidad;

  Producto(this.id, this.nombre, this.imagen, this.descripcion, this.precio,this.categoria, this.cantidad);

  factory Producto.fromJson(Map<String, dynamic> json) {
    if (json['ID-PRODUCTOS'] == null ||
        json['NOMBRE'] == null ||
        json['IMAGEN'] == null ||
        json['DESCRIPCION'] == null ||
        json['PRECIO'] == null ||
        json['CATEGORIA'] == null||
        json['CANTIDAD'] == null ) {
      // Maneja el caso en el que uno o más campos sean nulos, por ejemplo, asignando valores predeterminados o lanzando una excepción.
      return Producto(0, 'Nombre no disponible', 'imagen_no_disponible.jpg',
          'Descripción no disponible', 0.00, 'Categoria no disponible',0);
    } else {
      return Producto(
        json['ID-PRODUCTOS'] as int,
        json['NOMBRE'] as String,
        json['IMAGEN'] as String,
        json['DESCRIPCION'] as String,
        json['PRECIO'] as double,
        json['CATEGORIA'] as String,
        json['CANTIDAD'] as int,
        
      );
    }
  }

  @override
  State<Producto> createState() => _ProductoState();
}

class _ProductoState extends State<Producto> {
  List<Producto> productosEnCarrito = [];
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
                        final productoSeleccionado = Producto(
                        widget.id,
                        widget.nombre,
                        widget.imagen,
                        widget.descripcion,
                        widget.precio, // Convierte el precio a double si es necesario
                        widget.categoria,
                        widget.cantidad,
                  );
                  setState(() {
                  productosEnCarrito.add(productoSeleccionado);
                    });
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

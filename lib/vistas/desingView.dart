import 'package:flutter/material.dart';
import 'cartView.dart';
import 'package:image_picker/image_picker.dart';

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

class DetallesProductoView extends StatefulWidget {
  final Producto product;

  DetallesProductoView({required this.product});

  @override
  _DetallesProductoViewState createState() => _DetallesProductoViewState();
}

class _DetallesProductoViewState extends State<DetallesProductoView> {
  String selectedTalla = 'S';
  String selectedColor = 'Blanco';
  int cantidad = 1;
  String selectedServicio = 'Sublimado';
  String selectedAreaServicio = 'Pecho';
  String selectedCalidadServicio = "Alta"; // Valor predeterminado
  String? imageUrl; // Ruta de la imagen cargada

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageUrl = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.nombre),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 200, // Ancho deseado
                  height: 200, // Alto deseado
                  child: Image.asset(widget.product.imagen),
                ),
              ),
              SizedBox(height: 16),
              Text("Descripción: ${widget.product.descripcion}"),
              SizedBox(height: 16),
              Text("Precio: ${widget.product.precio}"),
              SizedBox(height: 16),
              Row(
                children: [
                  Text("Talla: "),
                  DropdownButton<String>(
                    value: selectedTalla,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedTalla = newValue!;
                      });
                    },
                    items: <String>['S', 'M', 'L', 'XL']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 16),
                  Text("Color: "),
                  DropdownButton<String>(
                    value: selectedColor,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedColor = newValue!;
                      });
                    },
                    items: <String>['Blanco', 'Negro', 'Azul', 'Rojo']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 16),
                  Text("Servicio: "),
                  DropdownButton<String>(
                    value: selectedServicio,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedServicio = newValue!;
                      });
                    },
                    items: <String>['Sublimado', 'Bordado']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(children: [
                Text("Area del servicio: "),
                DropdownButton<String>(
                  value: selectedAreaServicio,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedAreaServicio = newValue!;
                    });
                  },
                  items: <String>[
                    'Pecho',
                    'manga',
                    'espalda',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                Text("Calidad del servicio: "),
                DropdownButton<String>(
                  value: selectedCalidadServicio,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCalidadServicio = newValue!;
                    });
                  },
                  items: <String>[
                    'Alta',
                    'Normal',
                    'Sencilla',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ]),
              SizedBox(height: 16),
              Text("Cantidad:"),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (cantidad > 1) {
                        setState(() {
                          cantidad--;
                        });
                      }
                    },
                  ),
                  Text('$cantidad'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        cantidad++;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(height: 16),
              Text("Cargar imagen:"),
              ElevatedButton(
                onPressed: () {
                  _pickImage(ImageSource
                      .gallery); // Debes reemplazar 'ruta_de_la_imagen' con la ruta real
                },
                child: Text("Cargar imagen"),
              ),
              if (imageUrl != null)
                Image.network(
                  imageUrl!,
                  width: 100, // Ancho deseado
                  height: 100, // Alto deseado
                ),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print(
                        'Agregado al carrito: ${widget.product.nombre} x$cantidad, talla: $selectedTalla, color: $selectedColor, servicio: $selectedServicio, area: $selectedAreaServicio');
                  },
                  child: Text("Agregar al carrito"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

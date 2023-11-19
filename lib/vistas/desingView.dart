import 'package:flutter/material.dart';
import 'cartView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:ejercicio1/bd/camisa.dart';

class desingView extends StatefulWidget {
  static String tag = "designView";

  @override
  State<desingView> createState() => _desingViewState();
}

class _desingViewState extends State<desingView> {
  List<Camisa> productosEnCarrito = [];
  List<Camisa> camisas = [];

  Camisa getProductById(int camisaId) {
    for (final camisa in camisas) {
      if (camisa.id == camisaId) {
        return camisa;
      }
    }
    return Camisa(0, 'Modelo no encontrado', '', '', 0.0, '', 0, '');
  }

  @override
  void initState() {
    super.initState();
    cargarCamisas();
  }

  void cargarCamisas() async {
    final response = await http
        .get(Uri.parse("https://apisublimarce.onrender.com/getcamisas"));

    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);

      for (final item in data) {
        final camisa = Camisa.fromJson(item);
        camisas.add(camisa);
      }
      print('------------CAMISAS------------');
      camisas.forEach((camisa) {
        print('ID: ${camisa.id}, MODELO: ${camisa.modelo}');
      });
      setState(() {});
    } else {
      print('Error al cargar las camisas: ${response.statusCode}');
    }
  }

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
                MaterialPageRoute(builder: (context) => CartView()),
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
        itemCount: camisas.length,
        itemBuilder: (context, index) {
          final product = camisas[index];
          return Card(
            child: ListTile(
              isThreeLine: true,
              leading: Image.network(
                product.imagen,
                height: 100,
              ),
              title: Text(product.modelo),
              subtitle: Text(product.descripcion),
              trailing: Column(
                children: [
                  Text("Precio: \$${product.precio.toStringAsFixed(2)}"),
                  Text("Talla: ${product.tallas}"),
                  Text("Color: ${product.color}"),
                ],
              ),
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

class DetallesProductoView extends StatefulWidget {
  final Camisa product;

  DetallesProductoView({required this.product});

  @override
  _DetallesProductoViewState createState() => _DetallesProductoViewState();
}

class _DetallesProductoViewState extends State<DetallesProductoView> {
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
        title: Text(widget.product.modelo),
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
                  child: Image.network(widget.product.imagen),
                ),
              ),
              SizedBox(height: 16),
              Text("Descripción: ${widget.product.descripcion}"),
              SizedBox(height: 16),
              Text("Precio: ${widget.product.precio.toStringAsFixed(2)}"),
              SizedBox(height: 16),
              Row(
                children: [
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
                        'Agregado al carrito: ${widget.product.modelo} x$cantidad, servicio: $selectedServicio, area: $selectedAreaServicio');
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

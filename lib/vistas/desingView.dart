import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'cartView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ejercicio1/bd/camisas.dart';

class desingView extends StatefulWidget {
  static String tag = "designView";

  @override
  _DesingViewState createState() => _DesingViewState();
}

class _DesingViewState extends State<desingView>{
  List<Camisas> camisas = [];
  void cargarCamisas() async {
    final response = await http.get(Uri.parse('https://apisublimarce.onrender.com/getCamisas'));
    if (response.statusCode == 200) {
      final dynamic data = json.decode(response.body);
      
      for (final item in data) {
        final camisa = Camisas.fromJson(item);
        camisas.add(camisa);
      }
      setState(() {
        // Actualizar el estado con la lista de camisas cargadas.
        camisas = camisas;
      });
    } else {
      print('Error al cargar camisas: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    cargarCamisas();
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
          final camisa = camisas[index];
          return Card(
            child: ListTile(
              leading: Image.network(camisa.imagen),
              title: Text(camisa.modelo),
              subtitle: Text(camisa.descripcion),
              trailing: Text("Precio: \$${camisa.precio.toStringAsFixed(2)}"),
              onTap: () {
                // Navegar a la vista de detalles del producto
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>DetallesCamisasView(camisa: camisa),
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

class DetallesCamisasView extends StatefulWidget{
  final Camisas camisa;

  DetallesCamisasView({required this.camisa});
  @override
  _DetallesCamisasViewState createState() => _DetallesCamisasViewState();
}

class _DetallesCamisasViewState extends State<DetallesCamisasView> {

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
        title: Text(widget.camisa.modelo),
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
                  child: Image.network(widget.camisa.imagen),
                ),
              ),
              SizedBox(height: 16),
              Text("Descripción: ${widget.camisa.descripcion}"),
              SizedBox(height: 16),
              Text("Precio: ${widget.camisa.precio}"),
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
                  _pickImage(ImageSource.gallery); // Debes reemplazar 'ruta_de_la_imagen' con la ruta real
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
                    print('Agregado al carrito: ${widget.camisa.modelo} x $cantidad, talla: $selectedTalla, color: $selectedColor, servicio: $selectedServicio, area: $selectedAreaServicio');
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

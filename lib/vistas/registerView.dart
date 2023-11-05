import 'package:ejercicio1/list.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class registerView extends StatefulWidget {
  static String tag = "registerView";
  @override
  _registerView createState() => _registerView();
}

class _registerView extends State<registerView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;
  bool showPassword2 = false;

  void register() async {
    try {
      final String url = ('https://apisublimarce.onrender.com/register');
      //final String url = ('http://localhost:3000/register');

      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
          'name': nameController.text,
        },
      );

      if (response.statusCode == 200) {
        print('Usuario registrado exitosamente');
        print('correo: ' + emailController.text);
      } else {
        print('Error al registrar usuario: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al registrar usuario: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 131, 36, 219),
        title: Text('Registro'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu nombre';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingresa tu correo electrónico';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              obscureText: !showPassword,
              controller: passwordController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    showPassword ? Icons.visibility_off : Icons.visibility,
                    size: 30.0,
                    color: const Color.fromARGB(255, 190, 190, 190),
                  ),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                labelText: 'Contraseña',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu contraseña';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              //controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa tu contraseña nuevamente';
                }
                return null;
              },
              obscureText: true,
            ),
            SizedBox(height: 30.0),
            MaterialButton(
              height: 35,
              minWidth: 250,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () {
                register();
              },
              padding: EdgeInsets.all(12),
              color: Color.fromARGB(255, 219, 36, 176),
              child: Text('Registrarse',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class _listpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return listpage();
  }
}

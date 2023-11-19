import 'package:ejercicio1/list.dart';
import 'package:ejercicio1/vistas/loginView.dart';
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
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool showPassword = false;
  bool showPassword2 = false;

  void register() async {
    // Validate empty fields
    if (nameController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa tu nombre'),
          );
        },
      );
      return;
    }
    if (emailController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa tu correo electrónico'),
          );
        },
      );
      return;
    }
    if (phoneController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa tu número de teléfono'),
          );
        },
      );
      return;
    }
    if (addressController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Ingresa tu dirección'),
          );
        },
      );
      return;
    }

    // Validate passwords
    if (passwordController.text.isEmpty || passwordController.text.length < 5) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Contraseña inválida'),
            content: Text('La contraseña debe tener al menos 5 caracteres'),
          );
        },
      );
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Contraseñas no coinciden'),
            content: Text('Las contraseñas deben ser iguales'),
          );
        },
      );
      return;
    }

    // Proceed with registration
    final response = await http.post(
      Uri.parse('https://apisublimarce.onrender.com/register'),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
        'name': nameController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuario Registrado Exitosamente!'),
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => _loginView(),
        ),
      );
    } else {
      print('Error al registrar usuario: ${response.statusCode}');
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
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
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
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Telefono',
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Direccion',
              ),
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

class _loginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return loginView();
  }
}

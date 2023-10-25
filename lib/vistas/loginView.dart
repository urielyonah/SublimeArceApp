import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../home.dart';
import 'registerView.dart';

class loginView extends StatefulWidget {
  static String tag = "loginView";
  @override
  _loginView createState() => new _loginView();
}

class _loginView extends State<loginView> {
  bool showPassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String userName = ''; // Variable para almacenar el nombre del usuario
  String userEmail =
      ''; // Variable para almacenar el correo electrónico del usuario
  //drawer(userName: userName, userEmail: userEmail);

  Future<void> loginUser() async {
    final String url = 'https://apisublimarce.onrender.com/login';

    final response = await http.post(
      Uri.parse(url),
      body: {
        'Email': emailController.text,
        'Contrasena': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final dynamic data = jsonDecode(response.body);
      //print(response.body);
      final user = data['user'];
      // Imprime las credenciales ingresadas y los valores del servidor
      //print('Credenciales ingresadas - Email: ${emailController.text}, Contraseña: ${passwordController.text}');
      //print('Valores del servidor - Email: ${user['CORREO']}, Contraseña: ${user['CONTRASEÑA']}');

      if (user['CORREO'].toLowerCase() == emailController.text.toLowerCase() &&
          user['CONTRASE\u00d1A'] == passwordController.text) {
        // Datos coinciden, navega a Home
        userName = user['NOMBRE'];
        userEmail = user['CORREO'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userName', userName);
        await prefs.setString('userEmail', userEmail);
        //print(userName);
        //print(userEmail);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                Home(userName: userName, userEmail: userEmail),
          ),
        );
      } else {
        print("Credenciales incorrectas");
      }
    } else {
      print(
          "Error de conexión: ${response.statusCode} - ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 130,
        child: Image.asset("assets/logo_si.png"),
      ),
    );

    final email = TextFormField(
      controller: emailController,
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Ingrese su correo",
          suffixIcon: const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.account_circle,
              size: 30.0,
              color: Color.fromARGB(255, 190, 190, 190),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.purple, width: 4)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.purple, width: 4))),
    );

    final password = TextFormField(
      controller: passwordController,
      style: const TextStyle(
        color: Colors.black,
      ),
      autofocus: false,
      obscureText: !showPassword,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: "Ingrese su contraseña",
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
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
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.purple, width: 4)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.purple, width: 4))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: loginUser,
        padding: EdgeInsets.all(12),
        color: Color.fromARGB(255, 219, 36, 176),
        child: Text(
          "Log In",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    final signInLabel = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: 'Don’t have an account? Swipe right to',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          TextSpan(
            text: ' create a new account.',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 92, 92),
              decoration: TextDecoration.underline,
              fontSize: 20,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.of(context).pushNamed(registerView.tag);
              },
          ),
        ],
      ),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.lightBlue, Colors.purple])),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(24.0),
              children: <Widget>[
                logo,
                const SizedBox(height: 15.0),
                email,
                const SizedBox(height: 8.0),
                password,
                const SizedBox(height: 8.0),
                loginButton,
                signInLabel,
              ],
            ))
          ],
        ),
      ),
    );
  }
}

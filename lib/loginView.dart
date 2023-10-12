import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

import 'home.dart';
import 'registerView.dart';

class loginView extends StatefulWidget {
  static String tag = "loginView";
  @override
  _loginView createState() => new _loginView();
}

class _loginView extends State<loginView> {
  bool showPassword = false;
  Map<String, String> loginData = {
    'Email': '',
    'Contrasena': '',
  };

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
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
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
              borderSide: const BorderSide(color: Colors.purple, width: 4))),
    );

    final password = TextFormField(
      style: const TextStyle(
        color: Colors.black,
      ),
      autofocus: false,
      initialValue: '',
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
              borderSide: const BorderSide(color: Colors.purple, width: 4))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(Home.tag);
        },
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
              color: Colors.black,
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

class _home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class _registerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return registerView();
  }
}

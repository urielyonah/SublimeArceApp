import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home.dart';
import 'registerView.dart';

class loginView extends StatefulWidget {
  @override
  _loginView createState() => _loginView();
}

class _loginView extends State<loginView> {
  bool showPassword = false;
  Map<String, String> loginData = {
    'Email': '',
    'Contrasena': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 244, 243, 255),
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Card(
                margin: EdgeInsets.all(16.0),
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'USERNAME / EMAIL',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: "Ingrese su correo",
                            suffixIcon: Icon(
                              Icons.account_circle,
                              size: 30.0,
                              color: const Color.fromARGB(255, 190, 190, 190),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'PASSWORD',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            hintText: "Ingrese su contraseña",
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                width: 350,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 255, 92, 92),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _home(),
                      ),
                    );
                  },
                  child: Text(
                    'LOG IN',
                    style: GoogleFonts.getFont(
                      'Lato',
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RichText(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => _registerView(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
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

class _registerView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return registerView();
  }
}
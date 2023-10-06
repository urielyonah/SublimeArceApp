import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class registerView extends StatefulWidget {
  @override
  _registerView createState() => _registerView();
}

class _registerView extends State<registerView> {
  bool showPassword = false;
  bool showPassword2 = false;
  Map<String, String> loginData = {
    'Email': '',
    'Contrasena': '',
  };

  void register() {
    // Obtener los valores ingresados por el usuario
    String? email = loginData['Email'];
    String? password = loginData['Contrasena'];

    // Aquí puedes realizar las acciones necesarias para registrar al usuario
    // Por ejemplo, puedes enviar estos valores a un servidor o guardarlos localmente.

    // Imprimir los valores para verificar que se han almacenado correctamente
    print('Email: $email');
    print('Contraseña: $password');
  }

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
                'Register',
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
                            'EMAIL',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              loginData['Email'] = value;
                            });
                          },
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
                          onChanged: (value) {
                            setState(() {
                              loginData['Contrasena'] = value;
                            });
                          },
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            'CONFIRM PASSWORD',
                            style: TextStyle(
                              color: Color(0xFF707070),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          obscureText: !showPassword2,
                          decoration: InputDecoration(
                            hintText: "Ingrese su contraseña",
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword2
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 30.0,
                                color: const Color.fromARGB(255, 190, 190, 190),
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword2 = !showPassword2;
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
                    register();
                  },
                  child: Text(
                    'Register',
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
            ],
          ),
        ),
      ),
    );
  }
}

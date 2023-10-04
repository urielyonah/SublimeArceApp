import 'package:flutter/material.dart';
import 'home.dart';
import 'package:google_fonts/google_fonts.dart';

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
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'USERNAME / EMAIL',
                      style: TextStyle(
                        color: Color(0xFF707070),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Ingrese su correo",
                        suffixIcon: Icon(
                          Icons.account_circle,
                          size: 30.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'PASSWORD',
                      style: TextStyle(
                        color: Color(0xFF707070),
                        fontWeight: FontWeight.bold,
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
                            color: Colors.black,
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

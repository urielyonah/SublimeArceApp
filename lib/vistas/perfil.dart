import 'package:ejercicio1/bd/UserData.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class Perfil extends StatefulWidget {
  const Perfil({super.key});
  static String tag = "perfil";

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  bool isObscuresPassword = true;
  bool areFieldsEnabled = false;
  String _imagePath = 'assets/perfil-placeholder.jpg';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Actualiza la ruta de la imagen.
      });
    }
  }

  void EditarPerfil() async {
    final response = await http.put(
      Uri.parse(
          "https://apisublimarce.onrender.com/editarPerfil/${UserData().userId}"),
      body: {
        'email': emailController.text,
        'password': passwordController.text,
        'name': nameController.text,
        'phone': telefonoController.text,
        'address': direccionController.text,
      },
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuario Editado Exitosamente!'),
        ),
      );
    } else {
      print('Error al editar usuario: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();

    // Inicializa los controladores con los datos del usuario
    nameController.text = UserData().userName;
    emailController.text = UserData().userEmail;
    passwordController.text = UserData().userPassword;
    direccionController.text = UserData().userDireccion;
    telefonoController.text = UserData().userPhone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  areFieldsEnabled = !areFieldsEnabled;
                });
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(_imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 4, color: Colors.white),
                              color: Colors.blue),
                          child: IconButton(
                              onPressed: () {
                                _pickImage();
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              )),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              buildTextField("FULL NAME", "", false, nameController),
              buildTextField("EMAIL", "", false, emailController),
              buildTextField("PASSWORD", "", true, passwordController),
              buildTextField("DIRECCION", "------", false, direccionController),
              buildTextField("TELEFONO", "(52+)", false, telefonoController),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      nameController.text = UserData().userName;
                      emailController.text = UserData().userEmail;
                      direccionController.text = UserData().userDireccion;
                      telefonoController.text = UserData().userPhone;
                      passwordController.text = UserData().userPassword;
                      setState(() {
                        areFieldsEnabled = false;
                      });
                    },
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black)),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      EditarPerfil();
                      UserData().userName = nameController.text;
                      UserData().userEmail = emailController.text;
                      UserData().userDireccion = direccionController.text;
                      UserData().userPhone = telefonoController.text;
                      UserData().userPassword = passwordController.text;
                    },
                    child: const Text("SAVE",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: IgnorePointer(
          ignoring: !areFieldsEnabled,
          child: Opacity(
            opacity: areFieldsEnabled ? 1.0 : 0.6,
            child: TextField(
              controller: controller,
              obscureText: isPasswordTextField ? isObscuresPassword : false,
              decoration: InputDecoration(
                  suffixIcon: isPasswordTextField
                      ? IconButton(
                          icon: Icon(isObscuresPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              isObscuresPassword = !isObscuresPassword;
                            });
                          })
                      : null,
                  contentPadding: const EdgeInsets.only(bottom: 5),
                  labelText: labelText,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: placeholder,
                  hintStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
            ),
          ),
        ));
  }
}

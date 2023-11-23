import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path; // Actualiza la ruta de la imagen.
      });
    }
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
              buildTextField("FULL NAME", "", false),
              buildTextField("EMAIL", "", false),
              buildTextField("PASSWORD", "", true),
              buildTextField("DIRECCION", "------", false),
              buildTextField("TELEFONO", "(52+)", false),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
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
                    onPressed: () {},
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

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: IgnorePointer(
          ignoring: !areFieldsEnabled,
          child: Opacity(
            opacity: areFieldsEnabled ? 1.0 : 0.6,
            child: TextField(
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

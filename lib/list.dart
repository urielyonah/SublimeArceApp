import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'bd/conection.dart';

class listpage extends StatefulWidget {
  @override
  _listpage createState() => _listpage();
}

class _listpage extends State<listpage> {
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  List users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Clientes'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text(user['CORREO']),
            subtitle: Text(user['CONTRASEÑA']),
          );
        },
      ),
    );
  }

  Future<void> getUsers() async {
    final url = 'https://apisublimarce.onrender.com/getclientes';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final dynamic jsonData = jsonDecode(response.body);

      if (jsonData is List) {
        setState(() {
          users = jsonData;
        });
      } else if (jsonData is Map) {
        final result = jsonData['users'] as List;

        setState(() {
          users = result;
        });
      } else {
        // Handle the case where jsonData is neither a List nor a Map.
        // You may want to log an error or handle it accordingly.
      }
    }
  }
}

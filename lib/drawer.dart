import 'package:ejercicio1/vistas/desingView.dart';
import 'package:ejercicio1/vistas/productsView.dart';
import 'package:flutter/material.dart';

class drawer extends StatelessWidget {
  static String tag = 'drawer';
  final String userName;
  final String userEmail;

  drawer({required this.userName, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20))),
      backgroundColor: Colors.pink.shade100,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName:  Text(userName),
            accountEmail:  Text(userEmail),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1501621667575-af81f1f0bacc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1513151233558-d860c5398176?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
                  fit: BoxFit.cover),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('PERFIL'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => desingView()),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Container(
              height: 25,
              width: 25,
              child: Image.asset(
                'assets/camisaTirantes.png',
              ),
            ),
            title: const Text('PRODUCTOS'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => productsView()),
              );
            },
          ),
          ListTile(
            leading: Container(
              height: 25,
              width: 25,
              child: Image.asset(
                'assets/customs.png',
              ),
            ),
            title: const Text('CAMISAS'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => desingView()),
              );
            },
          ),
          Divider(),
          SizedBox(height: 100),
          ListTile(
            title: const Text('Configuración y privacidad'),
            onTap: () => print('PRESIONASTE CONFIGURACION'),
          ),
          ListTile(
            title: const Text('Centro de ayuda'),
            onTap: () => print('PRESIONASTE CENTRO'),
          ),
        ], //fin del children
      ),
    );
  }
}

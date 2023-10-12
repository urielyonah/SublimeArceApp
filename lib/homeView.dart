import 'package:flutter/material.dart';
import 'dart:async';

class homeView extends StatefulWidget {
  static String tag = "homeView";
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<homeView> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<String> _imagePaths = [
    'assets/imagen1.jpg',
    'assets/imagen2.jpg',
    'assets/imagen3.jpg',
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < _imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SublimeArce'), // Reemplaza con el nombre de tu empresa
        backgroundColor:
            Colors.blue, // Personaliza el color de acuerdo a tu empresa
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height:
                200, // Ajusta la altura del Slider de imágenes según tus necesidades
            child: PageView.builder(
              controller: _pageController,
              itemCount: _imagePaths.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  _imagePaths[index],
                  fit: BoxFit.cover,
                );
              },
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Impresión de Calidad',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Tu solución de serigrafía personalizada',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 30.0),
          ElevatedButton(
            onPressed: () {
              // Agrega la funcionalidad para ir a la sección de productos o servicios
            },
            child: Text('Ver Productos'),
          ),
          SizedBox(height: 20.0),
          // Agrega más apartados de descripción de la empresa aquí
        ],
      ),
    );
  }
}

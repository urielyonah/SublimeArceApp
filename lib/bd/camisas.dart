class Camisas {
  final int id;
  final String modelo;
  final String tallas;
  final String color;
  final double precio;
  final String descripcion;
  final int stock;
  final String imagen;

  Camisas( this.id, this.modelo, this.tallas, this.color, this.precio, this.descripcion, this.stock, this.imagen);

  Camisas.fromJson(Map<String, dynamic> json)
      : id = json['ID-CAMISAS'] as int,
        modelo = json['MODELO'] as String,
        tallas = json['TALLAS'] as String,
        color = json['COLOR'] as String,
        precio = json['PRECIO'] as double,
        descripcion = json['DESCRIPCION'] as String,
        stock = json['stock'] as int,
        imagen = json['IMAGEN'] as String;
}


import 'dart:convert';

class Category {
  Category({
        this.idCategoria,
        this.nombre,
        this.descripcion
    });

    int? idCategoria;
    String? nombre;
    String? descripcion;

    factory Category.fromRawJson(String str) => Category.fromMap(json.decode(str));

    factory Category.fromMap(Map<String, dynamic> json) => Category(
        idCategoria: json["idCategoria"],
        nombre: json["nombre"],
        descripcion: json["descripcion"],
    );

    Category copy() => Category(
      idCategoria: idCategoria,
      nombre: nombre,
      descripcion: descripcion
    );

}
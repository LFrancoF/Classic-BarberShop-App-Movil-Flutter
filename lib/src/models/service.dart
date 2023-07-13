import 'dart:convert';

class Service {
  Service({
        this.idServicio,
        this.nombre,
        this.imagen,
        this.categoria,
        this.precio,
        this.duracion,
        this.descripcion
    });

    int? idServicio;
    String? nombre;
    String? imagen;
    String? categoria;
    double? precio;
    int? duracion;
    String? descripcion;

    factory Service.fromRawJson(String str) => Service.fromMap(json.decode(str));

    factory Service.fromMap(Map<String, dynamic> json) => Service(
        idServicio: json["idServicio"],
        nombre: json["nombre"],
        imagen: json["imagen"],
        categoria: json["categoria"],
        precio: double.tryParse(json["precio"]),
        duracion: json["duracion"],
        descripcion: json["descripcion"],
    );

    Service copy() => Service(
      idServicio: idServicio,
      nombre: nombre,
      imagen: imagen,
      categoria: categoria,
      precio: precio,
      duracion: duracion,
      descripcion: descripcion
    );

}
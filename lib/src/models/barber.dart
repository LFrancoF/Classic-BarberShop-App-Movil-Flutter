import 'dart:convert';

class Barber {
  Barber({
        this.idBarbero,
        this.nombre,
        this.apellido,
    });

    int? idBarbero;
    String? nombre;
    String? apellido;

    factory Barber.fromRawJson(String str) => Barber.fromMap(json.decode(str));

    factory Barber.fromMap(Map<String, dynamic> json) => Barber(
        idBarbero: json["idBarbero"],
        nombre: json["nombre"],
        apellido: json["apellido"],
    );

}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_classic/src/config.dart';

import '../share_preferences/user.dart';


class CitaService extends ChangeNotifier{
  
  Future<String?> createCita({
    required String fecha, required String hora, required String idCliente, required String idBarbero, 
    required String idServicio, required String costo, required String nota, required String estado, String? idForm
    }) async{
    final Map<String, dynamic> userData = {
      'fecha' : fecha,
      'hora' : hora,
      'idCliente' : idCliente,
      'idBarbero' : idBarbero,
      'idServicio' : idServicio,
      'costo' : costo,
      'nota' : nota,
      'estado' : estado,
      'idForm' : idForm
    };
    
    final Map<String, String> headerData = {
      'Content-Type' : "application/json",
      'Cookie' : 'token=${User.token}',
    };

    final url = Uri.http(Config.apiURL, Config.createCitaRoute);

    final resp = await http.post(url, body: json.encode(userData), headers: headerData);

    final Map<String, dynamic> response = {
      'error' : null
    };
    final data = json.decode(resp.body);

    if (resp.statusCode != 200){ 
      response['error'] = data[0];
      return response['error'];
    }

    return null;
  }

}
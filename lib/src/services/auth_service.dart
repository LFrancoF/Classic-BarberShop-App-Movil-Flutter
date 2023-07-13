import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_classic/src/config.dart';

import '../share_preferences/user.dart';


class AuthService extends ChangeNotifier{
  
  Future<String?> register(String nombre, String apellido, String email, String telefono, String password) async{
    final Map<String, dynamic> userData = {
      'nombre' : nombre,
      'apellido' : apellido,
      'email' : email,
      'telefono' : telefono,
      'password' : password,
      'idRol' : 3
    };
    
    final Map<String, String> headerData = {
      'Content-Type' : "application/json",
    };

    final url = Uri.http(Config.apiURL, Config.registerRoute);

    final resp = await http.post(url, body: json.encode(userData), headers: headerData);

    final Map<String, dynamic> response = {
      'error' : null
    };
    final data = json.decode(resp.body);

    if (resp.statusCode == 400 || resp.statusCode == 409 || resp.statusCode == 500){ 
      response['error'] = data[0];
      return response['error'];
    }

    return null;
  }
  
  Future<Map<String, dynamic>> login(String email, String password) async{
    final Map<String, dynamic> userData = {
      'email' : email,
      'password' : password
    };
    
    final Map<String, String> headerData = {
      'Content-Type' : "application/json",
    };

    final url = Uri.http(Config.apiURL, Config.loginRoute);

    final resp = await http.post(url, body: json.encode(userData), headers: headerData);

    final Map<String, dynamic> response = {
      'error' : null,
      'user' : null
    };
    final data = json.decode(resp.body);

    if (resp.statusCode == 400) response['error'] = data[0];

    if (resp.statusCode == 200) {
      response['user'] = data;
      User.idCliente = response['user']['idCliente'].toString();
      User.nombre = response['user']['nombre'];
      User.apellido = response['user']['apellido'];
      User.telefono = response['user']['telefono'];
      User.email = response['user']['email'];
      User.rol = response['user']['rol'];
      User.token = response['user']['token'];
    }

   return response;
  }

  Future<String?> logout() async{
  
    final url = Uri.http(Config.apiURL, Config.logoutRoute);

    final resp = await http.post(url);

    if(resp.statusCode == 200) {
      User.idCliente=''; User.nombre=''; User.apellido=''; User.email=''; User.telefono=''; User.rol=''; User.token='';
      return null;
    }

    return "Fallo al cerrar sesion";
  }

}
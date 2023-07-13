import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_classic/src/config.dart';

import '../share_preferences/user.dart';


class FormRecomendService extends ChangeNotifier{
  
  Future<Map<String, dynamic>> createFormRecomend({required String imagen, required String idCategoria, required String idCliente}) async{
    final Map<String, dynamic> userData = {
      'imagen' : imagen,
      'idCategoria' : idCategoria,
      'idCliente' : idCliente
    };
    
    final Map<String, String> headerData = {
      'Content-Type' : "application/json",
      'Cookie' : 'token=${User.token}',
    };

    final url = Uri.parse(Config.apiURL+ Config.createFormRecomendRoute);

    final resp = await http.post(url, body: json.encode(userData), headers: headerData);

    final Map<String, dynamic> response = {
      'error' : null,
      'form' : null
    };
    final data = json.decode(resp.body);

    if (resp.statusCode != 200){ 
      response['error'] = data[0];
    }else{
      response['form'] = data;
      User.formRecomend = response['form']['idForm'].toString();
    }

    return response;
  }
  
  Future< String? > uploadImage(String path) async{
    //alternativa a Uri.parse()
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dtpxjlijj/image/upload?upload_preset=recomend-czfv4sem');
    
    //Para hacer la request a Cloudinary
    final imageUploadRequest = http.MultipartRequest('POST', url);

    //se guarda el archivo de tipo File en esta variable
    final imageFile = File.fromUri(Uri(path: path));

    //Para guardar el archivo
    final file = await http.MultipartFile.fromPath('file', imageFile.path);

    //añadimos el archivo al request
    imageUploadRequest.files.add(file);

    //Realizamos la peticion
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final decodedData = json.decode(resp.body);
    return decodedData['secure_url'];

  }

}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_classic/src/config.dart';

import 'package:app_classic/src/models/models.dart';
import '../share_preferences/user.dart';


class BarberService extends ChangeNotifier{
  
  List<Barber> barbers = [];

  BarberService(){
    getBarbers();
  }
  
  Future< List< Barber > > getBarbers() async{

    final Map<String, String> headerData = {
      'Cookie' : 'token=${User.token}',
    };
    
    final url = Uri.http(Config.apiURL, Config.barberRoute);

    final resp = await http.get(url, headers: headerData);

    final List<dynamic> barbersList = jsonDecode(resp.body);

    if (resp.statusCode == 200){
      for (var barber in barbersList) {
        final tempBarber = Barber.fromMap(barber);
        barbers.add(tempBarber);
      }
    }

   return barbers;
  } 

}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_classic/src/config.dart';

import 'package:app_classic/src/models/models.dart';
import '../share_preferences/user.dart';


class ServicesService extends ChangeNotifier{
  
  bool isLoading = true;
  List<Service> services = [];

  late Service selectedService;

  ServicesService(){
    getServices();
  }
  
  Future< List< Service > > getServices() async{

    isLoading = true;
    notifyListeners();

    final Map<String, String> headerData = {
      'Cookie' : 'token=${User.token}',
    };
    
    final url = Uri.parse(Config.apiURL+ Config.serviceRoute);

    final resp = await http.get(url, headers: headerData);

    final List<dynamic> servicesList = jsonDecode(resp.body);

    if (resp.statusCode == 200){
      for (var service in servicesList) {
        final tempService = Service.fromMap(service);
        services.add(tempService);
      }
    }

    isLoading = false;
    notifyListeners();

   return services;
  } 

}
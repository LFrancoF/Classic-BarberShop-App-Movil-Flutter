import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app_classic/src/config.dart';

import 'package:app_classic/src/models/models.dart';
import '../share_preferences/user.dart';


class CategoriesService extends ChangeNotifier{
  
  bool isLoading = true;
  List<Category> categories = [];

  late Category selectedCategory;

  CategoriesService(){
    getCategories();
  }
  
  Future< List< Category > > getCategories() async{

    isLoading = true;
    notifyListeners();

    final Map<String, String> headerData = {
      'Cookie' : 'token=${User.token}',
    };
    
    final url = Uri.http(Config.apiURL, Config.categoryRoute);

    final resp = await http.get(url, headers: headerData);

    final List<dynamic> catList = jsonDecode(resp.body);

    if (resp.statusCode == 200){
      for (var cat in catList) {
        final tempCat = Category.fromMap(cat);
        categories.add(tempCat);
      }
    }

    isLoading = false;
    notifyListeners();

   return categories;
  } 

}
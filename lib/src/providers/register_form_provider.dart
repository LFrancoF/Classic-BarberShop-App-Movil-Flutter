import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  
  GlobalKey<FormState> formkey = GlobalKey();

  String nombre = '';
  String apellido = '';
  String email = '';
  String telefono = '';
  String password = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
    return formkey.currentState?.validate() ?? false;
  }

}
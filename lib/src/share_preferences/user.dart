import 'package:shared_preferences/shared_preferences.dart';

class User {
  static late SharedPreferences _prefs;

  static String _idcliente = '';
  static String _nombre = '';
  static String _apellido = '';
  static String _telefono = '';
  static String _email = '';
  static String _rol = '';
  static String _token = '';
  static String _formRecomend = '';
  static bool _isDarkMode = false;

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static String get idCliente {
    return _prefs.getString('idCliente') ?? _idcliente;
  }

  static set idCliente(String idCliente){
    _idcliente = idCliente;
    _prefs.setString('idCliente', idCliente);
  }

  static String get nombre {
    return _prefs.getString('nombre') ?? _nombre;
  }

  static set nombre(String nombre){
    _nombre = nombre;
    _prefs.setString('nombre', nombre);
  }

  static String get apellido {
    return _prefs.getString('apellido') ?? _apellido;
  }

  static set apellido(String apellido){
    _apellido = apellido;
    _prefs.setString('apellido', apellido);
  }

  static String get telefono {
    return _prefs.getString('telefono') ?? _telefono;
  }

  static set telefono(String telefono){
    _telefono = telefono;
    _prefs.setString('telefono', telefono);
  }

  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String email){
    _email = email;
    _prefs.setString('email', email);
  }

  static String get rol {
    return _prefs.getString('rol') ?? _rol;
  }

  static set rol(String rol){
    _rol = rol;
    _prefs.setString('rol', rol);
  }

  static String get token {
    return _prefs.getString('token') ?? _token;
  }

  static set token(String token){
    _token = token;
    _prefs.setString('token', token);
  }

  static String get formRecomend {
    return _prefs.getString('formRecomend') ?? _formRecomend;
  }

  static set formRecomend(String formRecomend){
    _formRecomend = formRecomend;
    _prefs.setString('formRecomend', formRecomend);
  }

  static bool get isdarkmode {
    return _prefs.getBool('isdarkmode') ?? _isDarkMode;
  }

  static set isdarkmode(bool value){
    _isDarkMode = value;
    _prefs.setBool('isdarkmode', value);
  }


}
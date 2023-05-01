import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:insti/classes/cache.dart';

import 'classes/config.dart';
import 'classes/loginresponse.dart';
import 'package:http/http.dart' as http;

import 'classes/proveedor.dart';
import 'utils.dart';

class WebConn{


  // LOGIN
  Future<LoginResponse> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(Config.getServerURL() +  '/login.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al autenticar usuario');
    }
  }

  Future<bool> loadCache(BuildContext context) async{
    bool result = true;
    WebConn().obtenerProveedores().then((proveedores) {
      Cache().proveedores = proveedores;
    }).catchError((error) {
      result = false;
      showMessageDialog(context, 'No se pudo cargar la lista de proveedores');
    });

    return Future.value(result);
  }


  // PROVEEDORES
  Future<List<Proveedor>> obtenerProveedores() async {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + Cache().tokenWeb,
      'Content-Type': 'application/json'
    };

    final response = await http.get(Uri.parse(Config.getServerURL() + '/proveedores'), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['proveedores'];

      List<Proveedor> proveedores = List<Proveedor>.empty(growable: true);
      for (var json in jsonList) {
        Proveedor proveedor = Proveedor.fromJson(json);
        proveedores.add(proveedor);
      }
      return proveedores;

    } else {
      throw Exception('El servidor responde con resultado ' + response.statusCode.toString());
    }
  }



}
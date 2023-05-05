import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:insti/classes/anoacademico.dart';
import 'package:insti/classes/cache.dart';
import 'package:insti/classes/familiaprofesional.dart';
import 'package:insti/classes/grupoproyecto.dart';
import 'package:insti/classes/lineapedido.dart';
import 'package:insti/classes/pedido.dart';
import 'package:insti/classes/tipoiva.dart';

import 'classes/config.dart';
import 'classes/lineapedidoalta.dart';
import 'classes/loginresponse.dart';
import 'package:http/http.dart' as http;

import 'classes/proveedor.dart';
import 'utils.dart';

class WebConn{

  Map<String, String> getHeaders() {
    final Map<String, String> headers = {
      'Authorization': 'Bearer ' + Cache().tokenWeb,
      'Content-Type': 'application/json'
    };
    return headers;
  }

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

  Future<bool> cargarCache(BuildContext context) async{
    bool result = true;

    await WebConn().obtenerProveedores().then((datos) {
      Cache().proveedores = datos;
    }).catchError((error) {
      result = false;
      showMessageDialog(context, 'No se pudo cargar la lista de proveedores. Error: ' + error.toString());
    });

    await WebConn().obtenerFamiliasProfesionales().then((datos) {
      Cache().familiasProfesionales = datos;
    }).catchError((error) {
      result = false;
      showMessageDialog(context, 'No se pudo cargar la lista de familias profesionales. Error: ' + error.toString());
    });

    await WebConn().obtenerGruposDeProyecto().then((datos) {
      Cache().gruposProyecto = datos;
    }).catchError((error) {
      result = false;
      showMessageDialog(context, 'No se pudo cargar la lista de grupos de proyectos. Error: ' + error.toString());
    });

    await WebConn().obtenerTiposIva().then((datos) {
      Cache().tiposIva = datos;
    }).catchError((error) {
      result = false;
      showMessageDialog(context, 'No se pudo cargar la lista de tipos de IVA. Error: ' + error.toString());
    });

    await WebConn().obtenerAnoAcademicoActual().then((datos) {
      Cache().anoAcademico = datos;
    }).catchError((error) {
      result = false;
      showMessageDialog(context, 'No se pudo cargar el año académico actual. Error: ' + error.toString());
    });

    return Future.value(result);
  }



  // PROVEEDORES
  Future<List<Proveedor>> obtenerProveedores() async {
    final response = await http.get(Uri.parse(Config.getServerURL() + '/proveedores'), headers: getHeaders());

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

  // FAMILIAS PROFESIONALES
  Future<List<FamiliaProfesional>> obtenerFamiliasProfesionales() async {
    final response = await http.get(Uri.parse(Config.getServerURL() + '/familias-profesionales'), headers: getHeaders());

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['familias_profesionales'];
      List<FamiliaProfesional> familiasProfesionales = List<FamiliaProfesional>.empty(growable: true);
      for (var json in jsonList) {
        FamiliaProfesional familiaProfesional = FamiliaProfesional.fromJson(json);
        familiasProfesionales.add(familiaProfesional);
      }
      return familiasProfesionales;
    } else {
      throw Exception('El servidor responde con resultado ' + response.statusCode.toString());
    }
  }

  // GRUPOS DE PROYECTO
  Future<List<GrupoProyecto>> obtenerGruposDeProyecto() async {
    final response = await http.get(Uri.parse(Config.getServerURL() + '/grupos-proyectos'), headers: getHeaders());

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['grupos_proyectos'];
      List<GrupoProyecto> gruposProyectos = List<GrupoProyecto>.empty(growable: true);
      for (var json in jsonList) {
        GrupoProyecto grupoProyecto = GrupoProyecto.fromJson(json);
        gruposProyectos.add(grupoProyecto);
      }
      return gruposProyectos;
    } else {
      throw Exception('El servidor responde con resultado ' + response.statusCode.toString());
    }
  }

  // TIPOS DE IVA
  Future<List<TipoIva>> obtenerTiposIva() async {
    final response = await http.get(Uri.parse(Config.getServerURL() + '/tipos-ivas'), headers: getHeaders());

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['tipos_ivas'];
      List<TipoIva> tiposIva = List<TipoIva>.empty(growable: true);
      for (var json in jsonList) {
        TipoIva tipoIva = TipoIva.fromJson(json);
        tiposIva.add(tipoIva);
      }
      return tiposIva;
    } else {
      throw Exception('El servidor responde con resultado ' + response.statusCode.toString());
    }
  }

  // PEDIDOS
  Future<List<Pedido>> obtenerPedidos() async {
    final response = await http.get(Uri.parse(Config.getServerURL() + '/pedidos?q_ano_actual=true'), headers: getHeaders());

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body)['pedidos'];
      List<Pedido> pedidos = List<Pedido>.empty(growable: true);
      for (var json in jsonList) {
        Pedido pedido = Pedido.fromJson(json);
        pedidos.add(pedido);
      }
      return pedidos;
    } else {
      throw Exception('El servidor responde con resultado ' + response.statusCode.toString());
    }
  }


  // AÑO ACADÉMICO
  Future<AnoAcademico> obtenerAnoAcademicoActual() async {
    final response = await http.get(Uri.parse(Config.getServerURL() + '/ano-academico-actual'), headers: getHeaders());

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body)['ano_academico'];
      return AnoAcademico.fromJson(json);
    } else {
      throw Exception('El servidor responde con resultado ' + response.statusCode.toString());
    }
  }


  Future<bool> crearPedido(
      String destino,
      String proveedor_id,
      String fecha_pedido,
      bool simplificado,
      String observaciones,
      List<LineaPedidoAlta> lineasPedidos,
      ) async {
    var url = Uri.parse(Config.getServerURL() + '/pedidos/crear');
    
     Map<String, String> headers = {
      'Authorization': 'Bearer ' + Cache().tokenWeb,
       // 'Content-Type': 'multipart/form-data; boundary=----WebKitFormBoundaryXeu8ExMoHXtxyoRc'
     };

    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    request.fields['destino'] = destino;
    if (destino.contains('GruposProyectos')){
      request.fields['familia_profesional_id'] = 'null';
      request.fields['grupo_proyecto_id'] = destino.substring(destino.indexOf('_')+1);
    }
    else{
      request.fields['familia_profesional_id'] = destino.substring(destino.indexOf('_')+1);;
      request.fields['grupo_proyecto_id'] = 'null';
    }
    request.fields['proveedor_id'] = proveedor_id;
    request.fields['fecha_pedido'] = fecha_pedido;
    request.fields['usuario_id'] = '';
    request.fields['simplificado'] = simplificado.toString();
    request.fields['observaciones'] = observaciones;
    
    for (var i = 0; i < lineasPedidos.length; i++) {
      final linea = lineasPedidos[i];
      if (simplificado){
        linea.unidadesSolicitadas = 1;
      }
      final mapaLinea = linea.toMap();
      mapaLinea.keys.forEach((key) {
        final value = mapaLinea[key];
        final valueStr = value.toString();
        final fieldKey = 'lineas_pedidos[$i][$key]';
        request.fields[fieldKey] = valueStr;
      });
    }

    var respuesta = await request.send();

    // Si la respuesta es exitosa, mostramos el mensaje
    if (respuesta.statusCode == 200) {
      return Future.value(true);
    } else {
      print('Error al enviar los datos: ${respuesta.statusCode}');
      return Future.value(false);
    }
  }

}
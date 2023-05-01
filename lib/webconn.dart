import 'dart:convert';
import 'classes/config.dart';
import 'classes/loginresponse.dart';
import 'package:http/http.dart' as http;

class WebConn{


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

}
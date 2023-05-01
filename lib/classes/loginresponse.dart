import 'usuario.dart';

class LoginResponse {
  final String token;
  final Usuario usuario;

  LoginResponse({required this.token, required this.usuario});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      usuario: Usuario.fromJson(json['usuario']),
    );
  }
}

import 'cargo.dart';

class Usuario {
  int id;
  String username;
  String email;
  String firstName;
  String lastName;
  DateTime? activationDate;
  DateTime? tosDate;
  bool active;
  bool isSuperuser;
  String role;
  DateTime? created;
  DateTime? modified;
  bool isDirectivo;
  String additionalData;
  DateTime? lastLogin;
  String phone;
  bool notificacionesEmail;
  bool notificacionesPush;
  List<Cargo> cargos;
  List<dynamic> membresias;

  Usuario({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.activationDate,
    required this.tosDate,
    required this.active,
    required this.isSuperuser,
    required this.role,
    required this.created,
    required this.modified,
    required this.isDirectivo,
    required this.additionalData,
    required this.lastLogin,
    required this.phone,
    required this.notificacionesEmail,
    required this.notificacionesPush,
    required this.cargos,
    required this.membresias,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    List<Cargo> cargos = [];
    if (json['cargos'] != null) {
      json['cargos'].forEach((cargo) {
        cargos.add(Cargo.fromJson(cargo));
      });
    }

    return Usuario(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      activationDate: (json['activation_date'] != null) ? DateTime.parse(json['activation_date']) : null,
      tosDate: (json['tosDate'] != null) ? DateTime.parse(json['tosDate']) : null,
      active: json['active'],
      isSuperuser: json['is_superuser'],
      role: json['role'],
      created: (json['created'] != null) ? DateTime.parse(json['created']) : null,
      modified: (json['modified'] != null) ? DateTime.parse(json['modified']) : null,
      isDirectivo: json['is_directivo'],
      additionalData: json['additional_data'],
      lastLogin: (json['lastLogin'] != null) ? DateTime.parse(json['lastLogin']) : null,
      phone: json['phone'],
      notificacionesEmail: json['notificaciones_email'],
      notificacionesPush: json['notificaciones_push'],
      cargos: cargos,
      membresias: json['membresias'],
    );
  }
}
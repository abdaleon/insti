class Proveedor {
  final int id;
  final DateTime? created;
  final DateTime? modified;
  final String nombre;
  final String direccion;
  final String ciudad;
  final String telefono;
  final String email;
  final String nif;
  final int provinciaId;
  final String? codigoPostal;
  final String sector;
  final String paisIso;
  final String fax;
  final String web;
  final String iban;
  final bool activo;
  final bool homologado;

  Proveedor({
    required this.id,
    this.created,
    this.modified,
    required this.nombre,
    required this.direccion,
    required this.ciudad,
    required this.telefono,
    required this.email,
    required this.nif,
    required this.provinciaId,
    this.codigoPostal,
    required this.sector,
    required this.paisIso,
    required this.fax,
    required this.web,
    required this.iban,
    required this.activo,
    required this.homologado,
  });

  factory Proveedor.fromJson(Map<String, dynamic> json) {
    return Proveedor(
      id: json['id'],
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      nombre: json['nombre'],
      direccion: json['direccion'],
      ciudad: json['ciudad'],
      telefono: json['telefono'],
      email: json['email'],
      nif: json['nif'],
      provinciaId: json['provincia_id'],
      codigoPostal: json['codigo_postal'],
      sector: json['sector'],
      paisIso: json['pais_iso'],
      fax: json['fax'],
      web: json['web'],
      iban: json['iban'],
      activo: json['activo'],
      homologado: json['homologado'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created?.toIso8601String();
    data['modified'] = this.modified?.toIso8601String();
    data['nombre'] = this.nombre;
    data['direccion'] = this.direccion;
    data['ciudad'] = this.ciudad;
    data['telefono'] = this.telefono;
    data['email'] = this.email;
    data['nif'] = this.nif;
    data['provincia_id'] = this.provinciaId;
    data['codigo_postal'] = this.codigoPostal;
    data['sector'] = this.sector;
    data['pais_iso'] = this.paisIso;
    data['fax'] = this.fax;
    data['web'] = this.web;
    data['iban'] = this.iban;
    data['activo'] = this.activo;
    data['homologado'] = this.homologado;
    return data;
  }
}
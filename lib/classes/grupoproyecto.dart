class GrupoProyecto {
  int id;
  String nombre;
  String? descripcion;
  bool? activo;
  DateTime? created;
  DateTime? modified;
  double? presupuesto;

  GrupoProyecto({
    required this.id,
    required this.nombre,
    this.descripcion,
    this.activo,
    this.created,
    this.modified,
    this.presupuesto,
  });

  factory GrupoProyecto.fromJson(Map<String, dynamic> json) {
    return GrupoProyecto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      activo: json['activo'],
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      presupuesto: json['presupuesto'] != null ? double.parse(json['presupuesto'].toString()) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    data['activo'] = this.activo;
    data['created'] = this.created?.toIso8601String();
    data['modified'] = this.modified?.toIso8601String();
    data['presupuesto'] = this.presupuesto;
    return data;
  }
}

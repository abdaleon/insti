class FamiliaProfesional {
  int id;
  String codigo;
  String nombre;
  bool activo;
  DateTime? created;
  DateTime? modified;
  int? jefedepartamento_id;
  int? jefecomprasdepartamento_id;
  double? presupuesto;
  bool es_departamento;

  FamiliaProfesional({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.activo,
    this.created,
    this.modified,
    this.jefedepartamento_id,
    this.jefecomprasdepartamento_id,
    this.presupuesto,
    required this.es_departamento,
  });

  factory FamiliaProfesional.fromJson(Map<String, dynamic> json) {
    return FamiliaProfesional(
      id: json['id'],
      codigo: json['codigo'],
      nombre: json['nombre'],
      activo: json['activo'],
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      jefedepartamento_id: json['jefedepartamento_id'],
      jefecomprasdepartamento_id: json['jefecomprasdepartamento_id'],
      presupuesto: json['presupuesto'],
      es_departamento: json['es_departamento'],
    );
  }
}
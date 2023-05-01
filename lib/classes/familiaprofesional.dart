class FamiliaProfesional {
  int id;
  String codigo;
  String nombre;
  bool activo;
  String created;
  String modified;
  int jefedepartamento_id;
  int jefecomprasdepartamento_id;
  double presupuesto;
  bool es_departamento;

  FamiliaProfesional({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.activo,
    required this.created,
    required this.modified,
    required this.jefedepartamento_id,
    required this.jefecomprasdepartamento_id,
    required this.presupuesto,
    required this.es_departamento,
  });

  factory FamiliaProfesional.fromJson(Map<String, dynamic> json) {
    return FamiliaProfesional(
      id: json['id'],
      codigo: json['codigo'],
      nombre: json['nombre'],
      activo: json['activo'],
      created: json['created'],
      modified: json['modified'],
      jefedepartamento_id: json['jefedepartamento_id'],
      jefecomprasdepartamento_id: json['jefecomprasdepartamento_id'],
      presupuesto: json['presupuesto'],
      es_departamento: json['es_departamento'],
    );
  }
}
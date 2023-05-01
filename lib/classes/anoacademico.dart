class AnoAcademico {
  int id;
  String ano;
  DateTime? created;
  DateTime? modified;
  bool activo;

  AnoAcademico({
    required this.id,
    required this.ano,
    required this.created,
    required this.modified,
    required this.activo,
  });

  factory AnoAcademico.fromJson(Map<String, dynamic> json) {
    return AnoAcademico(
        id: json['id'],
        ano: json['nombre'],
        created: DateTime.parse(json['created']),
        modified: DateTime.parse(json['modified']),
        activo: json['activo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': ano,
    'created': created?.toIso8601String(),
    'modified': modified?.toIso8601String(),
    'activo': activo,
  };
}
class AnoAcademico {
  int id;
  String ano;
  DateTime? created;
  DateTime? modified;
  bool activo;

  AnoAcademico({
    required this.id,
    required this.ano,
    this.created,
    this.modified,
    required this.activo,
  });

  factory AnoAcademico.fromJson(Map<String, dynamic> json) {
    return AnoAcademico(
      id: json['id'],
      ano: json['ano'],
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      activo: json['activo'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'ano': ano,
    'created': created?.toIso8601String(),
    'modified': modified?.toIso8601String(),
    'activo': activo,
  };
}
class Iva{
  final int id;
  final DateTime? created;
  final DateTime? modified;
  final int tipo;
  final bool activo;

  Iva({
    required this.id,
    this.created,
    this.modified,
    required this.tipo,
    required this.activo,
  });

  factory Iva.fromJson(Map<String, dynamic> json) {
    return Iva(
      id: json['id'],
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      tipo: json['tipo'],
      activo: json['activo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created?.toIso8601String(),
      'modified': modified?.toIso8601String(),
      'tipo': tipo,
      'activo': activo,
    };
  }
}
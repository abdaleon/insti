class Cargo {
  int id;
  String nombre;
  DateTime? created;
  DateTime? modified;
  int? foreignKey;
  String model;

  Cargo({
    required this.id,
    required this.nombre,
    this.created,
    this.modified,
    required this.foreignKey,
    required this.model,
  });

  factory Cargo.fromJson(Map<String, dynamic> json) {
    return Cargo(
        id: json['id'],
        nombre: json['nombre'],
        created: json['created'] != null ? DateTime.parse(json['created']) : null,
        modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
        foreignKey: json['foreign_key'] ?? 0,
        model: json['model'] ?? ""
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'created': created?.toIso8601String(),
    'modified': modified?.toIso8601String(),
    'foreign_key': foreignKey,
    'model': model
  };
}
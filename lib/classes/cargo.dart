class Cargo {
  int id;
  String nombre;
  DateTime created;
  DateTime modified;
  int? foreignKey;
  String model;

  Cargo({
    required this.id,
    required this.nombre,
    required this.created,
    required this.modified,
    required this.foreignKey,
    required this.model,
  });

  factory Cargo.fromJson(Map<String, dynamic> json) {
    return Cargo(
        id: json['id'],
        nombre: json['nombre'],
        created: DateTime.parse(json['created']),
        modified: DateTime.parse(json['modified']),
        foreignKey: json['foreign_key'] ?? 0,
        model: json['model'] ?? ""
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nombre': nombre,
    'created': created.toIso8601String(),
    'modified': modified.toIso8601String(),
    'foreign_key': foreignKey,
    'model': model
  };
}
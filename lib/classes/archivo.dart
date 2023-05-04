class Archivo {
  int id;
  String nombre;
  String? descripcion;
  bool activo;
  int? orden;
  String file;
  String file_dir;
  int file_size;
  String file_type;
  String? error;
  DateTime? modified;
  DateTime? created;
  int foreign_key;
  String model;
  String? old_model;
  String grp;

  Archivo({
    required this.id,
    required this.nombre,
    this.descripcion,
    required this.activo,
    this.orden,
    required this.file,
    required this.file_dir,
    required this.file_size,
    required this.file_type,
    this.error,
    this.modified,
    this.created,
    required this.foreign_key,
    required this.model,
    this.old_model,
    required this.grp,
  });

  factory Archivo.fromJson(Map<String, dynamic> json) {
    return Archivo(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      activo: json['activo'],
      orden: json['orden'],
      file: json['file'],
      file_dir: json['file_dir'],
      file_size: json['file_size'],
      file_type: json['file_type'],
      error: json['error'],
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      foreign_key: json['foreign_key'],
      model: json['model'],
      old_model: json['old_model'],
      grp: json['grp'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nombre'] = this.nombre;
    data['descripcion'] = this.descripcion;
    data['activo'] = this.activo;
    data['orden'] = this.orden;
    data['file'] = this.file;
    data['file_dir'] = this.file_dir;
    data['file_size'] = this.file_size;
    data['file_type'] = this.file_type;
    data['error'] = this.error;
    data['modified'] = this.modified?.toIso8601String();
    data['created'] = this.created?.toIso8601String();
    data['foreign_key'] = this.foreign_key;
    data['model'] = this.model;
    data['old_model'] = this.old_model;
    data['grp'] = this.grp;
    return data;
  }
}
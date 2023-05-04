import 'package:insti/classes/archivo.dart';
import 'package:insti/classes/familiaprofesional.dart';
import 'package:insti/classes/grupoproyecto.dart';
import 'package:insti/classes/lineapedido.dart';
import 'package:insti/classes/proveedor.dart';

import 'usuario.dart';


class Pedido {
  int id;
  int proveedorId;
  int? familiaProfesionalId;
  int? grupoProyectoId;
  int? facturaId;
  String? familiaProfesionalAlt;
  int? cicloId;
  String? cicloAlt;
  int? cursoId;
  String? cursoAlt;
  int? moduloId;
  String? moduloAlt;
  String estado;
  int usuarioId;
  String? ordenante;
  DateTime fechaPedido;
  DateTime? fechaEntrega;
  bool inventariado;
  int anoAcademicoId;
  int? anoContable;
  double importeEstimado;
  double total;
  DateTime? created;
  DateTime? modified;
  String? notas;
  bool? correoEnviado;
  bool simplificado;
  bool esValorReal;
  String? observaciones;
  Usuario usuario;
  List<Archivo>? archivos;
  List<LineaPedido> lineasPedido;
  Proveedor proveedor;
  GrupoProyecto? grupoProyecto;
  FamiliaProfesional? familiaProfesional;

  Pedido({
      required this.id,
      required this.proveedorId,
      this.familiaProfesionalId,
      this.grupoProyectoId,
      this.facturaId,
      this.familiaProfesionalAlt,
      this.cicloId,
      this.cicloAlt,
      this.cursoId,
      this.cursoAlt,
      this.moduloId,
      this.moduloAlt,
      required this.estado,
      required this.usuarioId,
      this.ordenante,
      required this.fechaPedido,
      this.fechaEntrega,
      required this.inventariado,
      required this.anoAcademicoId,
      this.anoContable,
      required this.importeEstimado,
      required this.total,
      this.created,
      this.modified,
      this.notas,
      this.correoEnviado,
      required this.simplificado,
      required this.esValorReal,
      this.observaciones,
      required this.usuario,
      this.archivos,
      required this.lineasPedido,
      required this.proveedor,
      this.grupoProyecto,
      this.familiaProfesional});

  factory Pedido.fromJSON(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      proveedorId: json['proveedorId'],
      familiaProfesionalId: json['familiaProfesionalId'],
      grupoProyectoId: json['grupoProyectoId'],
      facturaId: json['facturaId'],
      familiaProfesionalAlt: json['familiaProfesionalAlt'],
      cicloId: json['cicloId'],
      cicloAlt: json['cicloAlt'],
      cursoId: json['cursoId'],
      cursoAlt: json['cursoAlt'],
      moduloId: json['moduloId'],
      moduloAlt: json['moduloAlt'],
      estado: json['estado'],
      usuarioId: json['usuarioId'],
      ordenante: json['ordenante'],
      fechaPedido: DateTime.parse(json['fechaPedido']),
      fechaEntrega: json['fechaEntrega'] != null ? DateTime.parse(json['fechaEntrega']) : null,
      inventariado: json['inventariado'],
      anoAcademicoId: json['anoAcademicoId'],
      anoContable: json['anoContable'],
      importeEstimado: json['importeEstimado'],
      total: json['total'],
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      notas: json['notas'],
      correoEnviado: json['correoEnviado'],
      simplificado: json['simplificado'],
      esValorReal: json['esValorReal'],
      observaciones: json['observaciones'],
      usuario: Usuario.fromJson(json['usuario']),
      archivos: List<Archivo>.from(json['archivos'].map((archivo) => Archivo.fromJson(archivo))),
      lineasPedido: List<LineaPedido>.from(json['lineasPedido'].map((linea) => LineaPedido.fromJson(linea))),
      proveedor: Proveedor.fromJson(json['proveedor']),
      grupoProyecto: json['grupoProyecto'] != null ? GrupoProyecto.fromJson(json['grupoProyecto']) : null,
      familiaProfesional: json['familiaProfesional'] != null ? FamiliaProfesional.fromJson(json['familiaProfesional']) : null,
    );
  }
}
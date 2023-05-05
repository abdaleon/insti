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

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      proveedorId: json['proveedor_id'],
      familiaProfesionalId: json['familia_profesional_id'],
      grupoProyectoId: json['grupo_proyecto_id'],
      facturaId: json['factura_id'],
      familiaProfesionalAlt: json['familia_profesional_alt'],
      cicloId: json['ciclo_id'],
      cicloAlt: json['ciclo_alt'],
      cursoId: json['curso_id'],
      cursoAlt: json['curso_alt'],
      moduloId: json['modulo_id'],
      moduloAlt: json['modulo_alt'],
      estado: json['estado'],
      usuarioId: json['usuario_id'],
      ordenante: json['ordenante'],
      fechaPedido: DateTime.parse(json['fecha_pedido']),
      fechaEntrega: json['fecha_entrega'] != null ? DateTime.parse(json['fecha_entrega']) : null,
      inventariado: json['inventariado'],
      anoAcademicoId: json['ano_academico_id'],
      anoContable: json['ano_contable'],
      importeEstimado: json['importe_estimado'] * 1.0,
      total: json['total'] * 1.0,
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      notas: json['notas'],
      correoEnviado: json['correo_enviado'],
      simplificado: json['simplificado'],
      esValorReal: json['es_valor_real'],
      observaciones: json['observaciones'],
      usuario: Usuario.fromJson(json['usuario']),
      archivos: json['archivos'] != null ? List<Archivo>.from(json['archivos'].map((archivo) => Archivo.fromJson(archivo))) : List<Archivo>.empty(),
      lineasPedido: json['lineas_pedidos'] != null ? List<LineaPedido>.from(json['lineas_pedidos'].map((linea) => LineaPedido.fromJson(linea))) : List<LineaPedido>.empty(),
      proveedor: Proveedor.fromJson(json['proveedor']),
      grupoProyecto: json['grupo_proyecto'] != null ? GrupoProyecto.fromJson(json['grupo_proyecto']) : null,
      familiaProfesional: json['familia_profesional'] != null ? FamiliaProfesional.fromJson(json['familia_profesional']) : null,
    );
  }

  
}
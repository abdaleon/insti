class LineaPedido {
  final int id;
  final int pedidoId;
  final int? lineaFacturaId;
  final int? articuloId;
  final String descripcion;
  final double unidadesSolicitadas;
  final double? unidadesServidas;
  final double importeEstimado;
  final DateTime? created;
  final DateTime? modified;
  final int tipoIva;
  final bool esValorReal;
  final String? articulo;

  LineaPedido({
    required this.id,
    required this.pedidoId,
    this.lineaFacturaId,
    this.articuloId,
    required this.descripcion,
    required this.unidadesSolicitadas,
    this.unidadesServidas,
    required this.importeEstimado,
    this.created,
    this.modified,
    required this.tipoIva,
    required this.esValorReal,
    this.articulo,
  });

  factory LineaPedido.fromJson(Map<String, dynamic> json) {
    return LineaPedido(
      id: json['id'],
      pedidoId: json['pedido_id'],
      lineaFacturaId: json['linea_factura_id'],
      articuloId: json['articulo_id'],
      descripcion: json['descripcion'],
      unidadesSolicitadas: json['unidades_solicitadas'],
      unidadesServidas: json['unidades_servidas'],
      importeEstimado: json['importe_estimado'].toDouble(),
      created: json['created'] != null ? DateTime.parse(json['created']) : null,
      modified: json['modified'] != null ? DateTime.parse(json['modified']) : null,
      tipoIva: json['tipo_iva'],
      esValorReal: json['es_valor_real'],
      articulo: json['articulo'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pedido_id'] = this.pedidoId;
    data['linea_factura_id'] = this.lineaFacturaId;
    data['articulo_id'] = this.articuloId;
    data['descripcion'] = this.descripcion;
    data['unidades_solicitadas'] = this.unidadesSolicitadas;
    data['unidades_servidas'] = this.unidadesServidas;
    data['importe_estimado'] = this.importeEstimado;
    data['created'] = this.created?.toIso8601String();
    data['modified'] = this.modified?.toIso8601String();
    data['tipo_iva'] = this.tipoIva;
    data['es_valor_real'] = this.esValorReal;
    data['articulo'] = this.articulo;
    return data;
  }
}

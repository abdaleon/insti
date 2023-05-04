class LineaPedidoAlta {
  String descripcion;
  int unidadesSolicitadas;
  double importeEstimado;
  int tipoIva;

  LineaPedidoAlta({
    required this.descripcion,
    required this.unidadesSolicitadas,
    required this.importeEstimado,
    required this.tipoIva,
  });

  Map<String, dynamic> toMap() {
    return {
      'descripcion': descripcion,
      'unidades_solicitadas': unidadesSolicitadas,
      'importe_estimado': importeEstimado,
      'tipo_iva': tipoIva,
    };
  }
}
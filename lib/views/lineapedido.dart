import 'package:flutter/material.dart';
import 'package:insti/classes/cache.dart';
import 'package:insti/classes/lineapedido.dart';
import 'package:insti/classes/lineapedidoalta.dart';

class LineaPedidoWidget extends StatefulWidget {

  TextEditingController descriptionController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int? selectedIva;


  bool simplificado;

  void updateSimplificado(bool s){
    st.setState(() {
      simplificado = s;
      st.simplificado = s;
    });
  }

  LineaPedidoWidget({required this.simplificado});

  late _LineaPedidoWidgetState st;

  LineaPedido getLineaPedido(){
    return LineaPedido(
        id: 0,
        pedidoId: 0,
        descripcion: descriptionController.text.toString(),
        unidadesSolicitadas: double.tryParse(quantityController.text) ?? 0.0,
        importeEstimado: double.tryParse(amountController.text) ?? 0.0,
        tipoIva: selectedIva!,
        esValorReal: true);  // VOLVER, NO SÉ QUE PONER

  }

  LineaPedidoAlta getLineaPedidoAlta(){
    return LineaPedidoAlta(
      descripcion: descriptionController.text.toString(),
      unidadesSolicitadas: int.tryParse(quantityController.text) ?? 0,
      importeEstimado: double.tryParse(amountController.text) ?? 0.0,
      tipoIva:  selectedIva!,
    ) ;
  }

  @override
  _LineaPedidoWidgetState createState() {
    st = _LineaPedidoWidgetState(simplificado: simplificado);
    return st;
  }
}

class _LineaPedidoWidgetState extends State<LineaPedidoWidget> {



  bool simplificado;


  _LineaPedidoWidgetState({required this.simplificado});

  String getDescripcion(){
    return widget.descriptionController.value.toString();
  }

  void _calculateTotal() {
    double quantity = double.tryParse(widget.quantityController.text) ?? 0.0;
    double amount = double.tryParse(widget.amountController.text) ?? 0.0;
    double total = 0.0;
    if (widget.selectedIva != null){
      if (simplificado){
        quantity = 1.0;
      }
      total = quantity * amount * ( (1.0 +(widget.selectedIva! / 100.0)));
    }
    setState(() {
      widget.totalController.text = total.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(8.0),
        child:
        Column(
          children: [
            const Divider(height: 0.0, thickness: 3.0,color: Colors.teal),

            SizedBox(height: 8.0,),

            Row(
              children: [
                Expanded(
                    child: Container(
                      // color: Colors.deepPurple,
                      child: Text("Descripción", style: TextStyle(fontWeight: FontWeight.bold),),)
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child:
                  Container(
                    // color: Colors.amber,
                    child: TextField(
                      autofocus: false,
                      controller: widget.descriptionController,
                      decoration: InputDecoration(contentPadding: EdgeInsets.all(0.0), alignLabelWithHint: false, isDense: true),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Visibility(
                  visible: !widget.simplificado,
                  child:
                  Expanded(
                      child: Text("Cantidad", style: TextStyle(fontWeight: FontWeight.bold),)
                  ),
                ),
                Visibility(
                  visible: !widget.simplificado,
                  child: SizedBox(width: 8.0),
                ),
                Expanded(
                    child: Text("Importe", style: TextStyle(fontWeight: FontWeight.bold),)
                ),
                Expanded(
                    child: Text("IVA", style: TextStyle(fontWeight: FontWeight.bold),)

                ),
                Expanded(
                    child: Text("Total", style: TextStyle(fontWeight: FontWeight.bold),)

                ),
              ],
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Visibility(
                    visible: !widget.simplificado,
                    child:
                    Expanded(
                      child:
                      Container(
                        margin: EdgeInsets.only(right: 32.0),
                        child:
                        TextField(
                          textAlign: TextAlign.center,
                          controller: widget.quantityController,
                          decoration: InputDecoration(isDense: true),
                          autofocus: false,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          onChanged: (_) => _calculateTotal(),
                        ),
                      ),
                    ),
                ),
                Visibility(
                  visible: !widget.simplificado,
                  child: SizedBox(width: 8.0),
                ),
                Expanded(
                  child:
                  Container(
                    margin: EdgeInsets.only(right: 32.0),
                    child:
                    TextField(
                      textAlign: TextAlign.center,
                      autofocus: false,
                      decoration: InputDecoration(isDense: true),
                      controller: widget.amountController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (_) => _calculateTotal(),
                    ),
                  ),
                ),
                Expanded(
                  child:
                  DropdownButton<int>(
                    isDense: true,
                    autofocus: false,
                    alignment: Alignment.center,
                    underline: Container(
                      height: 0,
                      color: Colors.transparent,
                    ),
                    // hint: Text("IVA"),
                    value: widget.selectedIva,
                    // disabledHint: Text("IVA"),
                    items: Cache().tiposIva
                        .map((tiposIva) => DropdownMenuItem(
                      value: tiposIva.tipo,
                      child: Text(tiposIva.tipo.toString()),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.selectedIva = value;
                      });
                      _calculateTotal();
                    },
                    isExpanded: true,
                  ),

                ),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    textAlign: TextAlign.center,
                    controller: widget.totalController,
                    decoration: InputDecoration(isDense: true, border: InputBorder.none),
                    autofocus: false,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (_) => _calculateTotal(),
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.0,),
            const Divider(height: 2.0, thickness: 2.0,),

          ],
        )
      )

      ;
  }
}

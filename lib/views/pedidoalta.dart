import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:insti/classes/cache.dart';
import 'package:insti/classes/familiaprofesional.dart';
import 'package:insti/classes/grupoproyecto.dart';
import 'package:insti/classes/lineapedidoalta.dart';
import 'package:insti/utils.dart';
import 'package:insti/views/lineapedido.dart';
import 'package:insti/webconn.dart';

class PedidoAlta extends StatefulWidget {
  const PedidoAlta({Key? key}) : super(key: key);

  @override
  _PedidoAltaState createState() => _PedidoAltaState();
}

class _PedidoAltaState extends State<PedidoAlta> {
  bool _isSimplified = true;

  String _selectedDate = '';
  String? _selectedValueDept = null;
  int? _selectedValueProveedor = null;

  List<dynamic> itemsDepartamento = ["Familias profesionales", ...Cache().familiasProfesionales, "Grupos", ...Cache().gruposProyecto];
  List<dynamic> itemsProveedor = [ ...Cache().proveedores];
  List<LineaPedidoWidget> lineasPedidoWidgets = List<LineaPedidoWidget>.empty(growable: true);

  @override
  void initState() {
    super.initState();

    anhadirLinea();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    int dumi = 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo Pedido'),
      ),
      body:
      SingleChildScrollView(
        child:
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // FECHA
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha pedido:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child:
                        DateTimePicker(
                          type: DateTimePickerType.date,
                          dateMask: 'dd/MM/yyyy',
                          initialValue: null,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          locale: const Locale('es', 'ES'),
                          icon: Icon(Icons.event),
                          dateLabelText: 'Fecha',
                          calendarTitle: "Fecha",
                          confirmText: "OK",
                          cancelText: "Cancelar",
                          onChanged: (val) {
                            setState(() => _selectedDate = val);
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Por favor, selecciona una fecha';
                            }
                            return null;
                          },
                          onSaved: (val) => setState((){
                            if (val != null) {
                              _selectedDate = val;
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Año académico:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 60,
                        width: 150,
                        child:
                        Center(
                          child:
                          Text(
                            '2022/23',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black38),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),

              SizedBox(height: 8),

              // DEPARTAMENTO
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Center(child:
                  Text(
                    'Departamento:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ),

                  DropdownButton(
                    value: _selectedValueDept,
                    items: itemsDepartamento.map((item) {
                      String origen = '';
                      String text = '';
                      int code = 0;
                      if (item is FamiliaProfesional) {
                        origen = 'FamiliasProfesionales';
                        text = item.nombre;
                        code = item.id;
                      } else if (item is GrupoProyecto) {
                        origen = 'GruposProyectos';
                        text = item.nombre;
                        code = item.id;
                      }
                      else if (item is String){
                        origen = '';
                        text = item;
                        code = 0;
                      }
                      if (origen.length > 0){
                        return DropdownMenuItem(
                          value: '${origen}_$code',
                          child: Text("   " + text),
                        );
                      }
                      else{
                        // los MenuItem necesitan un valor y admiten duplicados
                        dumi = dumi + 1;
                        return DropdownMenuItem(
                          value: dumi.toString(),
                          child: Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                        );
                      }
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          if ((value as String).length > 1){
                            _selectedValueDept = value as String;
                          }
                        }
                      });
                    },
                  )
                  
                ],
              ),


              // PROVEEDOR
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Center(child:
                  Text(
                    'Proveedor:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ),

                  DropdownButton(
                    value: _selectedValueProveedor,
                    items: Cache().proveedores.map((item) {
                      String text = '';
                      int? code = null;
                      text = item.nombre;
                      code = item.id;
                        return DropdownMenuItem(
                          value: code,
                          child: Text(text),
                        );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                         _selectedValueProveedor = value as int;
                      });
                    },
                  )


                ],
              ),


              // SIMPLIFICADO
              Visibility(
                  visible: lineasPedidoWidgets.length < 2,
                  child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Center(child:
                      Text(
                        'Simplificado:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      ),

                      Row(
                        children: [
                          Switch(
                            value: _isSimplified,
                            onChanged: (value) {
                              setState(() {
                                _isSimplified = value;
                                lineasPedidoWidgets.forEach((element) {
                                  setState(() {
                                    element.updateSimplificado(_isSimplified);
                                  });
                                });
                              });
                            },
                          ),
                        ],
                      ),


                    ],
                  ),
              ),



              // DETALLE
                ListView.builder(
                  itemCount: lineasPedidoWidgets.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {

                    return
                      Row(
                        children: [
                          Expanded( child:  lineasPedidoWidgets[index]),
                          Visibility(
                            visible: !_isSimplified && (lineasPedidoWidgets.length > 1),
                            child:
                            FloatingActionButton(
                              heroTag: "borrarlinea" + index.toString(),
                              onPressed: () {
                                setState(() {
                                  // para evitar que "salte" el teclado
                                  FocusScope.of(context).unfocus();
                                  final widgetAEliminar = lineasPedidoWidgets[index];
                                  lineasPedidoWidgets.remove(widgetAEliminar);
                                  //                               showMessageDialog(context, "Eliminar: " + index.toString() + " " + lineasPedidoWidgets[index].descriptionController.text);
                                });
                              },
                              mini: true,
                              child: Icon(Icons.delete),
                            ),

                          ),

                        ],
                      );


                  },
                ),
              SizedBox(height: 64.0),

            ],
          ),
        ),

      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Visibility(
            replacement:
            FloatingActionButton(
              backgroundColor: Colors.grey,
              onPressed: null,
              child: Icon(Icons.add),
            ),

            visible: !_isSimplified,
              child:
              FloatingActionButton(
                heroTag: 'anadirlinea',
                onPressed: () {
                  setState(() {
                    anhadirLinea();
                  });
                },
                child: Icon(Icons.add),
              ),
          ),
          SizedBox(width: 16),
          FloatingActionButton.extended(
            heroTag: 'registrar',
            onPressed: () {

              /*
      String destino,
      String proveedor_id,
      String fecha_pedido,
      bool simplificado,
      String observaciones,
      List<LineaPedidoAlta> lineas,
              * */

              List<LineaPedidoAlta> l = List<LineaPedidoAlta>.empty(growable: true);
              lineasPedidoWidgets.forEach((element) {
                l.add(element.getLineaPedidoAlta());
              });

              WebConn().crearPedido(
                 _selectedValueDept!,
                _selectedValueProveedor!.toString(),
                _selectedDate,
                _isSimplified,
                "", // VOLVER
                l
              )
              .then((value){
                if (value){
                  Navigator.pop(context, true);
                }
              });

            },
            label: Text('Registrar'),
          ),
        ],
      ),
    );
  }

  void anhadirLinea(){
    lineasPedidoWidgets.add(LineaPedidoWidget(simplificado: _isSimplified,));
  }
}

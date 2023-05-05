import 'package:flutter/material.dart';
import 'package:insti/classes/pedido.dart';
import 'package:insti/views/pedidoalta.dart';
import 'package:insti/webconn.dart';

class ListaPedidos extends StatefulWidget {
  @override
  _ListaPedidosState createState() => _ListaPedidosState();
}

class _ListaPedidosState extends State<ListaPedidos> {
  List<Pedido> pedidos = List<Pedido>.empty(growable: true);

  void traerListaDePedidos(){
    WebConn().obtenerPedidos()
        .then((value) {
      setState(() {
        pedidos.clear();
        pedidos = value.reversed.toList();
      });
    }) ;

  }

  @override
  Widget build(BuildContext context) {

    traerListaDePedidos();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de pedidos"),
      ),
      body: ListView.builder(
          itemCount: pedidos.length,
          itemBuilder: (BuildContext context, int index) {
            Pedido pedido = pedidos[index];
            String destino = "";
            if (pedido.familiaProfesional != null){
              destino = pedido.familiaProfesional!.nombre;
            }
            else{
              if (pedido.grupoProyecto != null){
                destino = pedido.grupoProyecto!.nombre;
              }
            }
            return ExpansionTile(
              title:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("${pedido.id}", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width: 8.0),
                    Text("${pedido.estado}"),
                    SizedBox(width: 8.0),
                    Text("${pedido.fechaPedido.toString().substring(0, pedido.fechaPedido.toString().indexOf(' '))}", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(width: 8.0),
                    Text("${pedido.total.toStringAsFixed(2)}€", style: TextStyle(fontWeight: FontWeight.bold,),),

                  ],
                ),
              // subtitle: Text(""),
              children: [
                ListTile(
                  title:
                  Container(
                    margin: EdgeInsets.only(left: 50.0),
                    child:
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Text("Proveedor: ${pedido.proveedor.nombre}"),
                          Text("Familia/grupo: $destino"),
                        ]
                    ),
                  ),
                )
              ],
            );
          }),
      floatingActionButton:
      FloatingActionButton.extended(
        heroTag: 'nuevo',
        onPressed: () async {
          bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PedidoAlta()));
          if (result != null && result) {
            traerListaDePedidos();
          }
        },
        icon: Icon(Icons.add),
        label: Text('Nuevo'),
      ),
    );
  }
}
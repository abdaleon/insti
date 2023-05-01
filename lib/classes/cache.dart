import 'dart:ffi';

import 'package:insti/classes/anoacademico.dart';
import 'package:insti/classes/familiaprofesional.dart';
import 'package:insti/classes/grupoproyecto.dart';
import 'package:insti/classes/proveedor.dart';
import 'package:insti/classes/tipoiva.dart';

import 'usuario.dart';

class Cache{

  late List<TipoIva>             tiposIva;
  late List<Proveedor>           proveedores;
  late AnoAcademico?             anoAcademico;
  late List<FamiliaProfesional>  familiasProfesionales;
  late List<GrupoProyecto>       gruposProyecto;
  late Usuario?                  usuarioActivo;
  String tokenWeb = "";


  static final Cache _singleton = Cache._internal();

  factory Cache() {
    return _singleton;
  }

  Cache._internal() {
    tiposIva              = List<TipoIva>.empty(growable: true);
    proveedores           = List<Proveedor>.empty(growable: true);
    anoAcademico          = null;
    familiasProfesionales = List<FamiliaProfesional>.empty(growable: true);
    gruposProyecto        = List<GrupoProyecto>.empty(growable: true);
    usuarioActivo         = null;
  }

}
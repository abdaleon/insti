import 'package:flutter/material.dart';
import 'package:insti/mycolors.dart';

import 'login.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infocentros',
      theme: ThemeData(
        primarySwatch: MyColors.buildMaterialColor(),
      ),
      home: Login(),
    );
  }


}



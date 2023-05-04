import 'package:flutter/material.dart';
import 'package:insti/mycolors.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],      supportedLocales: [
        const Locale('es', 'ES'), // Español
      ],
      home: Login(),
    );
  }


}



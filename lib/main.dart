import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insti',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepPurpleAccent,
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.deepPurple),
          bodyText2: TextStyle(color: Colors.deepPurple),
          subtitle1: TextStyle(color: Colors.deepPurpleAccent),
          subtitle2: TextStyle(color: Colors.deepPurpleAccent),
        ),
      ),
      home: LoginPage(),
    );
  }
}


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _storage = FlutterSecureStorage();
  String _username = '';
  String _password = '';
  String _message = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    String username = await _storage.read(key: 'username') ?? "";
    setState(() {
      _username = username;
    });
  }

  void _saveUsername(String username) async {
    await _storage.write(key: 'username', value: username);
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {

     // _username = "usuario1";
      //_password = "clave1";

      String passwordHash = sha256.convert(utf8.encode(_password)).toString();


      String apiUrl = 'http://192.168.1.227/login.php';
      Map<String, String> body = {
        "usuario": _username,
        "clave": passwordHash,
      };

      http.post(Uri.parse(apiUrl), body: body).then((http.Response response) {
        if (response.statusCode == 200) {
          _saveUsername(_username);
          setState(() {
            _message = 'Usuario autentificado';
          });
        } else {
          setState(() {
            _message = 'Usuario no encontrado o contraseña no válida. Error: ' + response.statusCode.toString();
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce un usuario';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _username = value;
                  },
                  initialValue: _username,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor introduce una contraseña';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _password = value;
                  },
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Entrar'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cerrar'),
                ),
                SizedBox(height: 16.0),
                Text(_message),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
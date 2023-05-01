import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:insti/classes/cache.dart';
import 'package:insti/webconn.dart';
import 'classes/usuario.dart';
import 'package:insti/utils.dart';

class Login extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
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

      _username = "secretariopruebas@test.com";
      _password = "1";

      String token = "";
      Usuario? usuario = null;
      WebConn().login(_username, _password)
        .then((value){
          token = value.token;
          usuario = value.usuario;
      })
        .whenComplete((){
          if ((token.length > 0) && (usuario != null)){
            Cache().tokenWeb = token;
            Cache().usuarioActivo = usuario;

          }
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text('Infocentros')),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Aplicación para gestión de instituciones educativas por 2ksystems", textAlign: TextAlign.center, style: TextStyle(fontSize: 16.0)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: _login,
                      child: Text('Entrar'),
                    ),
                    Text("   "),
                    ElevatedButton(
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: Text('Cerrar'),
                    ),
                  ],
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
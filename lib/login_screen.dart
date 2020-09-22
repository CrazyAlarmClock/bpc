import 'package:flutter/material.dart';

import 'home_page.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;

  final globalKey = GlobalKey<ScaffoldState>();



  //401
  //2-3 обед
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              decoration: InputDecoration(hintText: 'любой логин'),
              onChanged: (value) {
                this.email = value;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'pass1'),
              validator: (value) => value.isEmpty ? 'Неверный пароль' : null,
              onChanged: (value) {
                this.password = value;
              },
            ),
          ),
          FlatButton(
            onPressed: () {
              if (password.toString() == '1') {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WorkTabBarScreen()));
              } else{
                final snackBar = SnackBar(content: Text('Неверный пароль'),backgroundColor: Colors.red,);
                globalKey.currentState.showSnackBar(snackBar);
              }
            },
            child: Text('ВОЙТИ'),
          )
        ])));
  }
}

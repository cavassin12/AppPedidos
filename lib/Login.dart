import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controlLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: "Login",
                  labelStyle: TextStyle(color: Colors.amber),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber, width: 1.0)),
                ),
                style: TextStyle(color: Colors.amber, fontSize: 20.0),
                controller: controlLogin,
                keyboardType: TextInputType.number,
              )
            ],
          )
        ],
      ),
    );
  }
}

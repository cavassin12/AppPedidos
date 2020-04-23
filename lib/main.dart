import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(title: "Lançador de Pedido", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: RaisedButton(
        child: Text("Abrir Modal"),
        onPressed: () {
          DialogBusca(context);
        },
      ),
    );
  }

  void DialogBusca(BuildContext context) {
    Dialog dialogo = Dialog(
      child: Container(
        width: 350,
        height: 400,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Text(
                "Dialog With Image",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context)=> dialogo);
  }
}

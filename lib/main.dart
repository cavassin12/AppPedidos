import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() {
  runApp(MaterialApp(title: "Lançador de Pedido", home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map _Clientes = {};

  Future<Map> _buscarClientes() async {
    var url = "http://192.168.15.9/CadApi/Clientes/getClientes";
    http.Response busca = await http.post(url, body: {"idusuario": '1'});
    _Clientes = json.decode(busca.body);
    print('Response body: ' + _Clientes["dados"][0].toString());
    // _Clientes =
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Controles"),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: "Buscar Cliente",
                              labelStyle: TextStyle(
                                  color: Colors.blue, fontSize: 14.0)),
                        )),
                        RaisedButton(
                          child: Icon(Icons.search),
                          onPressed: () {
                            _buscarClientes();
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ListView.builder(
                            padding: EdgeInsets.all(5),
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: _Clientes["dados"][index]["nm_cliente"],
                              );
                            })
                      ],
                    )
                  ],
                ))));
  }

  @override
  // TODO: implement widget
  Widget _ListaCLientes(BuildContext context, int index) {
    return Container(
      color: Colors.white,
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
              decoration: BoxDecoration(color: Colors.grey[100]),
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
    showDialog(context: context, builder: (BuildContext context) => dialogo);
  }
}

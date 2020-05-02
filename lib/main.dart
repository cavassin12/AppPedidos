import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'Login.dart';

void main() {
  runApp(MaterialApp(title: "Lançador de Pedido", home: Login()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map _Clientes = {};
  List _DadosCli = [];
  int _NrPagina = 0;
  int _PorPagina = 4;
  String _DsBusca = "";
  final CampoBusca = TextEditingController();

  Future<Map> _buscarClientes() async {
    var url = "http://192.168.15.9/CadApi/Clientes/getClientes";
    Map dados = {
      "idusuario": '1',
      "pagina": _NrPagina.toString(),
      "PorPagina": _PorPagina.toString(),
      "nome": _DsBusca
    };

    _Clientes = await _SolicitaWeb(url, dados);
    _DadosCli = _Clientes["dados"];
  }

  Future<Map> _buscarFiltroClientes() async {
    var ds = CampoBusca.text;
    setState(() {
      if (ds != "") {
        _DsBusca = ds;
      }
      _buscarClientes();
    });
  }

  Future<Map> _SolicitaWeb(String Url, Map dados) async {
    http.Response busca = await http.post(Url, body: dados);
    return json.decode(busca.body);
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
                          controller: CampoBusca,
                        )),
                        RaisedButton(
                          child: Icon(Icons.search),
                          onPressed: () {
                            _buscarFiltroClientes();
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FutureBuilder(
                            future: _buscarClientes(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return Center(
                                    child: Text(
                                      "Carregando Dados",
                                      style: TextStyle(
                                          color: Colors.amber, fontSize: 25.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                default:
                                  return Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.all(5),
                                          itemCount: _DadosCli.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(_Clientes["dados"]
                                                  [index]["nm_cliente"]),
                                              subtitle: Text("CPF: " +
                                                  _Clientes["dados"][index]
                                                      ["cgc"]),
                                              onTap: () {
                                                DialogBusca(
                                                    context,
                                                    _Clientes["dados"][index]
                                                        ["idcliente"]);
                                              },
                                              onLongPress: () {},
                                              //trailing: Icon(Icons.launch),
                                            );
                                          }));
                              }
                            })
                      ],
                    )
                  ],
                ))));
  }

  void DialogBusca(BuildContext context, String cgc) {
    Dialog dialogo = Dialog(
      child: Container(
        width: 390,
        height: 350,
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.grey[100]),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Detalhes Cliente",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Fechar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          )),
                          color: Colors.red,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
    showDialog(context: context, builder: (BuildContext context) => dialogo);
  }
}

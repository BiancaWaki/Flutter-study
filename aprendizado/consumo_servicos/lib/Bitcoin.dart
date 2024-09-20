import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bitcoin extends StatefulWidget {
  const Bitcoin({super.key});

  @override
  State<Bitcoin> createState() => _BitcoinState();
}

class _BitcoinState extends State<Bitcoin> {

  String _resultado = "Resultado";
  void _precoBitcoin() async{
    String url = "https://blockchain.info/ticker";
    Uri uri = Uri.parse(url);
    http.Response response;
    response = await http.get(uri);

    Map<String, dynamic> retorno = json.decode(response.body);

    String valor = retorno["BRL"]["buy"].toString();

    setState(() {
      _resultado = 'R\$ '+ valor;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(

        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("images/bitcoin.png",
              width: 350,
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Text(_resultado,
                  style: TextStyle(
                    fontSize: 32
                  ),
                ),
            ),
            ElevatedButton(
                onPressed: _precoBitcoin,
                child: Text("Atualizar",
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange
                )
            ),
          ],
        ),
      ),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController _controller = TextEditingController();
  String _resultado = "Resultado";

  void _recuperarCep() async{
    String cep = _controller.text;
    String url = "https://viacep.com.br/ws/${cep}/json/";
    Uri uri = Uri.parse(url);

    http.Response response;
    response = await http.get(uri);

    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String regiao = retorno["regiao"];
    String estado = retorno["estado"];

    setState(() {
      _resultado = "Logradouro: ${logradouro} \n" +
          "Regiao: ${regiao} \n" +
          "Estado: ${estado}";
    });
    //print("Resposta: " + response.statusCode.toString());
    //print("Reaposta: " + response.body);

    /*print(
      "Logradouro: ${logradouro} \n" +
      "Regiao: ${regiao} \n" +
      "Estado: ${estado}"
    );*/


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumo de servico web"),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            Text(_resultado),
            TextField(
                keyboardType: TextInputType.number,
                controller: _controller, // Controlador para o TextField
                decoration: InputDecoration(
                labelText: 'Digite algo',
                  // border: OutlineInputBorder(),
                ),
            ),
            ElevatedButton(
                onPressed: _recuperarCep,
                child: Text("Clique aqui")
            ),
          ],

        ),
      ),
    );
  }
}

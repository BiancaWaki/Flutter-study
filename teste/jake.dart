import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeStateful(),
  ));
}

class HomeStateful extends StatefulWidget {
  const HomeStateful({super.key});

  @override
  State<HomeStateful> createState() => _HomeStatefulState();
}

class _HomeStatefulState extends State<HomeStateful> {
  var _frases = [
    '"Eu quero casar com a minha cama."',
    '"123456789"',
    '"qwertyuiopqwertyuio"',
    '"äsdfghjasdfghASDFGHasdfgh"'
  ];

  var _fraseGerada = "Frases Jake";

  var imagem = "images/jake.jpg";

  void _gerarFrase() {
    var numeroSorteado = Random().nextInt(_frases.length);
    setState(() {
      _fraseGerada = _frases[numeroSorteado];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Hora de Aventura",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body:
      Container(
        color: Colors.pink,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30),
            color: Colors.amber,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  // IMAGEM ---------------------------------
                  padding: EdgeInsets.all(15),
                  child: Image.asset(imagem),
                ),
                Container(
                  // FRASE ---------------------------------
                  child: Text(
                    _fraseGerada,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                Container(
                  // BOTAO ---------------------------------
                  padding: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: _gerarFrase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      "Inicio",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )

    );
  }
}

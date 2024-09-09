import 'dart:math';

import 'package:flutter/material.dart';

class Jogo extends StatefulWidget {
  const Jogo({super.key});

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {

  var pedra = "images/pedra.png";
  var papel = "images/papel.png";
  var tesoura = "images/tesoura.png";
  var padrao  = "images/padrao.png";
  var tamanhoImagem = 90.0;
  var tamanhoTexto = 20.0;

  var _imagemApp = AssetImage("images/padrao.png");
  var _mensagem = "";


  opcaoSelecionada(String escolhaUsuario){
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(opcoes.length);
    var escolhaApp = opcoes[numero];



    switch(escolhaApp){
      case "pedra":
        setState(() {this._imagemApp = AssetImage(pedra);});
        break;

      case "papel":
        setState(() {this._imagemApp = AssetImage(papel);});
        break;

      case "tesoura":
        setState(() {this._imagemApp = AssetImage(tesoura);});
        break;

    }

    if (
        escolhaUsuario == "pedra" && escolhaApp == "tesoura" ||
        escolhaUsuario == "papel" && escolhaApp == "pedra" ||
        escolhaUsuario == "tesoura" && escolhaApp == "papel"
    )
    {
      setState(() {
        this._mensagem = "ganhou";
      });

    }
    else{
      if(
          escolhaUsuario == "pedra" && escolhaApp == "papel" ||
          escolhaUsuario == "papel" && escolhaApp == "tesoura" ||
          escolhaUsuario == "tesoura" && escolhaApp == "pedra"
      )
      {
        setState(() {
          this._mensagem = "perdeu";
        });
      }
      else{
        setState(() {
          this._mensagem = "empate";
        });
      }
    }


  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("JokenPo",
        style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body:
      Center(
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(top:20, bottom:20),
                child: Text("Computer:",
                  style: TextStyle(
                      fontSize: tamanhoTexto
                  ),
                ),
            ),
            GestureDetector(
              onTap: (){},
              child:
              Image(image: _imagemApp)
            ),
            Padding(
              padding: EdgeInsets.only(top:20, bottom:20),
              child: Text(_mensagem,
                style: TextStyle(
                    fontSize: tamanhoTexto
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => opcaoSelecionada("pedra"),
                  child: Image.asset(pedra,
                    width: tamanhoImagem,
                  ),
                ),
                GestureDetector(
                  onTap: () => opcaoSelecionada("papel"),
                  child: Image.asset(papel,
                    width: tamanhoImagem,
                  ),
                ),
                GestureDetector(
                  onTap: () => opcaoSelecionada("tesoura"),
                  child: Image.asset(tesoura,
                    width: tamanhoImagem,
                  ),
                ),
              ],
            )
          ],
        ),
      )
      );
  }
}


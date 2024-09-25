import 'package:flutter/material.dart';
import 'package:youtube/CustomSearchDelegate.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricao.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _indiceAtual = 0;
  String _resultado = "";



  @override
  Widget build(BuildContext context) {

    String resultado = "";
    List<Widget> telas = [
      Inicio(_resultado),
      EmAlta(),
      Inscricao(),
      Biblioteca(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset("imagens/youtube.png",
          width: 98,
          height: 22,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
          //opacity: 1
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String? res = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate()
              );
              setState(() {
                _resultado = res.toString();
              });
            },
            icon: Icon(Icons.search),
          ),

          /*
          IconButton(
              onPressed: (){
              },
              icon: Icon(Icons.videocam),
          ),

          IconButton(
              onPressed: (){},
              icon: Icon(Icons.account_circle),
          ),
          */
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        fixedColor: Colors.red,
        onTap: (indice){
          setState(() {
            _indiceAtual= indice;
          });
        },
          type: BottomNavigationBarType.fixed,
          // ou diferente type: BottomNavigationBarType.shifting,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
              icon: Icon(Icons.account_circle),
              label: "Início",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
            icon: Icon(Icons.whatshot),
            label: "Em alta",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.greenAccent,

            icon: Icon(Icons.subscriptions),
            label: "Inscricoes",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.orange,

            icon: Icon(Icons.folder),
            label: "Biblioteca",
          ),

        ]
      ),
    );
  }
}

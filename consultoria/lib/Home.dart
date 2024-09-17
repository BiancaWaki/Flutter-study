import 'package:consultoria/TelaCliente.dart';
import 'package:consultoria/TelaContato.dart';
import 'package:consultoria/TelaEmpresa.dart';
import 'package:consultoria/TelaServico.dart';
import 'package:flutter/material.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _abrirEmpresa (){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TelaEmpresa()));
  }

  void _abrirCliente (){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaCliente()));
  }

  void _abrirServico (){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaServico()));
  }

  void _abrirContato (){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TelaContato()));
  }

  var padding_images = 15.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Consultoria"),
        backgroundColor: Colors.green,
      ),
      body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Image.asset("images/logo.png")
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding_images),
                    child: GestureDetector(
                      child: Image.asset("images/menu_empresa.png"),
                      onTap: _abrirEmpresa,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding_images),
                    child: GestureDetector(
                      child: Image.asset("images/menu_servico.png"),
                      onTap: _abrirServico,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(padding_images),
                    child: GestureDetector(
                      child: Image.asset("images/menu_cliente.png"),
                      onTap: _abrirCliente,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding_images),
                    child: GestureDetector(
                      child: Image.asset("images/menu_contato.png"),
                      onTap: _abrirContato,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}


import 'package:flutter/material.dart';

class Conversor extends StatefulWidget {
  const Conversor({super.key});

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
   TextEditingController _controllerAlcool = TextEditingController();
   TextEditingController _controllerGasolina = TextEditingController();
   var _resultado = "";

   void _limparCampos(){
     _controllerGasolina.text = "";
     _controllerAlcool.text = "";

   }

   void _calcular(){
     double? precoAlcool = double.tryParse(_controllerAlcool.text);
     double? precoGasolina = double.tryParse(_controllerGasolina.text);

     if(precoGasolina == null || precoAlcool == null || precoGasolina < 0 || precoAlcool < 0){
        setState(() {
          _resultado = "Inválido: número tem que ser maior que zero e com ponto";
        });
     }
     else{
       if(precoAlcool/precoGasolina >= 0.7){
         setState(() {
           _resultado = "Abastecer com gasolina";
         });
       }
       else{
         setState(() {
           _resultado = "Abastecer com Alcool";
         });
       }
       //_limparCampos();
     }
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Álcool ou Gasolina",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(0),
        child:
           SingleChildScrollView(
             padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 150, bottom: 20),
                      child: Image(image: AssetImage("images/logo.png")),
                  ),
                  Text("Saiba qual a melhor opcão para abastecimento do seu carro",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  TextField(
                    controller: _controllerAlcool,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 22
                    ),
                    decoration:
                    InputDecoration(
                      labelText:"Preco Alcool, ex: 1.59",
                    ),
                  ),
                  TextField(
                    controller: _controllerGasolina,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontSize: 22
                    ),
                    decoration:
                    InputDecoration(
                      labelText:"Preco Gasolina, ex: 1.59",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                        onPressed: _calcular,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            textStyle: TextStyle(
                                color: Colors.white
                            )
                        ),
                        child:
                          Text("Calcular",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(_resultado,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ],
              ),
            )
          ),
    );
  }
}

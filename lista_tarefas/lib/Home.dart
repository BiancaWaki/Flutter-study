import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List _listaTarefas = [];
  Map<String, dynamic> _ultimaTarefaRemovida = Map();
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async{
    final diretorio = await getApplicationDocumentsDirectory();
    var arquivo =  File("${diretorio.path}/dados.json");
    return arquivo;
  }

  _salvarTarefa() {
    String textoDigitado = _controllerTarefa.text;

    Map<String, dynamic> tarefa = Map();
    tarefa["titulo"] = textoDigitado;
    tarefa["realizada"] = false;

    setState(() {
      _listaTarefas.add(tarefa);
    });
    _salvarArquivo();
    _controllerTarefa.text = "";
  }

  _salvarArquivo() async {
    var arquivo = await _getFile();

    String dados = json.encode(_listaTarefas);
    arquivo.writeAsString(dados);
  }

  _lerArquivo() async{

    try{
      final arquivo = await _getFile();
      return arquivo.readAsString();

    }catch(e){
      return null;
    }

  }

  @override
  void initState() {
    super.initState();

    _lerArquivo().then( (dados){
      setState(() {
        _listaTarefas = json.decode(dados);
      });
    });
  }

  Widget criarItemLista(context, index){

    final item = _listaTarefas[index]["titulo"];
    return Dismissible(
        key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction){

          _ultimaTarefaRemovida = _listaTarefas[index];
          _listaTarefas.removeAt(index);
          _salvarArquivo();

          final snackBar = SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
              content: Text("Tarefa removida!"),
              action: SnackBarAction(
                  label: "Desfazer",
                  textColor: Colors.white,
                  onPressed: (){
                    setState(() {
                      //Insere a ultima tarefa removida na mesma posicao que estava
                      _listaTarefas.insert(index, _ultimaTarefaRemovida);
                    });
                    _salvarArquivo();
                  }
              ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.all(16),

          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                    Icons.delete,
                    color: Colors.white,
                ),
              ],
          ),
        ),
        child: CheckboxListTile(
            title: Text(_listaTarefas[index]["titulo"]),
            value: _listaTarefas[index]["realizada"],
            onChanged: (valorAlterado){
              setState(() {
                _listaTarefas[index]["realizada"] = valorAlterado;
              });
              _salvarArquivo();
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    //_salvarArquivo();

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de tarefas",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          onPressed: (){
            showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    title: Text("Adicionar tarefa"),
                    content: TextField(
                      controller: _controllerTarefa,
                      decoration: InputDecoration(
                        labelText: "Nova tarefa",
                      ),
                      onChanged: (_novaTarefa){

                      },
                    ),
                    actions: [

                      TextButton(
                          onPressed: (){
                            _salvarTarefa();
                            Navigator.pop(context);
                          },
                          child: Text("Salvar")
                      ),

                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancelar"),
                      ),
                    ],
                  );
                },
            );
          }
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _listaTarefas.length,
              itemBuilder: (context, index){
                return criarItemLista(context, index);
              },
            ),
          ),
        ],
      )
    );
  }
}

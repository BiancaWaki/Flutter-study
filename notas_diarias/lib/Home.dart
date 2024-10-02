import 'package:flutter/material.dart';
import 'package:notas_diarias/helper/AnotacaoHelper.dart';
import 'package:notas_diarias/model/anotacao.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _db = AnotacaoHelper();
  List<Anotacao> _anotacoes = [];
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _anotacaoController = TextEditingController();

  _exibirTelaCadastro() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Adicionar Anotação'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _tituloController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                ),
              ),
              TextField(
                controller: _anotacaoController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Anotação',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Salvar'),
              onPressed: () {
                _salvarAnotacao();
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _salvarAnotacao() async {
    String titulo = _tituloController.text;
    String descricao = _anotacaoController.text;
    DateTime data = DateTime.now();
    Anotacao anotacao = Anotacao(
      titulo: titulo,
      descricao: descricao,
      data: data.toString(),
    );
    await _db.salvarAnotacao(anotacao);
    _tituloController.clear();
    _anotacaoController.clear();
    _recuperarAnotacoes();
  }

  _recuperarAnotacoes() async {
    List anotacoesRecuperadas = await _db.recuperarAnotacoes();
    List<Anotacao> listaTemporaria = [];

    for (Map<String, dynamic> item in anotacoesRecuperadas) {
      Anotacao anotacao = Anotacao.fromMap(item);
      listaTemporaria.add(anotacao);
    }
    setState(() {
      _anotacoes = listaTemporaria;
    });
    listaTemporaria = [];
  }

  _formatarData(String? data) {}

  @override
  void initState() {
    super.initState();
    _recuperarAnotacoes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Anotações'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _anotacoes.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_anotacoes[index].titulo ?? ''),
                    subtitle: Text(
                        "${_formatarData(_anotacoes[index].data)} - ${_anotacoes[index].descricao}"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
        onPressed: () {
          _exibirTelaCadastro();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

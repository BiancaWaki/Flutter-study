import 'package:flutter/material.dart';
import 'package:notas_diarias/helper/AnotacaoHelper.dart';
import 'package:notas_diarias/model/anotacao.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

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

  _exibirTelaCadastro({Anotacao? anotacao}) {
    String textoSalvarAtualizar = '';
    if (anotacao == null) {
      _tituloController.text = '';
      _anotacaoController.text = '';
      textoSalvarAtualizar = 'Salvar';
    } else {
      _tituloController.text = anotacao.titulo ?? '';
      _anotacaoController.text = anotacao.descricao ?? '';
      textoSalvarAtualizar = 'Atualizar';
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(textoSalvarAtualizar),
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
              child: Text(textoSalvarAtualizar),
              onPressed: () {
                _salvarAtualizarAnotacao(anotacaoSelecionada: anotacao);
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

  _salvarAtualizarAnotacao({Anotacao? anotacaoSelecionada}) async {
    String titulo = _tituloController.text;
    String descricao = _anotacaoController.text;
    DateTime data = DateTime.now();
    if (anotacaoSelecionada == null) {
      Anotacao anotacao = Anotacao(
        titulo: titulo,
        descricao: descricao,
        data: data.toString(),
      );
      await _db.salvarAnotacao(anotacao);
    } else {
      anotacaoSelecionada.titulo = titulo;
      anotacaoSelecionada.descricao = descricao;
      anotacaoSelecionada.data = data.toString();
      await _db.atualizarAnotacao(anotacaoSelecionada);
    }

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

  _formatarData(String? data) {
    initializeDateFormatting("pt_BR");
    //var formatador = DateFormat("dd/MM/yy");
    var formatador = DateFormat.yMMMMd('pt_BR');
    DateTime dataConvertida = DateTime.parse(data!);
    String dataFormatada = formatador.format(dataConvertida);
    return dataFormatada;
  }

  _removerAnotacao(int id) async {
    await _db.removerAnotacao(id);
    _recuperarAnotacoes();
  }

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
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _exibirTelaCadastro(anotacao: _anotacoes[index]);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.edit,
                              color: Colors.green,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _removerAnotacao(_anotacoes[index].id!);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Icon(
                              Icons.remove_circle,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
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

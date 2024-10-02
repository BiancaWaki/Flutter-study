import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, 'banco.db');

    var bd = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        String sql =
            "CREATE TABLE usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR, idade INTEGER)";

        db.execute(sql);
      },
    );

    return bd;
  }

  _salvar() async {
    Database bd = await _recuperarBancoDados();
    Map<String, dynamic> dadosUsuario = {'nome': 'João', 'idade': 20};
    int id = await bd.insert('usuarios', dadosUsuario);
    print('Id do usuário: $id');
  }

  _listarUsuarios() async {
    Database bd = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios";
    List usuarios = await bd.rawQuery(sql);
    for (Map<String, dynamic> usuario in usuarios) {
      print('Id do usuário: ${usuario['id']}');
      print('Nome do usuário: ${usuario['nome']}');
      print('Idade do usuário: ${usuario['idade']}');
    }
  }

  _listarUsuarioPeloId(int id) async {
    Database bd = await _recuperarBancoDados();

    List usuarios = await bd.query(
      'usuarios',
      columns: ['id', 'nome', 'idade'],
      where: 'id = ?',
      whereArgs: [id],
    );

    return usuarios;
  }

  _excluirUsuario(int id) async {
    Database bd = await _recuperarBancoDados();
    int retorno = await bd.delete(
      'usuarios',
      where: 'id = ?',
      whereArgs: [id],
    );

    print('Retorno: $retorno');
  }

  _atualizarUsuario(int id, String nome, int idade) async {
    Database bd = await _recuperarBancoDados();

    Map<String, dynamic> dadosUsuario = {'nome': nome, 'idade': idade};

    int retorno = await bd.update(
      'usuarios',
      dadosUsuario,
      where: 'id = ?',
      whereArgs: [id],
    );

    print('Retorno: $retorno');
  }

  @override
  Widget build(BuildContext context) {
    //_recuperarBancoDados();
    //_listarUsuarios();
    //_listarUsuarioPeloId(1);
    //_excluirUsuario(1);
    //_atualizarUsuario(1, 'Bianca', 21);
    return const Placeholder();
  }
}

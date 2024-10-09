import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'post.dart'; // Certifique-se de que a classe Post esteja importada corretamente

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async {
    final response = await http.get(Uri.parse("$_urlBase/posts"));
    var dadosJson = json.decode(response.body);

    List<Post> postagens = [];

    for (var post in dadosJson) {
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
  }

  _post() async{

    Post post = new Post(120 , 0, "Titulo", "Corpo da postam");

    var corpo = json.encode(
      post.toJson()
    );

    http.Response response = await http.post(
        Uri.parse(_urlBase + "/posts"),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: corpo
    );
    
    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");

  }

  //Put precisa enviar tudo------------
  _put() async{
    var corpo = json.encode(
        {
          "userId": 120,
          "id": null,
          "title": null,
          "body": "Corpo da postam"
        }
    );

    http.Response response = await http.put(
        Uri.parse(_urlBase + "/posts/2"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: corpo
    );

    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }

  //Patch nao precisa enviar tudo  ------
  _patch() async {
    var corpo = json.encode(
        {
          "body": "Corpo da mensagem alterada"
        }
    );

    http.Response response = await http.patch(
        Uri.parse(_urlBase + "/posts/2"),
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: corpo
    );

    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }

  _delete() async{
    http.Response response = await http.delete(
      (_urlBase + "posts/2") as Uri
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumo de serviço avançado"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                    onPressed: _post,
                    child: Text("Salvar"),
                ),
                ElevatedButton(
                  onPressed: _put,
                  child: Text("Atualizar"),
                ),
                ElevatedButton(
                  onPressed: _patch,
                  child: Text("Remover"),
                ),
              ],
            ),
            Expanded(
                child: FutureBuilder<List<Post>>(
                  future: _recuperarPostagens(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());

                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          return const Center(child: Text("Erro ao carregar"));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text("Nenhuma postagem encontrada"));
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {


                              final post = snapshot.data![index];
                              return ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.id.toString()),
                              );
                            },
                          );
                        }
                    }
                  },
                ),
            ),
          ],
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.clear),
      ),
      /*IconButton(
        onPressed: (){},
        icon: Icon(Icons.done),
      ),
      */
    ];
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, "");
      },
      icon: Icon(Icons.arrow_back),
    );

    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
    throw UnimplementedError();
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();

    //SUGESTOES NO MEIO DA PESQUISA
    /*
    List<String> lista = [];
    if(query.isNotEmpty){
      lista = [
        "android", "flutter", "IOS", "jogos", "arquivos"
      ].where((texto) => texto.toLowerCase().startsWith(query.toLowerCase())).toList();

      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index){
            return ListTile(
              onTap: (){
                close(context, lista[index]);
              },
              title: Text(lista[index]),
            );
          }
      );
    }
    else
    {
      return Center(
        child: Text("Nenhum resultado para a pesquisa"),
      );
    }
    */
    throw UnimplementedError();
  }
}
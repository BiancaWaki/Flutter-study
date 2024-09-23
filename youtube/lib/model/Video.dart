class Video {
  String? id;
  String? titulo;
  String? descricao;
  String? imagem;
  String? canal;

  Video({this.id, this.titulo, this.descricao, this.imagem, this.canal});

  //Nao é otimizado, guarda os videos em instancias diferentes
 /* static converterJson(Map<String,dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      imagem: json["snippet"]["thumbanails"]["high"]["url"],
      canal: json["snippet"]["channelId"],

    );
  }*/

  //otimizado pq a mesma instancia é utilizada para varios videos
  factory Video.fromJson(Map<String, dynamic> json){
   return Video(
     id: json["id"]["videoId"],
     titulo: json["snippet"]["title"],
     descricao: json["snippet"]["description"],
     imagem: json["snippet"]["thumbnails"]["high"]["url"],
     canal: json["snippet"]["channelTitle"],
   );
  }

}
import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Inicio extends StatefulWidget {
 final String pesquisa;
 const Inicio(this.pesquisa, {super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  late Future<List<Video>> _futureVideos;
  final Map<String, YoutubePlayerController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _futureVideos = _listarVideos(widget.pesquisa);
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<List<Video>> _listarVideos(String pesquisa) {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _futureVideos,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<Video>? videos = snapshot.data;
                  Video video = videos![index];

                  // Inicializar o controlador apenas se ele não existir no mapa
                  if (!_controllers.containsKey(video.id)) {
                    _controllers[video.id.toString()] = YoutubePlayerController(
                      initialVideoId: YoutubePlayer.convertUrlToId(video.id.toString())!,
                      flags: const YoutubePlayerFlags(
                        autoPlay: true,
                        mute: false,
                      ),
                    );
                  }

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: YoutubePlayer(
                            controller: _controllers[video.id]!,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: Colors.amber,
                            progressColors: const ProgressBarColors(
                              playedColor: Colors.amber,
                              handleColor: Colors.amberAccent,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(video.imagem.toString()),
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(video.titulo.toString()),
                          subtitle: Text(video.canal.toString()),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  height: 2,
                  color: Colors.grey,
                ),
                itemCount: snapshot.data!.length,
              );
            } else {
              return const Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
        }
      },
    );
  }
}
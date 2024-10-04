import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Bichos extends StatefulWidget {
  const Bichos({super.key});

  @override
  State<Bichos> createState() => _BichosState();
}

class _BichosState extends State<Bichos> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache.instance;

  void _executar(String nomeAudio) {
    _audioPlayer.audioCache = AudioCache(prefix: 'assets/audios/');
    _audioPlayer.play(AssetSource(nomeAudio + ".mp3"));
  }

  @override
  void initState() {
    super.initState();
    audioCache.loadAll([
      'assets/audios/cao.mp3',
      'assets/audios/gato.mp3',
      'assets/audios/leao.mp3',
      'assets/audios/macaco.mp3',
      'assets/audios/ovelha.mp3',
      'assets/audios/vaca.mp3',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      children: [
        GestureDetector(
          onTap: () {
            _executar('cao');
          },
          child: Image.asset('assets/imagens/cao.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('gato');
          },
          child: Image.asset('assets/imagens/gato.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('leao');
          },
          child: Image.asset('assets/imagens/leao.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('macaco');
          },
          child: Image.asset('assets/imagens/macaco.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('ovelha');
          },
          child: Image.asset('assets/imagens/ovelha.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('vaca');
          },
          child: Image.asset('assets/imagens/vaca.png'),
        ),
      ],
    );
  }
}

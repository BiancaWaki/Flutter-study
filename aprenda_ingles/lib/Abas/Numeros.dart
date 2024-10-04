import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class Numeros extends StatefulWidget {
  const Numeros({super.key});

  @override
  State<Numeros> createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
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
      'assets/audios/1.mp3',
      'assets/audios/2.mp3',
      'assets/audios/3.mp3',
      'assets/audios/4.mp3',
      'assets/audios/5.mp3',
      'assets/audios/6.mp3',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        GestureDetector(
          onTap: () {
            _executar('1');
          },
          child: Image.asset('assets/imagens/1.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('2');
          },
          child: Image.asset('assets/imagens/2.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('3');
          },
          child: Image.asset('assets/imagens/3.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('4');
          },
          child: Image.asset('assets/imagens/4.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('5');
          },
          child: Image.asset('assets/imagens/5.png'),
        ),
        GestureDetector(
          onTap: () {
            _executar('6');
          },
          child: Image.asset('assets/imagens/6.png'),
        ),
      ],
    );
  }
}

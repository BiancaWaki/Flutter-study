import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audio_cache.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool primeiraExecucao = true;
  double volume = 0.5;

  void _executar() async {
    audioPlayer.setVolume(volume);
    if (primeiraExecucao) {
      audioPlayer.audioCache = AudioCache(prefix: 'assets/audios/');
      await audioPlayer.play(AssetSource('musica.mp3'));
      primeiraExecucao = false;
    } else {
      await audioPlayer.resume();
    }
  }

  _pausar() async {
    await audioPlayer.pause();
  }

  _parar() async {
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    _executar();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Slider(
            value: volume,
            min: 0,
            max: 1,
            divisions: 10,
            onChanged: (value) {
              setState(() {
                volume = value;
              });
              audioPlayer.setVolume(value);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: GestureDetector(
                  child: Image.asset('assets/imagens/executar.png'),
                  onTap: () {
                    _executar();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: GestureDetector(
                  child: Image.asset('assets/imagens/pausar.png'),
                  onTap: () {
                    _pausar();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: GestureDetector(
                  child: Image.asset('assets/imagens/parar.png'),
                  onTap: () {
                    _parar();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

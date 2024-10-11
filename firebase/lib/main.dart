import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase Core para inicialização
import 'Home.dart'; // Certifique-se de que está apontando para a classe Home corretamente

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante a inicialização correta
  await Firebase.initializeApp(); // Inicializa o Firebase uma vez
  runApp(
    const MaterialApp(
      home: Home(),
    ),
  );
}

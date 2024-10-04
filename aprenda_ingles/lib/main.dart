import 'package:aprenda_ingles/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Color(0xfff5e9b9),
      ),
    ),
  );
}

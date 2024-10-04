import 'package:aprenda_ingles/Abas/Bichos.dart';
import 'package:aprenda_ingles/Abas/Numeros.dart';
import 'package:aprenda_ingles/Abas/Vogais.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          'Aprenda Inglês',
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorWeight: 4,
          indicatorColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          tabs: const <Widget>[
            Tab(text: 'Bichos'),
            Tab(text: 'Números'),
            Tab(text: 'Vogais'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Bichos(),
          Numeros(),
          Vogais(),
        ],
      ),
    );
  }
}

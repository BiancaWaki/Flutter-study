import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  String email = "teste@gmail.com";
  String senha = "123456";

  //cria um usuário no firebase ----------------------------
  // auth
  //     .createUserWithEmailAndPassword(
  //   email: email,
  //   password: senha,
  // )
  //     .then((firebaseUser) {
  //   print("Usuário criado com sucesso: ${firebaseUser.user}");
  // }).catchError((e) {
  //   print("Erro ao criar usuário: ${e.toString()}");
  // });

  //desloga o usuário ----------------------------
  //auth.signOut();

  auth
      .signInWithEmailAndPassword(
    email: email,
    password: senha,
  )
      .then((firebaseUser) {
    print("Usuário logado com sucesso: ${firebaseUser.user?.email}");
  }).catchError((e) {
    print("Erro ao logar usuário: ${e.toString()}");
  });

  // verifica se o usuário está logado ----------------------
  // User? usuarioAtual = await auth.currentUser;
  // if (usuarioAtual != null) {
  //   print("Usuário logado: ${usuarioAtual.email}");
  // } else {
  //   print("Nenhum usuário logado");
  // }

  // FIREBASE SEM AUTENTICAÇÃO -----------------------------------
  //FirebaseFirestore db = FirebaseFirestore.instance;
  //db.collection('usuarios').doc('002').set({"Ana": "234", "idade": "40"});

  // DocumentReference ref = await db.collection('noticias').add({
  //   "titulo": "Ondas de calor chegam ao Brasil",
  //   "descricao": "texto de exeplo..."
  // });
  // print(ref.id);

  // db.collection('noticias').doc('qsQ7MwOAB7IyQBgJvzmn').set({
  //   "titulo": "Ondas de calor chegam ao Brasil alterado",
  //   "descricao": "texto de exeplo..."
  // });

  //db.collection('usuarios').doc('001').delete();

  // DocumentSnapshot snapshot = await db.collection('usuarios').doc('002').get();
  // print(snapshot.data().toString());

  //QuerySnapshot snapshot = await db.collection('usuarios').get();
  // for (var doc in snapshot.docs) {
  //   var dados = doc.data() as Map<String, dynamic>;
  //   print(dados['nome'].toString());
  // }

  // "ouvinte"
  // db.collection('usuarios').snapshots().listen(
  //   (snapshot) {
  //     for (var doc in snapshot.docs) {
  //       var dados = doc.data();
  //       print(dados['nome'].toString());
  //     }
  //   },
  // );

  // QuerySnapshot querySnapshot = await db
  //     .collection('usuarios')
  //     .where("idade", isGreaterThan: 15)
  //     .where("idade", isLessThan: 30)
  //     .orderBy("idade", descending: true)
  //     .orderBy("nome", descending: false)
  //     .limit(2)
  //     .get();

  // for (var doc in querySnapshot.docs) {
  //   var dados = doc.data() as Map<String, dynamic>;
  //   print(dados['nome'].toString());
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste'),
      ),
    );
  }
}

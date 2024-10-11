import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  XFile? _imagem;
  String _statusUpload = "Upload nao iniciado";
  String _urlImagemRecuperada = "";

  Future _recuperarImagem(bool daCamera) async {
    XFile? imagemSelecionada;
    if (daCamera) {
      ImagePicker imagePicker = ImagePicker();
      imagemSelecionada =
          await imagePicker.pickImage(source: ImageSource.camera);
    } else {
      ImagePicker imagePicker = ImagePicker();
      imagemSelecionada =
          await imagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      _imagem = imagemSelecionada;
    });
  }

  Future _uploadImagem() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz.child("fotos").child("foto1.jpg");
    UploadTask task = arquivo.putFile(File(_imagem!.path));

    task.snapshotEvents.listen(
      (TaskSnapshot taskSnapshot) {
        if (taskSnapshot.state == TaskState.running) {
          setState(() {
            _statusUpload = "Upload iniciado";
          });
        } else if (taskSnapshot.state == TaskState.success) {
          setState(
            () {
              _statusUpload = "Upload concluido";
            },
          );
        }
      },
    );

    task.then((TaskSnapshot taskSnapshot) {
      _recuperarURL(taskSnapshot);
    });
  }

  Future _recuperarURL(TaskSnapshot taskSnapshot) async {
    String url = await taskSnapshot.ref.getDownloadURL();
    print("URL: $url");
    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  // Future _uploadImagem() async {
  //   // Garante que o Flutter está corretamente inicializado
  //   WidgetsFlutterBinding.ensureInitialized();

  //   // Inicializa o Firebase
  //   await Firebase.initializeApp();
  //   if (_imagem != null) {
  //     try {
  //       FirebaseStorage storage = FirebaseStorage.instance;
  //       Reference pastaRaiz = storage.ref();
  //       Reference arquivo = pastaRaiz.child("fotos").child("foto1.jpg");
  //       UploadTask uploadTask = arquivo.putFile(File(_imagem!.path));

  //       // Aguarda até que o upload seja concluído
  //       TaskSnapshot snapshot = await uploadTask;
  //       String url = await snapshot.ref.getDownloadURL();
  //       print("Imagem enviada com sucesso: $url");
  //     } catch (e) {
  //       print("Erro ao enviar imagem: $e");
  //     }
  //   } else {
  //     print("Nenhuma imagem selecionada.");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecionar Imagem"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(_statusUpload),
            ElevatedButton(
              onPressed: () {
                _recuperarImagem(true);
              },
              child: const Text("Camera"),
            ),
            ElevatedButton(
              onPressed: () {
                _recuperarImagem(false);
              },
              child: const Text("Galeria"),
            ),
            _imagem == null ? Container() : Image.file(File(_imagem!.path)),
            _imagem == null
                ? Container()
                : ElevatedButton(
                    onPressed: () {
                      _uploadImagem();
                    },
                    child: const Text("Upload Imagem"),
                  ),
            _urlImagemRecuperada == ""
                ? Container()
                : Image.network(_urlImagemRecuperada),
          ],
        ),
      ),
    );
  }
}

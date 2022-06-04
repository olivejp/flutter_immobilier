import 'package:flutter/material.dart';
import 'package:flutter_immobilier/service/annonce_immobiliere_service.dart';
import 'package:flutter_immobilier/service/service_toast.dart';
import 'package:get_it/get_it.dart';

void injectDependencies() {
  GetIt.I.registerSingletonAsync(() => Future.value(ServiceToast()));
  GetIt.I
      .registerSingletonAsync(() => Future.value(AnnonceImmobiliereService()));
}

void main() {
  injectDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final AnnonceImmobiliereService service = GetIt.I.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: const Center(child: Text('Test')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          service.search('colline').then((value) {
            print(value);
          });
        },
      ),
    );
  }
}

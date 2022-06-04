import 'package:flutter/material.dart';
import 'package:flutter_immobilier/service/annonce_immobiliere_service.dart';
import 'package:get_it/get_it.dart';

import 'environment_config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetIt.I.registerFactory(() =>
        AnnonceImmobiliereService('annonces', EnvironmentConfig.serverUrl));
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

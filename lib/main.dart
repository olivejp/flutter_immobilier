import 'package:flutter/material.dart';
import 'package:flutter_immobilier/domain/bucket.dart';
import 'package:flutter_immobilier/search_notifier.dart';
import 'package:flutter_immobilier/service/annonce_immobiliere_service.dart';
import 'package:flutter_immobilier/service/service_toast.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'domain/annonce_immobiliere.dart';
import 'domain/facet.dart';

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
      title: 'Application Immobilière',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => SearchNotifier(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              title: const AppBarImmobilier(),
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Consumer<SearchNotifier>(
                          builder: (context, value, child) {
                        if (value.listFacet.isEmpty) {
                          return const Text('Aucun filtre');
                        } else {
                          return ListView.builder(
                            itemCount: value.listFacet.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final Facet facet = value.listFacet[index];
                              return CardFacet(facet: facet);
                            },
                          );
                        }
                      }),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Center(
                    child: Consumer<SearchNotifier>(
                        builder: (context, value, child) {
                      if (value.listAnnonce.isEmpty) {
                        return const Text('Aucune annonce');
                      } else {
                        return ListView.builder(
                          itemCount: value.listAnnonce.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Annonce annonce = value.listAnnonce[index];
                            return CardAnnonce(annonce: annonce);
                          },
                        );
                      }
                    }),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class AppBarImmobilier extends StatelessWidget {
  const AppBarImmobilier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchTextController = TextEditingController();
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(
            Icons.house_outlined,
            size: 30,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 40,
                bottom: 40,
              ),
              child: TextFormField(
                controller: searchTextController,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                    constraints: const BoxConstraints(
                      maxHeight: 35,
                      minHeight: 35,
                      maxWidth: 600,
                      minWidth: 400,
                    ),
                    filled: true,
                    hintText: 'Rechercher',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade300,
                    ),
                    fillColor: Colors.white,
                    suffixIcon: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          iconSize: 20,
                          onPressed: () {
                            context.read<SearchNotifier>().cleanList();
                            searchTextController.clear();
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        ),
                        IconButton(
                          iconSize: 20,
                          onPressed: () =>
                              context.read<SearchNotifier>().search(),
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                      ],
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    )),
                onFieldSubmitted: (value) {
                  context.read<SearchNotifier>().setQuery(value);
                  context.read<SearchNotifier>().search();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardFacet extends StatelessWidget {
  const CardFacet({
    Key? key,
    required this.facet,
  }) : super(key: key);

  final Facet facet;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(facet.name ?? ''),
          if ((facet.buckets?.length ?? 0) > 0)
            ListView.builder(
              shrinkWrap: true,
              itemCount: facet.buckets?.length,
              itemBuilder: (context, index) {
                final Bucket bucket = facet.buckets![index];
                return CardBucket(bucket: bucket);
              },
            )
        ],
      ),
    );
  }
}

class CardBucket extends StatelessWidget {
  const CardBucket({
    Key? key,
    required this.bucket,
  }) : super(key: key);

  final Bucket bucket;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text('${bucket.name} (${bucket.docCount})')],
      ),
    );
  }
}

class CardAnnonce extends StatelessWidget {
  const CardAnnonce({
    Key? key,
    required this.annonce,
  }) : super(key: key);

  final Annonce annonce;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${annonce.transaction} ${annonce.categorie} ${annonce.type} ${annonce.quartier} ${annonce.superficie ?? ''}'),
            Divider(),
            Text('Description : ${annonce.description ?? ''}'),
            Divider(),
            Text('Quartier : ${annonce.quartier ?? ''}'),
            Divider(),
            Text('Prix : ${annonce.prix}'),
            Divider(),
            Text('Agence : ${annonce.nomAgence}'),
          ],
        ),
      ),
    );
  }
}

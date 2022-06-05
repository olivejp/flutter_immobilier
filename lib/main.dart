import 'package:flutter/material.dart';
import 'package:flutter_immobilier/domain/bucket.dart';
import 'package:flutter_immobilier/search_notifier.dart';
import 'package:flutter_immobilier/service/annonce_immobiliere_service.dart';
import 'package:flutter_immobilier/service/service_toast.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
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
          textTheme: TextTheme(
            bodyText1: GoogleFonts.nunito().copyWith(fontSize: 18),
            bodyText2: GoogleFonts.nunito().copyWith(fontSize: 16),
            headline6: GoogleFonts.nunito()
                .copyWith(color: Colors.orange, fontSize: 18),
            subtitle1: GoogleFonts.nunito()
                .copyWith(color: Colors.grey.shade600, fontSize: 17),
            subtitle2: GoogleFonts.nunito().copyWith(fontSize: 14),
            caption: GoogleFonts.nunito()
                .copyWith(color: Colors.grey.shade300, fontSize: 14),
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return ChangeNotifierProvider(
        create: (BuildContext context) => SearchNotifier(),
        builder: (context, child) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              elevation: 0,
              title: const AppBarImmobilier(),
            ),
            bottomNavigationBar: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                    width: 1,
                  ),
                ),
              ),
              child: Consumer<SearchNotifier>(builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          'Résultats : ${value.pageAnnonce?.totalElements ?? 0}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                          'Nombre de page : ${value.pageAnnonce?.totalPages ?? 0}'),
                    ),
                    ...List.generate(
                      value.pageAnnonce?.totalPages ?? 0,
                      (index) => TextButton(
                        child: Text('$index'),
                        onPressed: () {
                          context.read<SearchNotifier>().setActualPage(index);
                          context
                              .read<SearchNotifier>()
                              .search(scrollController: scrollController);
                        },
                      ),
                    )
                  ],
                );
              }),
            ),
            body: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.grey.shade300),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            TopBannerFilter(title: 'Transaction'),
                            TopBannerFilter(title: 'Bien'),
                            TopBannerFilter(title: 'Type'),
                            TopBannerFilter(title: 'Surface'),
                            TopBannerFilter(title: 'Localité'),
                            TopBannerFilter(title: 'Budget'),
                          ],
                        ),
                        Consumer<SearchNotifier>(
                            builder: (context, notifier, child) {
                          return ToggleButtons(
                            selectedColor: Colors.amber,
                            fillColor: Colors.grey.shade50,
                            onPressed: (index) => notifier.selectFilter(index),
                            renderBorder: false,
                            isSelected: notifier.transactionFiltersEnable,
                            children: notifier.transactionFilters
                                .map(
                                  (e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.value!),
                                  ),
                                )
                                .toList(),
                          );
                        })
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Consumer<SearchNotifier>(
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
                      ),
                      Flexible(
                        flex: 3,
                        child: Center(
                          child: Consumer<SearchNotifier>(
                              builder: (context, value, child) {
                            List<Annonce> listAnnonce =
                                value.pageAnnonce?.content ?? [];
                            if (listAnnonce.isEmpty) {
                              return const Text('Aucune annonce');
                            } else {
                              return ListView.builder(
                                itemCount: listAnnonce.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return CardAnnonce(
                                      annonce: listAnnonce[index]);
                                },
                              );
                            }
                          }),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class TopBannerFilter extends StatelessWidget {
  const TopBannerFilter({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        bottom: 4,
        right: 10,
        top: 4,
      ),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title),
          PopupMenuButton(
            offset: const Offset(0, 20),
            iconSize: 20,
            position: PopupMenuPosition.under,
            icon: const Icon(
              Icons.arrow_drop_down_sharp,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                enabled: false,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 150,
                    minHeight: 200,
                  ),
                  child: Wrap(
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text('First option'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Second option'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AppBarImmobilier extends StatelessWidget {
  const AppBarImmobilier({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchTextController = TextEditingController();
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1600),
      child: Row(
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
                onChanged: (value) =>
                    context.read<SearchNotifier>().setQuery(value),
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
    var formatter = NumberFormat('#,###', "fr_FR");
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${annonce.transaction ?? ''} ${annonce.categorie ?? ''} ${annonce.type ?? ''} ${annonce.quartier ?? ''} - ${annonce.superficie != null ? '${annonce.superficie} m²' : ''}',
              style: Theme.of(context).textTheme.headline6,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Image.network(
                      'https://www.bienmeloger.nc/media/043/thumbs/280718b0-884b-4b72-adc9-fcd2af4778db-202204301043.jpeg'),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Description : ${annonce.description ?? ''}',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      CardAnnonceDetailLine(
                        title: 'Quartier',
                        detail: annonce.quartier ?? '',
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                      ),
                      CardAnnonceDetailLine(
                        title: 'Superficie',
                        detail: (annonce.superficie != null)
                            ? '${annonce.superficie}'
                            : 'Inconnu',
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                      ),
                      CardAnnonceDetailLine(
                        title: 'Agence',
                        detail: '${annonce.nomAgence}',
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey.shade100,
                      ),
                      CardAnnonceDetailLine(
                        title: 'Prix',
                        detail: (annonce.prix != null && annonce.prix! > 0)
                            ? formatter.format(annonce.prix)
                            : 'Inconnu',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardAnnonceDetailLine extends StatelessWidget {
  const CardAnnonceDetailLine({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              detail,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          )
        ],
      ),
    );
  }
}

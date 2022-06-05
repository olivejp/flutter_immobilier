import 'package:flutter/material.dart';
import 'package:flutter_immobilier/domain/search_filter.dart';
import 'package:flutter_immobilier/domain/search_request_body.dart';
import 'package:flutter_immobilier/service/annonce_immobiliere_service.dart';
import 'package:get_it/get_it.dart';

import 'domain/annonce_immobiliere.dart';
import 'domain/facet.dart';

class SearchNotifier extends ChangeNotifier {
  final AnnonceImmobiliereService service = GetIt.I.get();

  List<Annonce> listAnnonce = [];
  List<Facet> listFacet = [];
  String? query;
  SearchBodyRequest searchBodyRequest = SearchBodyRequest();

  void setQuery(String query) {
    this.query = query;
  }

  void search() {
    SearchFilter filter = SearchFilter(field: 'type.label', type: 'match', value: 'Vente');
    searchBodyRequest.filters = [filter];

    service.search(query ?? '', searchBodyRequest).then((listAnnonce) {
      this.listAnnonce = listAnnonce;
      notifyListeners();
    });

    service.searchFacet(query ?? '').then((listFacets) {
      listFacet = listFacets;
      notifyListeners();
    });
  }

  void cleanList() {
    query = '';
    listAnnonce.clear();
    listFacet.clear();
    notifyListeners();
  }
}

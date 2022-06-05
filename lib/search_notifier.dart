import 'package:flutter/material.dart';
import 'package:flutter_immobilier/domain/search_facet_body.dart';
import 'package:flutter_immobilier/domain/search_filter.dart';
import 'package:flutter_immobilier/service/annonce_immobiliere_service.dart';
import 'package:get_it/get_it.dart';

import 'domain/annonce_immobiliere.dart';
import 'domain/facet.dart';
import 'domain/page.dart' as customPage;

class SearchNotifier extends ChangeNotifier {
  final AnnonceImmobiliereService service = GetIt.I.get();

  List<Facet> listFacet = [];
  String? query;
  int actualPageIndex = 0;
  int actualPageSize = 20;
  customPage.Page<Annonce>? pageAnnonce;
  SearchFacetBody searchFacetBody = SearchFacetBody();

  ///
  /// Set the query
  ///
  void setQuery(String query) {
    this.query = query;
  }

  ///
  /// Set the actual page
  ///
  void setActualPage(int page) {
    actualPageIndex = page;
  }

  ///
  /// Set the actual page size
  ///
  void setActualSize(int size) {
    actualPageSize = size;
  }

  ///
  /// Search method
  ///
  void search({ScrollController? scrollController}) {
    // TODO sortir ce filtre par défaut qui ne servait que d'exemple
    SearchFilter filter = SearchFilter(
        field: 'realty.localization.label',
        type: TypeSearchFilter.MATCH,
        value: 'Magenta');
    searchFacetBody.filters = [filter];

    // Call the search API
    service.search(query ?? '', searchFacetBody, requestParams: {
      "page": '$actualPageIndex',
      "size": '$actualPageSize'
    }).then((pageAnnonceReturned) {

      // If a scrollController is set, then animate to go to the top of the page.
      scrollController?.animateTo(
        0,
        duration: const Duration(seconds: 1),
        curve: Curves.ease,
      );

      // Store the page returned
      pageAnnonce = pageAnnonceReturned;

      notifyListeners();
    });

    // Lance la recherche des facets
    service.searchFacet(query ?? '', searchFacetBody).then((listFacets) {
      listFacet = listFacets;
      notifyListeners();
    });
  }

  void cleanList() {
    query = '';
    pageAnnonce?.content?.clear();
    listFacet.clear();
    notifyListeners();
  }
}

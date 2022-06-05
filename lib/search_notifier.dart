import 'package:flutter/material.dart';
import 'package:flutter_immobilier/domain/search_facet_body.dart';
import 'package:flutter_immobilier/domain/search_filter.dart';
import 'package:flutter_immobilier/service/annonce_immobiliere_service.dart';
import 'package:get_it/get_it.dart';

import 'domain/annonce_immobiliere.dart';
import 'domain/facet.dart';
import 'domain/page.dart' as customPage;

class SearchNotifier extends ChangeNotifier {
  SearchNotifier() {
    transactionFilters = [
      SearchFilter(
          field: 'type.label.keyword',
          type: TypeSearchFilter.MATCH,
          value: 'Vente'),
      SearchFilter(
          field: 'type.label.keyword',
          type: TypeSearchFilter.MATCH,
          value: 'Location'),
      SearchFilter(
          field: 'type.label.keyword',
          type: TypeSearchFilter.MATCH,
          value: 'Saisonnier'),
      SearchFilter(
          field: 'type.label.keyword',
          type: TypeSearchFilter.MATCH,
          value: 'Promotion'),
      SearchFilter(
          field: 'type.label.keyword',
          type: TypeSearchFilter.MATCH,
          value: 'Colocation'),
    ];
    transactionFiltersEnable = transactionFilters.map((e) => false).toList();

    // Default on the first filter.
    searchFacetBody.filters.add(transactionFilters[0]);
    transactionFiltersEnable[0] = true;
  }

  final AnnonceImmobiliereService service = GetIt.I.get();
  late List<SearchFilter> transactionFilters;
  late List<bool> transactionFiltersEnable;

  SearchFacetBody searchFacetBody = SearchFacetBody();
  List<Facet> listFacet = [];
  int actualPageIndex = 0;
  int actualPageSize = 20;
  String? query;
  customPage.Page<Annonce>? pageAnnonce;

  void setQuery(String query) {
    this.query = query;
  }

  void setActualPage(int page) {
    actualPageIndex = page;
  }

  void setActualSize(int size) {
    actualPageSize = size;
  }

  void addFilter(SearchFilter filter) {
    searchFacetBody.filters.add(filter);
  }

  void selectFilter(int index) {
    if (transactionFiltersEnable[index]) {
      // Toggle button is already active.
      return;
    }

    transactionFiltersEnable = transactionFilters.map((e) => false).toList();
    searchFacetBody.filters.clear();
    SearchFilter filter = transactionFilters[index];
    searchFacetBody.filters.add(filter);
    transactionFiltersEnable[index] = !transactionFiltersEnable[index];

    search();
    notifyListeners();
  }

  void search({ScrollController? scrollController}) {
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

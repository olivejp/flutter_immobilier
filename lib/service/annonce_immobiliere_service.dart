import 'dart:convert';
import 'dart:io';

import 'package:flutter_immobilier/deveoLibrary/abstract_http_service.dart';
import 'package:flutter_immobilier/deveoLibrary/interface_interceptor.dart';
import 'package:flutter_immobilier/domain/facet.dart';
import 'package:flutter_immobilier/domain/facet_request.dart';
import 'package:http/http.dart' as http;

import '../domain/annonce_immobiliere.dart';

class AnnonceImmobiliereService extends AbstractHttpService<Annonce, String> {
  /*Constructor*/
  AnnonceImmobiliereService({
    InterfaceInterceptor? interceptor,
    Map<String, String>? Function()? getHeaders,
  }) : super(
            path: '/annonces',
            interceptor: interceptor,
            getHeaders: getHeaders,
            defaultHeaders: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });

  @override
  Annonce fromJson(Map<String, dynamic> map) {
    return Annonce.fromJson(map);
  }

  Future<List<Annonce>> search(String search) {
    final Uri uri = buildUri('$path/search/$search', null);
    return callInterceptor(http.get(uri)).then((response) {
      if (isStatusBetween200And299(response)) {
        final List<dynamic> listMap = decodeResponseBodyWithJsonPath(response!);
        return listMap.map((e) => fromJson(e)).toList();
      } else {
        return [];
      }
    });
  }

  Future<List<Facet>> searchFacet(String search) {
    final Uri uri = buildUri('$path/facets/$search', null);
    final List<Map<String, dynamic>> listFacetRequest = [];
    final FacetRequest facetRequest = FacetRequest();
    facetRequest.name = "Type";
    facetRequest.field = "type.label.keyword";
    facetRequest.typeAggregation = TypeAggregation.TERMS;

    final FacetRequest quartierFacet = FacetRequest();
    quartierFacet.name = "Quartier";
    quartierFacet.field = "realty.localization.label.keyword";
    quartierFacet.typeAggregation = TypeAggregation.TERMS;

    final FacetRequest maxPriceFacet = FacetRequest();
    maxPriceFacet.name = "Prix maximum";
    maxPriceFacet.field = "price.amount";
    maxPriceFacet.typeAggregation = TypeAggregation.MAX;

    listFacetRequest.add(facetRequest.toJson());
    listFacetRequest.add(quartierFacet.toJson());
    listFacetRequest.add(maxPriceFacet.toJson());
    return callInterceptor(http.post(
      uri,
      body: jsonEncode(listFacetRequest),
      headers: mergeHeaders(),
    )).then((response) {
      if (isStatusBetween200And299(response)) {
        final List<dynamic> listMap = decodeResponseBodyWithJsonPath(response!);
        return listMap.map((e) => Facet.fromJson(e)).toList();
      } else {
        return [];
      }
    });
  }
}

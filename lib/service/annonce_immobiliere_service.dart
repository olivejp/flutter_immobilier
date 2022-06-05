import 'dart:convert';
import 'dart:io';

import 'package:flutter_immobilier/deveoLibrary/abstract_http_service.dart';
import 'package:flutter_immobilier/deveoLibrary/interface_interceptor.dart';
import 'package:flutter_immobilier/domain/bucket_aggregation_model.dart';
import 'package:flutter_immobilier/domain/search_facet_body.dart';
import 'package:flutter_immobilier/domain/search_request_body.dart';
import 'package:http/http.dart' as http;

import '../domain/annonce_immobiliere.dart';
import '../domain/facet.dart';
import '../domain/page.dart';

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

  Future<Page<Annonce>> search(
    String search,
    SearchRequestBody? bodyRequest, {
    Map<String, String>? requestParams,
  }) {
    final Uri uri = buildUri('$path/search/$search', requestParams);
    final String body = jsonEncode(bodyRequest?.toJson());
    return callInterceptor(http.post(
      uri,
      body: body,
      headers: mergeHeaders(),
    )).then((response) {
      if (isStatusBetween200And299(response)) {
        return Page.fromJson(decodeResponseBodyWithJsonPath(response!));
      } else {
        return Page();
      }
    });
  }

  Future<List<Facet>> searchFacet(
      String search, SearchFacetBody? searchFacetBody) {
    final Uri uri = buildUri('$path/facets/$search', null);

    final BucketAggregationModel facetRequest = BucketAggregationModel();
    facetRequest.name = "Type";
    facetRequest.field = "type.label.keyword";
    facetRequest.typeAggregation = TypeAggregation.TERMS;

    final BucketAggregationModel quartierFacet = BucketAggregationModel();
    quartierFacet.name = "Quartier";
    quartierFacet.field = "realty.localization.label.keyword";
    quartierFacet.typeAggregation = TypeAggregation.TERMS;

    final BucketAggregationModel maxPriceFacet = BucketAggregationModel();
    maxPriceFacet.name = "Prix maximum";
    maxPriceFacet.field = "price.amount";
    maxPriceFacet.typeAggregation = TypeAggregation.MAX;

    searchFacetBody?.listBucketModel.add(facetRequest);
    searchFacetBody?.listBucketModel.add(quartierFacet);
    searchFacetBody?.listBucketModel.add(maxPriceFacet);

    return callInterceptor(http.post(
      uri,
      body: jsonEncode(searchFacetBody?.toJson()),
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

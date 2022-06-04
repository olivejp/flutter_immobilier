import 'dart:io';

import 'package:flutter_immobilier/deveoLibrary/abstract_http_service.dart';
import 'package:flutter_immobilier/deveoLibrary/interface_interceptor.dart';
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
}

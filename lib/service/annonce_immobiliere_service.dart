import 'dart:convert';

import 'package:flutter_immobilier/service/rest/abstract-rest-domain.service.dart';
import 'package:http/http.dart';

import '../domain/annonce_immobiliere.dart';

class AnnonceImmobiliereService extends RestDomainService<Annonce> {
  AnnonceImmobiliereService(String path, String authority)
      : super(path, authority: authority);

  @override
  Annonce mapResponseToDomain(Response response) {
    return Annonce.fromJson(json.decode(response.body));
  }

  @override
  List<Annonce> mapResponseToListDomain(Response response) {
    List<dynamic> listJson = json.decode(response.body);
    return listJson.map((e) => Annonce.fromJson(e)).toList();
  }

  Future<List<Annonce>> search(String search) {
    return restHttpService
        .get('${restHttpService.path}/search/$search')
        .then((response) => mapResponseToListDomain(response));
  }
}

import 'package:http/http.dart' as http;
import 'rest-http.service.dart';

/// Classe abstraite permettant de gérer un domain au travers d'un RestHttpService.
abstract class RestDomainService<T> {

  /// Méthode abstraite pour savoir comment désérializer une http.response en objet T.
  T mapResponseToDomain(http.Response response);

  /// Méthode abstraite pour savoir comment désérializer une http.response en liste d'objet T.
  List<T> mapResponseToListDomain(http.Response response);

  /*Constructor*/
  RestDomainService(
    this.path, {
    String authority = '',
    bool isHttps = false,
  }) {
    restHttpService = RestHttpService(
      authority: authority,
      isHttps: isHttps,
    );
  }

  final String path;
  late RestHttpService restHttpService;

  Future<T> find(
    String id, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return restHttpService
        .find(
          path,
          id,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => mapResponseToDomain(response));
  }

  Future<List<T>> findAll({
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return restHttpService
        .findAll(
          path,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => mapResponseToListDomain(response));
  }

  Future<bool> delete(String id,
      {Object? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) {
    return restHttpService
        .delete(
          path,
          id,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => true)
        .catchError((error) => false);
  }

  Future<T> save(
    String id,
    Object body, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return restHttpService
        .save(
          path,
          id,
          body,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => mapResponseToDomain(response));
  }

  Future<T> update(
    String id,
    Object body, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return restHttpService
        .update(
          path,
          id,
          body,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => mapResponseToDomain(response));
  }
}

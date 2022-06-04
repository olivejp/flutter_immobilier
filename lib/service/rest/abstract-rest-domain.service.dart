import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import 'rest-http.service.dart';

/// Classe abstraite permettant de gérer un domain au travers d'un RestHttpService.
abstract class RestDomainService<T> {
  T mapResponseToDomain(http.Response response);

  List<T> mapResponseToListDomain(http.Response response);

  RestDomainService(
    String path, {
    String authority = '',
    bool isHttps = false,
  }) {
    restHttpService = RestHttpService(
      path,
      authority: authority,
      isHttps: isHttps,
    );
  }

  late RestHttpService restHttpService;

  Future<Tuple2<T, http.Response>> find(String id,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return restHttpService
        .find(id, headers: headers, queryParameters: queryParameters)
        .then((response) => Tuple2(mapResponseToDomain(response), response));
  }

  Future<Tuple2<List<T>, http.Response>> findAll(
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return restHttpService
        .findAll(
          headers: headers,
          queryParameters: queryParameters,
        )
        .then(
            (response) => Tuple2(mapResponseToListDomain(response), response));
  }

  Future<bool> delete(String id,
      {Object? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) {
    return restHttpService
        .delete(
          id,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => true)
        .catchError((error) => false);
  }

  Future<Tuple2<T, http.Response>> save(String id, Object body,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return restHttpService
        .save(
          id,
          body,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => Tuple2(mapResponseToDomain(response), response));
  }

  Future<Tuple2<T, http.Response>> update(String id, Object body,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return restHttpService
        .update(
          id,
          body,
          headers: headers,
          queryParameters: queryParameters,
        )
        .then((response) => Tuple2(mapResponseToDomain(response), response));
  }
}

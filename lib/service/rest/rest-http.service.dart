import 'package:http/http.dart' as http;

import 'http.service.dart';

class RestHttpService extends HttpService {
  final String path;

  RestHttpService(this.path, {String authority = '', bool isHttps = false})
      : super(authority, isHttps: isHttps);

  Future<http.Response> find(String id,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return get('$path/$id', headers: headers, queryParameters: queryParameters);
  }

  Future<http.Response> findAll(
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return getAll(path,
        headers: headers, queryParameters: queryParameters);
  }

  Future<http.Response> delete(String id,
      {Object? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) {
    return suppress('$path/$id',
        body: body, headers: headers, queryParameters: queryParameters);
  }

  Future<http.Response> save(String id, Object body,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return post(body, '$path/$id',
        headers: headers, queryParameters: queryParameters);
  }

  Future<http.Response> update(String id, Object body,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters}) {
    return put(body, '$path/$id',
        headers: headers, queryParameters: queryParameters);
  }
}

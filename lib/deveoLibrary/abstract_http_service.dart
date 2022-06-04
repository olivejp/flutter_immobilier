import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'abstract.domain.dart';
import '../environment_config.dart';
import 'interface_interceptor.dart';
import 'interface_service.dart';
import 'json_patch.dart';

/// Abstract CRUD service through HTTP.
/// @depends on EnvironmentConfig class.
/// @author JPOLIVE
abstract class AbstractHttpService<T extends AbstractDomain<U>, U>
    implements InterfaceService<T, U> {
  AbstractHttpService(
      {required this.path,
      this.interceptor,
      this.defaultHeaders,
      this.getHeaders}) {
    if (EnvironmentConfig.serverUrl.isEmpty == true) {
      throw Exception(
          'EnvironmentConfig.serverUrl is empty. Please fill this variable.');
    }
  }

  final Duration _defaultTimeoutDuration = const Duration(seconds: 60);
  final Future<http.Response> _defaultTimeoutResponse =
      Future.value(http.Response('Timeout exception', 408));

  /// The URL of the resource.
  String path;

  /// If the service should use HTTPS instead of HTTP.
  /// Default to FALSE to use HTTP.
  bool useHttps = EnvironmentConfig.useHttps;

  /// Optional : Function to get authorization headers to send with all the requests of this service.
  /// If headers are passed at the method level, merge the two maps.
  Map<String, String>? Function()? getHeaders;

  /// Optional : Default headers to send with all the requests of this service.
  /// If headers are passed at the method level, merge the two maps.
  Map<String, String>? defaultHeaders;

  /// Optional : Define interceptor that will catch HttpResponse.
  InterfaceInterceptor? interceptor;

  /// Classes extending @{AbstractHttpService} have to implement this fromJson method,
  /// to define the serialization of an http response.
  T fromJson(Map<String, dynamic> map);

  Future<http.Response?> callInterceptor(Future<http.Response?> httpCall,
      {Duration? timeout}) {
    final Duration timeoutDuration = timeout ?? _defaultTimeoutDuration;
    return httpCall
        .timeout(timeoutDuration, onTimeout: () => _defaultTimeoutResponse)
        .then((httpResponse) {
      interceptor?.catchResponse(httpResponse);
      return httpResponse;
    });
  }

  /// Merge headers passed to method level with the defaultHeaders of the service and the headers from authorizationHeaders.
  /// Priority between the headers is :
  /// 1 - the headers passed to the method level
  /// 2 - the headers passed to the service
  /// 3 - the default headers
  Map<String, String>? mergeHeaders(Map<String, String>? headers) {
    Map<String, String>? authorizationHeaders;
    if (getHeaders != null) {
      authorizationHeaders = getHeaders!();
    }
    return {...?defaultHeaders, ...?authorizationHeaders, ...?headers};
  }

  bool isStatusBetween200And299(http.Response? response) {
    if (response == null) {
      return false;
    }
    return response.statusCode >= HttpStatus.ok &&
        response.statusCode < HttpStatus.multipleChoices;
  }

  Uri buildUri(String path, Map<String, String>? queryParams) {
    return useHttps
        ? Uri.https(EnvironmentConfig.serverUrl, path, queryParams)
        : Uri.http(EnvironmentConfig.serverUrl, path, queryParams);
  }

  decodeResponseBodyWithJsonPath(http.Response response,
      {List<String>? jsonRoot}) {
    dynamic body = jsonDecode(utf8.decode(response.bodyBytes));
    if (jsonRoot != null && jsonRoot.isNotEmpty) {
      for (String jsonPath in jsonRoot) {
        body = body[jsonPath];
      }
    }
    return body;
  }

  @override
  Future<T> create(T body,
      {Map<String, String>? headers,
      Map<String, String>? queryParams,
      Encoding? encoding,
      List<String>? jsonRoot,
      Duration? timeout}) {
    final Uri uri = buildUri(path, queryParams);
    final Map<String, dynamic> bodyJson = body.toJson();
    final String json = jsonEncode(bodyJson);
    final Map<String, String>? headersToSend = mergeHeaders(headers);

    return callInterceptor(
      http.post(
        uri,
        body: json,
        headers: headersToSend,
        encoding: encoding,
      ),
      timeout: timeout,
    ).then((response) {
      if (isStatusBetween200And299(response)) {
        return fromJson(
            decodeResponseBodyWithJsonPath(response!, jsonRoot: jsonRoot));
      } else {
        return Future.error(response?.body ?? '');
      }
    });
  }

  @override
  Future<T> update(T body,
      {Map<String, String>? headers,
      Map<String, String>? queryParams,
      Encoding? encoding,
      List<String>? jsonRoot,
      Duration? timeout}) {
    final String id = body.id.toString();
    final Uri uri = buildUri('$path/$id', queryParams);
    final Map<String, dynamic> bodyJson = body.toJson();
    final String json = jsonEncode(bodyJson);
    final Map<String, String>? headersToSend = mergeHeaders(headers);

    return callInterceptor(
      http.put(
        uri,
        body: json,
        headers: headersToSend,
        encoding: encoding,
      ),
      timeout: timeout,
    ).then((response) {
      if (isStatusBetween200And299(response)) {
        return fromJson(
            decodeResponseBodyWithJsonPath(response!, jsonRoot: jsonRoot));
      } else {
        return Future.error(response?.body ?? '');
      }
    });
  }

  @override
  Future<void> delete(
    U id, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    Encoding? encoding,
    Duration? timeout,
  }) {
    final Uri uri = buildUri('$path/$id', queryParams);
    final Map<String, String>? headersToSend = mergeHeaders(headers);

    return callInterceptor(
      http.delete(
        uri,
        headers: headersToSend,
        encoding: encoding,
      ),
      timeout: timeout,
    );
  }

  @override
  Future<T> read(
    U id, {
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    List<String>? jsonRoot,
    Duration? timeout,
  }) {
    final Uri uri = buildUri('$path/$id', queryParams);
    final Map<String, String>? headersToSend = mergeHeaders(headers);

    return callInterceptor(http.get(uri, headers: headersToSend))
        .then((response) {
      if (isStatusBetween200And299(response)) {
        return fromJson(
            decodeResponseBodyWithJsonPath(response!, jsonRoot: jsonRoot));
      } else {
        return Future.error(response?.body ?? '');
      }
    });
  }

  /// Method that will make a Http GET
  @override
  Future<List<T>> getAll({
    Map<String, String>? headers,
    Map<String, String>? queryParams,
    List<String>? jsonRoot,
    Duration? timeout,
  }) {
    final Uri uri = buildUri(path, queryParams);
    final Map<String, String>? headersToSend = mergeHeaders(headers);

    return callInterceptor(http.get(uri, headers: headersToSend),
            timeout: timeout)
        .then((response) {
      if (isStatusBetween200And299(response)) {
        final List<dynamic> listMap =
            decodeResponseBodyWithJsonPath(response!, jsonRoot: jsonRoot);
        return listMap.map((e) => fromJson(e)).toList();
      }
      throw Exception('ERROR while reading all domains.');
    });
  }

  Future<T> patch(
      {required int id,
      required JsonPatchObject body,
      Map<String, String>? headers,
      Map<String, String>? queryParams,
      Encoding? encoding,
      List<String>? jsonRoot,
      Duration? timeout}) {
    final Uri uri = buildUri('$path/$id', queryParams);
    final String jsonBody = jsonEncode([body.toJson()]);
    final Map<String, String>? headersToSend = mergeHeaders(headers);

    return callInterceptor(
      http.patch(
        uri,
        body: jsonBody,
        headers: headersToSend,
        encoding: encoding,
      ),
      timeout: timeout,
    ).then((response) {
      if (isStatusBetween200And299(response)) {
        return fromJson(
            decodeResponseBodyWithJsonPath(response!, jsonRoot: jsonRoot));
      } else {
        return Future.error(response?.body ?? '');
      }
    });
  }
}

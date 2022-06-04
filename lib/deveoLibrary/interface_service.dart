import 'dart:convert';

import 'abstract.domain.dart';

abstract class InterfaceService<T extends AbstractDomain<U>, U> {
  Future<dynamic> create(T body,
      {Map<String, String>? headers, Encoding? encoding});

  Future<void> update(T body,
      {Map<String, String>? headers, Encoding? encoding});

  Future<void> delete(U id, {Map<String, String>? headers, Encoding? encoding});

  Future<T> read(U id,
      {Map<String, String>? headers, Map<String, String>? queryParams});

  Future<List<T>> getAll(
      {Map<String, String>? headers,
      Map<String, String>? queryParams,
      List<String>? jsonRoot});
}

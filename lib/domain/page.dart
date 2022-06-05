import 'package:flutter_immobilier/domain/pageable.dart';
import 'package:flutter_immobilier/domain/sort.dart';
import 'package:json_annotation/json_annotation.dart';

import 'annonce_immobiliere.dart';

part 'page.g.dart';

@JsonSerializable()
@JsonSerializable(genericArgumentFactories: true)
class Page<T> {
  bool? last;
  int? totalPages;
  int? totalElements;
  bool? first;
  int? number;
  int? size;
  int? numberOfElements;
  bool? empty;

  @JsonKey(name: 'content')
  @_Converter()
  List<T>? content;

  Sort? sort;
  Pageable? pageable;

  Page();

  factory Page.fromJson(Map<String, dynamic> data) => _$PageFromJson(data);
}

class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return Annonce.fromJson(json) as T;
    }
    // This will only work if `json` is a native JSON type:
    //   num, String, bool, null, etc
    // *and* is assignable to `T`.
    return json as T;
  }

  // This will only work if `object` is a native JSON type:
  //   num, String, bool, null, etc
  // Or if it has a `toJson()` function`.
  @override
  Object? toJson(T object) => object;
}

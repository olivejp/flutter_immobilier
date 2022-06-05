import 'package:flutter_immobilier/domain/sort.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pageable.g.dart';

@JsonSerializable()
class Pageable<T> {
  Sort? sort;
  int? offset;
  int? pageNumber;
  int? pageSize;
  bool? paged;
  bool? unpaged;

  Pageable();

  factory Pageable.fromJson(Map<String, dynamic> data) =>
      _$PageableFromJson(data);
}

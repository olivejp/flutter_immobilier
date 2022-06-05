import 'package:flutter_immobilier/domain/search_filter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_request_body.g.dart';

@JsonSerializable()
class SearchRequestBody {
  List<SearchFilter> filters = [];

  SearchRequestBody();

  factory SearchRequestBody.fromJson(Map<String, dynamic> data) =>
      _$SearchRequestBodyFromJson(data);

  Map<String, dynamic> toJson() => _$SearchRequestBodyToJson(this);
}

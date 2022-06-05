import 'package:flutter_immobilier/domain/search_filter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_request_body.g.dart';

@JsonSerializable()
class SearchBodyRequest {
  List<SearchFilter>? filters;

  SearchBodyRequest();

  factory SearchBodyRequest.fromJson(Map<String, dynamic> data) =>
      _$SearchBodyRequestFromJson(data);

  Map<String, dynamic> toJson() => _$SearchBodyRequestToJson(this);
}

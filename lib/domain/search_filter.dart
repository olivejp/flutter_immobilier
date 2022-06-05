import 'package:json_annotation/json_annotation.dart';

part 'search_filter.g.dart';

enum TypeSearchFilter {
  MATCH
}

@JsonSerializable()
class SearchFilter {
  String? field;
  TypeSearchFilter? type;
  String? value;

  SearchFilter({this.field, this.type, this.value});

  factory SearchFilter.fromJson(Map<String, dynamic> data) =>
      _$SearchFilterFromJson(data);


  Map<String, dynamic> toJson() => _$SearchFilterToJson(this);
}

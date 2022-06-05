import 'package:json_annotation/json_annotation.dart';

part 'search_filter.g.dart';

@JsonSerializable()
class SearchFilter {
  String? field;
  String? type;
  String? value;

  SearchFilter({this.field, this.type, this.value});

  factory SearchFilter.fromJson(Map<String, dynamic> data) =>
      _$SearchFilterFromJson(data);


  Map<String, dynamic> toJson() => _$SearchFilterToJson(this);
}

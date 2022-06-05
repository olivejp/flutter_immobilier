import 'package:json_annotation/json_annotation.dart';

part 'sort.g.dart';

@JsonSerializable()
class Sort<T> {
  bool? empty;
  bool? unsorted;
  bool? sorted;

  Sort();

  factory Sort.fromJson(Map<String, dynamic> data) => _$SortFromJson(data);
}

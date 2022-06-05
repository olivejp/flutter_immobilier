import 'package:json_annotation/json_annotation.dart';

part 'bucket.g.dart';

@JsonSerializable()
class Bucket {
  String? name;
  int? docCount;

  Bucket();

  factory Bucket.fromJson(Map<String, dynamic> data) => _$BucketFromJson(data);
}

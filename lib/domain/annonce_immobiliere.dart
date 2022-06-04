import 'package:json_annotation/json_annotation.dart';

part 'annonce_immobiliere.g.dart';

@JsonSerializable()
class Annonce {
  Annonce();

  factory Annonce.fromJson(Map<String, dynamic> data) => _$AnnonceFromJson(data);

  String? description;
  String? quartier;
  String? nomAgence;
  String? categorie;
  String? type;
  double? prix;
  double? latitude;
  double? longitude;

  @override
  Map<String, dynamic> toJson() => _$AnnonceToJson(this);
}

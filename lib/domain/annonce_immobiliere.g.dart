// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'annonce_immobiliere.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Annonce _$AnnonceFromJson(Map<String, dynamic> json) {
  return Annonce()
    ..description = json['description'] as String?
    ..quartier = json['quartier'] as String?
    ..nomAgence = json['nomAgence'] as String?
    ..categorie = json['categorie'] as String?
    ..type = json['type'] as String?
    ..prix = (json['prix'] as num?)?.toDouble()
    ..latitude = (json['latitude'] as num?)?.toDouble()
    ..longitude = (json['longitude'] as num?)?.toDouble();
}

Map<String, dynamic> _$AnnonceToJson(Annonce instance) => <String, dynamic>{
      'description': instance.description,
      'quartier': instance.quartier,
      'nomAgence': instance.nomAgence,
      'categorie': instance.categorie,
      'type': instance.type,
      'prix': instance.prix,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

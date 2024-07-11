// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestaurantOwner _$RestaurantOwnerFromJson(Map<String, dynamic> json) =>
    RestaurantOwner(
      id: json['id'] as String,
      rg: json['rg'] as String,
      cpf: json['cpf'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      name: json['name'] as String,
    );

Map<String, dynamic> _$RestaurantOwnerToJson(RestaurantOwner instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rg': instance.rg,
      'cpf': instance.cpf,
      'birthDate': instance.birthDate.toIso8601String(),
      'name': instance.name,
    };

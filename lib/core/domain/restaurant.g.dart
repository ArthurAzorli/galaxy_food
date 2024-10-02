// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) => Restaurant(
      id: json['id'] as String,
      cnpj: json['cnpj'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      speciality: json['speciality'] as String?,
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      score: (json['score'] as num?)?.toDouble() ?? 0,
      phones: (json['phones'] as List<dynamic>)
          .map((e) => Phone.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: RestaurantOwner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cnpj': instance.cnpj,
      'email': instance.email,
      'name': instance.name,
      'speciality': instance.speciality,
      'image': instance.image,
      'address': instance.address,
      'score': instance.score,
      'phones': instance.phones,
      'owner': instance.owner,
    };

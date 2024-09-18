// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as String?,
      cpf: json['cpf'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      birthDate: DateTime.parse(json['birthDate'] as String),
      image: (json['image'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((e) => Address.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      phones: (json['phones'] as List<dynamic>?)
              ?.map((e) => Phone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'cpf': instance.cpf,
      'name': instance.name,
      'email': instance.email,
      'birthDate': instance.birthDate.toIso8601String(),
      'image': instance.image,
      'addresses': instance.addresses,
      'phones': instance.phones,
      'password': instance._password,
    };

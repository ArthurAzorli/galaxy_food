// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Package _$PackageFromJson(Map<String, dynamic> json) => Package(
      id: json['id'] as String,
      name: json['name'] as String,
      parent: json['parent'] as String?,
      restaurant: json['restaurant'] as String,
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => Package.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => PackageItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PackageToJson(Package instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parent': instance.parent,
      'restaurant': instance.restaurant,
      'children': instance.children,
      'items': instance.items,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Combo _$ComboFromJson(Map<String, dynamic> json) => Combo(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      parent: json['parent'] as String,
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => ComboItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    )..image = PackageItem.imageFromJson(json['image']);

Map<String, dynamic> _$ComboToJson(Combo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'image': instance.image,
      'parent': instance.parent,
      'items': instance.items,
    };

ComboItem _$ComboItemFromJson(Map<String, dynamic> json) => ComboItem(
      id: json['id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      combo: json['combo'] as String,
      item: Food.fromJson(json['item'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComboItemToJson(ComboItem instance) => <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'combo': instance.combo,
      'item': instance.item,
    };

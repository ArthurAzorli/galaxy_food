// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Buy _$BuyFromJson(Map<String, dynamic> json) => Buy(
      id: json['id'] as String?,
      paymentForm: $enumDecode(_$PaymentFormEnumMap, json['paymentForm']),
      orderStatus: $enumDecode(_$OrderStatusEnumMap, json['orderStatus']),
      date: DateTime.parse(json['date'] as String),
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0,
      discount: (json['discount'] as num?)?.toDouble() ?? 0,
      sentAddress:
          Address.fromJson(json['sentAddress'] as Map<String, dynamic>),
      client: Client.fromJson(json['client'] as Map<String, dynamic>),
      restaurant:
          Restaurant.fromJson(json['restaurant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuyToJson(Buy instance) => <String, dynamic>{
      'id': instance.id,
      'paymentForm': _$PaymentFormEnumMap[instance.paymentForm]!,
      'orderStatus': _$OrderStatusEnumMap[instance.orderStatus]!,
      'date': instance.date.toIso8601String(),
      'deliveryFee': instance.deliveryFee,
      'discount': instance.discount,
      'sentAddress': instance.sentAddress,
      'client': instance.client,
      'restaurant': instance.restaurant,
    };

const _$PaymentFormEnumMap = {
  PaymentForm.dinheiro: 'dinheiro',
  PaymentForm.credito: 'credito',
  PaymentForm.debito: 'debito',
  PaymentForm.pix: 'pix',
};

const _$OrderStatusEnumMap = {
  OrderStatus.canceled: 'canceled',
  OrderStatus.waiting: 'waiting',
  OrderStatus.making: 'making',
  OrderStatus.made: 'made',
  OrderStatus.delivered: 'delivered',
};

BuyItem _$BuyItemFromJson(Map<String, dynamic> json) => BuyItem(
      id: json['id'] as String?,
      buy: Buy.fromJson(json['buy'] as Map<String, dynamic>),
      item: PackageItem.fromJson(json['item'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$BuyItemToJson(BuyItem instance) => <String, dynamic>{
      'id': instance.id,
      'buy': instance.buy,
      'item': instance.item,
      'quantity': instance.quantity,
    };

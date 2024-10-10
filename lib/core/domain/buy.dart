import 'package:galaxy_food/core/domain/package_item.dart';
import 'package:json_annotation/json_annotation.dart';
import 'address.dart';
import 'client.dart';
import 'order_status.dart';
import 'payment_form.dart';
import 'restaurant.dart';

part 'buy.g.dart';

@JsonSerializable()
class Buy{

  late String? id;
  @JsonKey(fromJson: _paymentFormFromJson)
  late final PaymentForm paymentForm;
  @JsonKey(fromJson: _orderStatusFromJson)
  late OrderStatus orderStatus;
  late final DateTime date;
  late double deliveryFee;
  late double discount;
  late final Address sentAddress;
  late final Client client;
  late final Restaurant restaurant;
  final List<BuyItem> items;

  Buy({
    required this.id,
    required this.paymentForm,
    required this.orderStatus,
    required this.date,
    this.deliveryFee = 0,
    this.discount = 0,
    required this.sentAddress,
    required this.client,
    required this.restaurant,
    this.items = const [],
  });

  factory Buy.fromJson(Map<String, dynamic> json) => _$BuyFromJson(json);

  Map<String, dynamic> toJson() => _$BuyToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is Buy && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

  static _paymentFormFromJson(json) => PaymentForm.getFromCode(json);
  static _orderStatusFromJson(json) => OrderStatus.getFromCode(json);

}

@JsonSerializable()
class BuyItem{
  late String? id;
  late String buy;
  late final PackageItem item;
  late final int quantity;

  BuyItem({
    this.id,
    required this.buy,
    required this.item,
    required this.quantity
  });

  factory BuyItem.fromJson(Map<String, dynamic> json) => _$BuyItemFromJson(json);

  Map<String, dynamic> toJson() => _$BuyItemToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is BuyItem && other.id == id) return true;
    return false;
  }

  @override
  int get hashCode => id.hashCode;

}
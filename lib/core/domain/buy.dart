import 'package:galaxy_food/core/domain/combo.dart';
import 'package:galaxy_food/core/domain/food.dart';
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
  @JsonKey(fromJson: _paymentFormFromJson, toJson: _paymentFormToJson)
  late final PaymentForm paymentForm;
  @JsonKey(fromJson: _orderStatusFromJson, toJson: _orderStatusToJson)
  late OrderStatus orderStatus;
  late final DateTime date;
  late double deliveryFee;
  late double discount;
  @JsonKey(toJson: _addressToJson)
  late final Address sentAddress;
  @JsonKey(toJson: _clientToJson)
  late final Client client;
  @JsonKey(toJson: _restaurantToJson)
  late final Restaurant restaurant;
  @JsonKey(toJson: _itemsToJson)
  final List<BuyItem> items;

  Buy({
    this.id,
    required this.paymentForm,
    this.orderStatus = OrderStatus.waiting,
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

  static _clientToJson(client) => client.id!;
  static _restaurantToJson(restaurant) => restaurant.id;
  static _addressToJson(address) => address.id!;
  static _paymentFormFromJson(json) => PaymentForm.getFromCode(json);
  static _paymentFormToJson(paymentForm) => paymentForm.code;
  static _orderStatusFromJson(json) => OrderStatus.getFromCode(json);
  static _orderStatusToJson(orderStatus) => orderStatus.code;
  static _itemsToJson(items){
    final list = [];
    for (var item in items){
      list.add(item.toJson());
    }
    return list;
  }

}

@JsonSerializable()
class BuyItem{
  late String? id;
  late String? buy;
  @JsonKey(toJson: _itemToJson)
  late final PackageItem item;
  late final int quantity;

  BuyItem({
    this.id,
    this.buy,
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

  static _itemToJson(PackageItem item) => item.id;
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RestaurantViewModel on RestaurantViewModelBase, Store {
  late final _$initBuyAtom =
      Atom(name: 'RestaurantViewModelBase.initBuy', context: context);

  @override
  bool get initBuy {
    _$initBuyAtom.reportRead();
    return super.initBuy;
  }

  @override
  set initBuy(bool value) {
    _$initBuyAtom.reportWrite(value, super.initBuy, () {
      super.initBuy = value;
    });
  }

  late final _$restaurantAtom =
      Atom(name: 'RestaurantViewModelBase.restaurant', context: context);

  @override
  Restaurant? get restaurant {
    _$restaurantAtom.reportRead();
    return super.restaurant;
  }

  @override
  set restaurant(Restaurant? value) {
    _$restaurantAtom.reportWrite(value, super.restaurant, () {
      super.restaurant = value;
    });
  }

  late final _$clientAtom =
      Atom(name: 'RestaurantViewModelBase.client', context: context);

  @override
  Client? get client {
    _$clientAtom.reportRead();
    return super.client;
  }

  @override
  set client(Client? value) {
    _$clientAtom.reportWrite(value, super.client, () {
      super.client = value;
    });
  }

  late final _$addressSelectedAtom =
      Atom(name: 'RestaurantViewModelBase.addressSelected', context: context);

  @override
  Address? get addressSelected {
    _$addressSelectedAtom.reportRead();
    return super.addressSelected;
  }

  @override
  set addressSelected(Address? value) {
    _$addressSelectedAtom.reportWrite(value, super.addressSelected, () {
      super.addressSelected = value;
    });
  }

  late final _$rootAtom =
      Atom(name: 'RestaurantViewModelBase.root', context: context);

  @override
  Package? get root {
    _$rootAtom.reportRead();
    return super.root;
  }

  @override
  set root(Package? value) {
    _$rootAtom.reportWrite(value, super.root, () {
      super.root = value;
    });
  }

  late final _$buyCountAtom =
      Atom(name: 'RestaurantViewModelBase.buyCount', context: context);

  @override
  int? get buyCount {
    _$buyCountAtom.reportRead();
    return super.buyCount;
  }

  @override
  set buyCount(int? value) {
    _$buyCountAtom.reportWrite(value, super.buyCount, () {
      super.buyCount = value;
    });
  }

  late final _$scoreAtom =
      Atom(name: 'RestaurantViewModelBase.score', context: context);

  @override
  double get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(double value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  late final _$totalValueAtom =
      Atom(name: 'RestaurantViewModelBase.totalValue', context: context);

  @override
  double get totalValue {
    _$totalValueAtom.reportRead();
    return super.totalValue;
  }

  @override
  set totalValue(double value) {
    _$totalValueAtom.reportWrite(value, super.totalValue, () {
      super.totalValue = value;
    });
  }

  late final _$listBuyAtom =
      Atom(name: 'RestaurantViewModelBase.listBuy', context: context);

  @override
  ObservableMap<PackageItem, int> get listBuy {
    _$listBuyAtom.reportRead();
    return super.listBuy;
  }

  @override
  set listBuy(ObservableMap<PackageItem, int> value) {
    _$listBuyAtom.reportWrite(value, super.listBuy, () {
      super.listBuy = value;
    });
  }

  late final _$RestaurantViewModelBaseActionController =
      ActionController(name: 'RestaurantViewModelBase', context: context);

  @override
  List<Widget>? getMenu(BuildContext context) {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.getMenu');
    try {
      return super.getMenu(context);
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic backToHome(BuildContext context) {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.backToHome');
    try {
      return super.backToHome(context);
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancel() {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.cancel');
    try {
      return super.cancel();
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeBuyItem(PackageItem item) {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.removeBuyItem');
    try {
      return super.removeBuyItem(item);
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void avalition(BuildContext context) {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.avalition');
    try {
      return super.avalition(context);
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void add(PackageItem item) {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.add');
    try {
      return super.add(item);
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void rem(PackageItem item) {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.rem');
    try {
      return super.rem(item);
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Address? _getAddressSelected() {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase._getAddressSelected');
    try {
      return super._getAddressSelected();
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic finishBuy(BuildContext context) {
    final _$actionInfo = _$RestaurantViewModelBaseActionController.startAction(
        name: 'RestaurantViewModelBase.finishBuy');
    try {
      return super.finishBuy(context);
    } finally {
      _$RestaurantViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
initBuy: ${initBuy},
restaurant: ${restaurant},
client: ${client},
addressSelected: ${addressSelected},
root: ${root},
buyCount: ${buyCount},
score: ${score},
totalValue: ${totalValue},
listBuy: ${listBuy}
    ''';
  }
}

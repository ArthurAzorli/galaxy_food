// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on HomeViewModelBase, Store {
  Computed<Address?>? _$addressSelectComputed;

  @override
  Address? get addressSelect =>
      (_$addressSelectComputed ??= Computed<Address?>(() => super.addressSelect,
              name: 'HomeViewModelBase.addressSelect'))
          .value;

  late final _$clientAtom =
      Atom(name: 'HomeViewModelBase.client', context: context);

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

  late final _$restaurantsAtom =
      Atom(name: 'HomeViewModelBase.restaurants', context: context);

  @override
  List<Restaurant> get restaurants {
    _$restaurantsAtom.reportRead();
    return super.restaurants;
  }

  @override
  set restaurants(List<Restaurant> value) {
    _$restaurantsAtom.reportWrite(value, super.restaurants, () {
      super.restaurants = value;
    });
  }

  late final _$getFoodItemOfAsyncAction =
      AsyncAction('HomeViewModelBase.getFoodItemOf', context: context);

  @override
  Future<List<PackageItem>?> getFoodItemOf(
      BuildContext context, Restaurant restaurant) {
    return _$getFoodItemOfAsyncAction
        .run(() => super.getFoodItemOf(context, restaurant));
  }

  late final _$HomeViewModelBaseActionController =
      ActionController(name: 'HomeViewModelBase', context: context);

  @override
  void search() {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
        name: 'HomeViewModelBase.search');
    try {
      return super.search();
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void seeRestaurant(BuildContext context, Restaurant restaurant) {
    final _$actionInfo = _$HomeViewModelBaseActionController.startAction(
        name: 'HomeViewModelBase.seeRestaurant');
    try {
      return super.seeRestaurant(context, restaurant);
    } finally {
      _$HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
client: ${client},
restaurants: ${restaurants},
addressSelect: ${addressSelect}
    ''';
  }
}

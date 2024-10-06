// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SearchViewModel on SearchViewModelBase, Store {
  late final _$focusSearchAtom =
      Atom(name: 'SearchViewModelBase.focusSearch', context: context);

  @override
  FocusNode get focusSearch {
    _$focusSearchAtom.reportRead();
    return super.focusSearch;
  }

  @override
  set focusSearch(FocusNode value) {
    _$focusSearchAtom.reportWrite(value, super.focusSearch, () {
      super.focusSearch = value;
    });
  }

  late final _$textEditingControllerSearchAtom = Atom(
      name: 'SearchViewModelBase.textEditingControllerSearch',
      context: context);

  @override
  TextEditingController get textEditingControllerSearch {
    _$textEditingControllerSearchAtom.reportRead();
    return super.textEditingControllerSearch;
  }

  @override
  set textEditingControllerSearch(TextEditingController value) {
    _$textEditingControllerSearchAtom
        .reportWrite(value, super.textEditingControllerSearch, () {
      super.textEditingControllerSearch = value;
    });
  }

  late final _$restaurantsAtom =
      Atom(name: 'SearchViewModelBase.restaurants', context: context);

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

  late final _$beforeSearchAtom =
      Atom(name: 'SearchViewModelBase.beforeSearch', context: context);

  @override
  bool get beforeSearch {
    _$beforeSearchAtom.reportRead();
    return super.beforeSearch;
  }

  @override
  set beforeSearch(bool value) {
    _$beforeSearchAtom.reportWrite(value, super.beforeSearch, () {
      super.beforeSearch = value;
    });
  }

  late final _$searchAsyncAction =
      AsyncAction('SearchViewModelBase.search', context: context);

  @override
  Future search(BuildContext context) {
    return _$searchAsyncAction.run(() => super.search(context));
  }

  late final _$getFoodItemOfAsyncAction =
      AsyncAction('SearchViewModelBase.getFoodItemOf', context: context);

  @override
  Future<List<PackageItem>?> getFoodItemOf(
      BuildContext context, Restaurant restaurant) {
    return _$getFoodItemOfAsyncAction
        .run(() => super.getFoodItemOf(context, restaurant));
  }

  late final _$SearchViewModelBaseActionController =
      ActionController(name: 'SearchViewModelBase', context: context);

  @override
  dynamic reset() {
    final _$actionInfo = _$SearchViewModelBaseActionController.startAction(
        name: 'SearchViewModelBase.reset');
    try {
      return super.reset();
    } finally {
      _$SearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void seeRestaurant(BuildContext context, Restaurant restaurant) {
    final _$actionInfo = _$SearchViewModelBaseActionController.startAction(
        name: 'SearchViewModelBase.seeRestaurant');
    try {
      return super.seeRestaurant(context, restaurant);
    } finally {
      _$SearchViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
focusSearch: ${focusSearch},
textEditingControllerSearch: ${textEditingControllerSearch},
restaurants: ${restaurants},
beforeSearch: ${beforeSearch}
    ''';
  }
}

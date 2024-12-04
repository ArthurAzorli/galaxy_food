// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrderViewModel on OrderViewModelBase, Store {
  Computed<bool>? _$listIsEmptyComputed;

  @override
  bool get listIsEmpty =>
      (_$listIsEmptyComputed ??= Computed<bool>(() => super.listIsEmpty,
              name: 'OrderViewModelBase.listIsEmpty'))
          .value;

  late final _$oldOrdersAtom =
      Atom(name: 'OrderViewModelBase.oldOrders', context: context);

  @override
  List<Buy> get oldOrders {
    _$oldOrdersAtom.reportRead();
    return super.oldOrders;
  }

  @override
  set oldOrders(List<Buy> value) {
    _$oldOrdersAtom.reportWrite(value, super.oldOrders, () {
      super.oldOrders = value;
    });
  }

  late final _$newOrdersAtom =
      Atom(name: 'OrderViewModelBase.newOrders', context: context);

  @override
  List<Buy> get newOrders {
    _$newOrdersAtom.reportRead();
    return super.newOrders;
  }

  @override
  set newOrders(List<Buy> value) {
    _$newOrdersAtom.reportWrite(value, super.newOrders, () {
      super.newOrders = value;
    });
  }

  late final _$updateAsyncAction =
      AsyncAction('OrderViewModelBase.update', context: context);

  @override
  Future update(BuildContext context) {
    return _$updateAsyncAction.run(() => super.update(context));
  }

  late final _$OrderViewModelBaseActionController =
      ActionController(name: 'OrderViewModelBase', context: context);

  @override
  dynamic cancel(BuildContext context, Buy buy) {
    final _$actionInfo = _$OrderViewModelBaseActionController.startAction(
        name: 'OrderViewModelBase.cancel');
    try {
      return super.cancel(context, buy);
    } finally {
      _$OrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic seeDetails(BuildContext context, Buy buy) {
    final _$actionInfo = _$OrderViewModelBaseActionController.startAction(
        name: 'OrderViewModelBase.seeDetails');
    try {
      return super.seeDetails(context, buy);
    } finally {
      _$OrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic printing(Buy buy) {
    final _$actionInfo = _$OrderViewModelBaseActionController.startAction(
        name: 'OrderViewModelBase.printing');
    try {
      return super.printing(buy);
    } finally {
      _$OrderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
oldOrders: ${oldOrders},
newOrders: ${newOrders},
listIsEmpty: ${listIsEmpty}
    ''';
  }
}

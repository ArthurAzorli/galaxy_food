// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainViewModel on MainViewModelBase, Store {
  late final _$addressSelectAtom =
      Atom(name: 'MainViewModelBase.addressSelect', context: context);

  @override
  int get addressSelect {
    _$addressSelectAtom.reportRead();
    return super.addressSelect;
  }

  @override
  set addressSelect(int value) {
    _$addressSelectAtom.reportWrite(value, super.addressSelect, () {
      super.addressSelect = value;
    });
  }

  late final _$valueAtom =
      Atom(name: 'MainViewModelBase.value', context: context);

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$MainViewModelBaseActionController =
      ActionController(name: 'MainViewModelBase', context: context);

  @override
  void onChangePage(int newValue) {
    final _$actionInfo = _$MainViewModelBaseActionController.startAction(
        name: 'MainViewModelBase.onChangePage');
    try {
      return super.onChangePage(newValue);
    } finally {
      _$MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectPage(int index) {
    final _$actionInfo = _$MainViewModelBaseActionController.startAction(
        name: 'MainViewModelBase.onSelectPage');
    try {
      return super.onSelectPage(index);
    } finally {
      _$MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
addressSelect: ${addressSelect},
value: ${value}
    ''';
  }
}

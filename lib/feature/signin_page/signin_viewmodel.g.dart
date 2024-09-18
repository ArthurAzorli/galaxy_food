// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignInViewModel on SignInViewModelBase, Store {
  late final _$seePasswordAtom =
      Atom(name: 'SignInViewModelBase.seePassword', context: context);

  @override
  bool get seePassword {
    _$seePasswordAtom.reportRead();
    return super.seePassword;
  }

  @override
  set seePassword(bool value) {
    _$seePasswordAtom.reportWrite(value, super.seePassword, () {
      super.seePassword = value;
    });
  }

  late final _$emailFocusAtom =
      Atom(name: 'SignInViewModelBase.emailFocus', context: context);

  @override
  FocusNode get emailFocus {
    _$emailFocusAtom.reportRead();
    return super.emailFocus;
  }

  @override
  set emailFocus(FocusNode value) {
    _$emailFocusAtom.reportWrite(value, super.emailFocus, () {
      super.emailFocus = value;
    });
  }

  late final _$emailEditingControllerAtom = Atom(
      name: 'SignInViewModelBase.emailEditingController', context: context);

  @override
  TextEditingController get emailEditingController {
    _$emailEditingControllerAtom.reportRead();
    return super.emailEditingController;
  }

  @override
  set emailEditingController(TextEditingController value) {
    _$emailEditingControllerAtom
        .reportWrite(value, super.emailEditingController, () {
      super.emailEditingController = value;
    });
  }

  late final _$passwordFocusAtom =
      Atom(name: 'SignInViewModelBase.passwordFocus', context: context);

  @override
  FocusNode get passwordFocus {
    _$passwordFocusAtom.reportRead();
    return super.passwordFocus;
  }

  @override
  set passwordFocus(FocusNode value) {
    _$passwordFocusAtom.reportWrite(value, super.passwordFocus, () {
      super.passwordFocus = value;
    });
  }

  late final _$passwordEditingControllerAtom = Atom(
      name: 'SignInViewModelBase.passwordEditingController', context: context);

  @override
  TextEditingController get passwordEditingController {
    _$passwordEditingControllerAtom.reportRead();
    return super.passwordEditingController;
  }

  @override
  set passwordEditingController(TextEditingController value) {
    _$passwordEditingControllerAtom
        .reportWrite(value, super.passwordEditingController, () {
      super.passwordEditingController = value;
    });
  }

  late final _$submitAsyncAction =
      AsyncAction('SignInViewModelBase.submit', context: context);

  @override
  Future<void> submit(BuildContext context) {
    return _$submitAsyncAction.run(() => super.submit(context));
  }

  late final _$SignInViewModelBaseActionController =
      ActionController(name: 'SignInViewModelBase', context: context);

  @override
  void changeVisibilityPassword() {
    final _$actionInfo = _$SignInViewModelBaseActionController.startAction(
        name: 'SignInViewModelBase.changeVisibilityPassword');
    try {
      return super.changeVisibilityPassword();
    } finally {
      _$SignInViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? emailValidator(String? email) {
    final _$actionInfo = _$SignInViewModelBaseActionController.startAction(
        name: 'SignInViewModelBase.emailValidator');
    try {
      return super.emailValidator(email);
    } finally {
      _$SignInViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? passwordValidator(String? password) {
    final _$actionInfo = _$SignInViewModelBaseActionController.startAction(
        name: 'SignInViewModelBase.passwordValidator');
    try {
      return super.passwordValidator(password);
    } finally {
      _$SignInViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void signup(BuildContext context) {
    final _$actionInfo = _$SignInViewModelBaseActionController.startAction(
        name: 'SignInViewModelBase.signup');
    try {
      return super.signup(context);
    } finally {
      _$SignInViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
seePassword: ${seePassword},
emailFocus: ${emailFocus},
emailEditingController: ${emailEditingController},
passwordFocus: ${passwordFocus},
passwordEditingController: ${passwordEditingController}
    ''';
  }
}

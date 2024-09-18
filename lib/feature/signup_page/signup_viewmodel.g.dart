// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpViewModel on SignUpViewModelBase, Store {
  late final _$seePasswordAtom =
      Atom(name: 'SignUpViewModelBase.seePassword', context: context);

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

  late final _$cpfFocusAtom =
      Atom(name: 'SignUpViewModelBase.cpfFocus', context: context);

  @override
  FocusNode get cpfFocus {
    _$cpfFocusAtom.reportRead();
    return super.cpfFocus;
  }

  @override
  set cpfFocus(FocusNode value) {
    _$cpfFocusAtom.reportWrite(value, super.cpfFocus, () {
      super.cpfFocus = value;
    });
  }

  late final _$cpfEditingControllerAtom =
      Atom(name: 'SignUpViewModelBase.cpfEditingController', context: context);

  @override
  TextEditingController get cpfEditingController {
    _$cpfEditingControllerAtom.reportRead();
    return super.cpfEditingController;
  }

  @override
  set cpfEditingController(TextEditingController value) {
    _$cpfEditingControllerAtom.reportWrite(value, super.cpfEditingController,
        () {
      super.cpfEditingController = value;
    });
  }

  late final _$nameFocusAtom =
      Atom(name: 'SignUpViewModelBase.nameFocus', context: context);

  @override
  FocusNode get nameFocus {
    _$nameFocusAtom.reportRead();
    return super.nameFocus;
  }

  @override
  set nameFocus(FocusNode value) {
    _$nameFocusAtom.reportWrite(value, super.nameFocus, () {
      super.nameFocus = value;
    });
  }

  late final _$nameEditingControllerAtom =
      Atom(name: 'SignUpViewModelBase.nameEditingController', context: context);

  @override
  TextEditingController get nameEditingController {
    _$nameEditingControllerAtom.reportRead();
    return super.nameEditingController;
  }

  @override
  set nameEditingController(TextEditingController value) {
    _$nameEditingControllerAtom.reportWrite(value, super.nameEditingController,
        () {
      super.nameEditingController = value;
    });
  }

  late final _$emailFocusAtom =
      Atom(name: 'SignUpViewModelBase.emailFocus', context: context);

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
      name: 'SignUpViewModelBase.emailEditingController', context: context);

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

  late final _$birthDateFocusAtom =
      Atom(name: 'SignUpViewModelBase.birthDateFocus', context: context);

  @override
  FocusNode get birthDateFocus {
    _$birthDateFocusAtom.reportRead();
    return super.birthDateFocus;
  }

  @override
  set birthDateFocus(FocusNode value) {
    _$birthDateFocusAtom.reportWrite(value, super.birthDateFocus, () {
      super.birthDateFocus = value;
    });
  }

  late final _$birthDateEditingControllerAtom = Atom(
      name: 'SignUpViewModelBase.birthDateEditingController', context: context);

  @override
  TextEditingController get birthDateEditingController {
    _$birthDateEditingControllerAtom.reportRead();
    return super.birthDateEditingController;
  }

  @override
  set birthDateEditingController(TextEditingController value) {
    _$birthDateEditingControllerAtom
        .reportWrite(value, super.birthDateEditingController, () {
      super.birthDateEditingController = value;
    });
  }

  late final _$passwordFocusAtom =
      Atom(name: 'SignUpViewModelBase.passwordFocus', context: context);

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
      name: 'SignUpViewModelBase.passwordEditingController', context: context);

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
      AsyncAction('SignUpViewModelBase.submit', context: context);

  @override
  Future<void> submit(BuildContext context) {
    return _$submitAsyncAction.run(() => super.submit(context));
  }

  late final _$SignUpViewModelBaseActionController =
      ActionController(name: 'SignUpViewModelBase', context: context);

  @override
  void changeVisibilityPassword() {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.changeVisibilityPassword');
    try {
      return super.changeVisibilityPassword();
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? cpfValidator(String? cpf) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.cpfValidator');
    try {
      return super.cpfValidator(cpf);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? nameValidator(String? name) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.nameValidator');
    try {
      return super.nameValidator(name);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? emailValidator(String? email) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.emailValidator');
    try {
      return super.emailValidator(email);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? birthDateValidator(String? date) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.birthDateValidator');
    try {
      return super.birthDateValidator(date);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? passwordValidator(String? password) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.passwordValidator');
    try {
      return super.passwordValidator(password);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void signin(BuildContext context) {
    final _$actionInfo = _$SignUpViewModelBaseActionController.startAction(
        name: 'SignUpViewModelBase.signin');
    try {
      return super.signin(context);
    } finally {
      _$SignUpViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
seePassword: ${seePassword},
cpfFocus: ${cpfFocus},
cpfEditingController: ${cpfEditingController},
nameFocus: ${nameFocus},
nameEditingController: ${nameEditingController},
emailFocus: ${emailFocus},
emailEditingController: ${emailEditingController},
birthDateFocus: ${birthDateFocus},
birthDateEditingController: ${birthDateEditingController},
passwordFocus: ${passwordFocus},
passwordEditingController: ${passwordEditingController}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_user_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditUserViewModel on EditUserViewModelBase, Store {
  late final _$userImageAtom =
      Atom(name: 'EditUserViewModelBase.userImage', context: context);

  @override
  ImageProvider<Object>? get userImage {
    _$userImageAtom.reportRead();
    return super.userImage;
  }

  @override
  set userImage(ImageProvider<Object>? value) {
    _$userImageAtom.reportWrite(value, super.userImage, () {
      super.userImage = value;
    });
  }

  late final _$nameFocusAtom =
      Atom(name: 'EditUserViewModelBase.nameFocus', context: context);

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

  late final _$nameEditingControllerAtom = Atom(
      name: 'EditUserViewModelBase.nameEditingController', context: context);

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
      Atom(name: 'EditUserViewModelBase.emailFocus', context: context);

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
      name: 'EditUserViewModelBase.emailEditingController', context: context);

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

  late final _$changeImageAsyncAction =
      AsyncAction('EditUserViewModelBase.changeImage', context: context);

  @override
  Future changeImage(ImagePickerSource source) {
    return _$changeImageAsyncAction.run(() => super.changeImage(source));
  }

  late final _$updateAsyncAction =
      AsyncAction('EditUserViewModelBase.update', context: context);

  @override
  Future update(BuildContext context) {
    return _$updateAsyncAction.run(() => super.update(context));
  }

  late final _$EditUserViewModelBaseActionController =
      ActionController(name: 'EditUserViewModelBase', context: context);

  @override
  String? nameValidator(String? name) {
    final _$actionInfo = _$EditUserViewModelBaseActionController.startAction(
        name: 'EditUserViewModelBase.nameValidator');
    try {
      return super.nameValidator(name);
    } finally {
      _$EditUserViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? emailValidator(String? email) {
    final _$actionInfo = _$EditUserViewModelBaseActionController.startAction(
        name: 'EditUserViewModelBase.emailValidator');
    try {
      return super.emailValidator(email);
    } finally {
      _$EditUserViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic cancel(BuildContext context) {
    final _$actionInfo = _$EditUserViewModelBaseActionController.startAction(
        name: 'EditUserViewModelBase.cancel');
    try {
      return super.cancel(context);
    } finally {
      _$EditUserViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userImage: ${userImage},
nameFocus: ${nameFocus},
nameEditingController: ${nameEditingController},
emailFocus: ${emailFocus},
emailEditingController: ${emailEditingController}
    ''';
  }
}

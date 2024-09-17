import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

part 'signin_viewmodel.g.dart';

class SignInViewModel = SignInViewModelBase with _$SignInViewModel;

abstract class SignInViewModelBase with Store{

  final formKey = GlobalKey<FormState>();

  @observable
  var seePassword = false;

  @observable
  var emailFocus = FocusNode();

  @observable
  var emailEditingController = TextEditingController();

  @observable
  var passwordFocus = FocusNode();

  @observable
  var passwordEditingController = TextEditingController();

  @action
  void changeVisibilityPassword(){
    seePassword = !seePassword;
  }

  @action
  String? emailValidator(String? email){
    if (email == null || email.isEmpty) return 'Campo do E-mail vazio!';
    return null;
  }

  @action
  String? passwordValidator(String? password){
    if (password == null || password.isEmpty) return 'Campo da Senha vazio!';
    if (password.length < 8) return 'A senha deve ter, ao menos, 8 digitos!';
    return null;
  }

  @action
  void submit(BuildContext context){
    if (formKey.currentState!.validate()) {
      //TODO login no springboot
      context.go("/");
    }
  }

  @action
  void signup(BuildContext context){
    context.go("/signup");
  }
}
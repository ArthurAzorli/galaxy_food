import 'package:flutter/material.dart';
import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/utils/exception/repository_exception.dart';
import '../../core/widgets/galaxy_button.dart';

part 'signin_viewmodel.g.dart';

class SignInViewModel = SignInViewModelBase with _$SignInViewModel;

abstract class SignInViewModelBase with Store{

  final formKey = GlobalKey<FormState>();

  @observable
  var seePassword = false;

  @observable
  var emailFocus = FocusNode();

  @observable
  var emailEditingController = TextEditingController()..text="arthur.azorli@aluno.ifsp.edu.br";

  @observable
  var passwordFocus = FocusNode();

  @observable
  var passwordEditingController = TextEditingController()..text="12345678";

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
  Future<void> submit(BuildContext context) async{
    if (formKey.currentState!.validate()) {

      final email = emailEditingController.text;
      final password = passwordEditingController.text;

      try{
        await ClientRepositoryService.login(user: email, password: password);
        context.go("/");

      } on RepositoryException catch(e) {

        showDialog(
            context: context,
            builder: (context){
              final theme = Theme.of(context);
              return AlertDialog(

                icon: Icon(Icons.warning_amber_rounded, color: theme.colorScheme.secondary, size: 65),
                title: Text("Erro ao Fazer Log in!", style: theme.textTheme.titleLarge),
                content: Text(e.message, style: theme.textTheme.bodyLarge, textAlign: TextAlign.center,),
                actions: [
                  Center(
                    child: GalaxyButton(
                        style: const ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(200, 50))
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("FECHAR")
                    ),
                  )
                ],
              );
            }
        );

      }
    }
  }

  @action
  void signup(BuildContext context){
    context.go("/signup");
  }
}
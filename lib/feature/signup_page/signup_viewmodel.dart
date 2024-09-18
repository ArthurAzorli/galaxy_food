import 'package:flutter/material.dart';
import 'package:galaxy_food/core/domain/client.dart';
import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:galaxy_food/core/utils/exception/repository_exception.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:brasil_fields/brasil_fields.dart';

part 'signup_viewmodel.g.dart';

class SignUpViewModel = SignUpViewModelBase with _$SignUpViewModel;

abstract class SignUpViewModelBase with Store{

  final formKey = GlobalKey<FormState>();

  @observable
  var seePassword = false;

  @observable
  var cpfFocus = FocusNode();

  @observable
  var cpfEditingController = TextEditingController();

  @observable
  var nameFocus = FocusNode();

  @observable
  var nameEditingController = TextEditingController();

  @observable
  var emailFocus = FocusNode();

  @observable
  var emailEditingController = TextEditingController();

  @observable
  var birthDateFocus = FocusNode();

  @observable
  var birthDateEditingController = TextEditingController();

  @observable
  var passwordFocus = FocusNode();

  @observable
  var passwordEditingController = TextEditingController();

  @action
  void changeVisibilityPassword(){
    seePassword = !seePassword;
  }

  @action
  String? cpfValidator(String? cpf){
    if (cpf == null || cpf.isEmpty) return 'Campo do CPF vazio!';
    if (!UtilBrasilFields.isCPFValido(cpf)) return 'Campo do CPF inválido!';
    return null;
  }

  @action
  String? nameValidator(String? name){
    if (name == null || name.isEmpty) return 'Campo do Nome vazio!';
    return null;
  }

  @action
  String? emailValidator(String? email){
    if (email == null || email.isEmpty) return 'Campo do E-mail vazio!';
    return null;
  }
  @action
  String? birthDateValidator(String? date){
    if (date == null || date.isEmpty) return 'Campo da Data de Nascimento vazio!';
    var dateTime = UtilData.obterDateTime(date);
    if (!UtilData.validarData(date) ||
        dateTime.isAfter(DateTime.now()) ||
        dateTime.isBefore(DateTime(1900))
    ) return 'Data inválida!';
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

      final cpf = UtilBrasilFields.obterCpf(cpfEditingController.text);
      final name = nameEditingController.text;
      final email = emailEditingController.text;
      final date = UtilData.obterDateTime(birthDateEditingController.text);
      final password = passwordEditingController.text;

      final clientRequest = Client(cpf: cpf, name: name, email: email, birthDate: date) ..password = password;

      try{
        await ClientRepositoryService.create(clientRequest);
        context.go("/");

      } on RepositoryException catch(e) {

        showDialog(
          context: context,
          builder: (context){
            final theme = Theme.of(context);
            return AlertDialog(

              icon: Icon(Icons.warning_amber_rounded, color: theme.colorScheme.secondary, size: 65),
              title: Text("Erro ao Fazer Cadastro!", style: theme.textTheme.titleLarge),
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
  void signin(BuildContext context){
    context.go("/signin");
  }
}
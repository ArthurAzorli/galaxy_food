import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/service/repository/client_repository_service.dart';
import 'package:galaxy_food/core/utils/exception/repository_exception.dart';
import 'package:galaxy_food/core/utils/route/go_route.dart';
import 'package:galaxy_food/feature/main_page/main_viewmodel.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/domain/address.dart';
import '../../core/domain/client.dart';
import '../../core/domain/phone.dart';
import '../../core/widgets/galaxy_button.dart';

part 'user_viewmodel.g.dart';

class UserViewModel = UserViewModelBase with _$UserViewModel;

abstract class UserViewModelBase with Store {

  UserViewModelBase(BuildContext context){
    _getClient(context);
  }

  @observable
  Client? client;

  @observable
  GlobalKey<FormState> formKey = GlobalKey();

  @observable
  var cepFocus = FocusNode();

  @observable
  var cepEditingController = TextEditingController();

  @observable
  var streetFocus = FocusNode();

  @observable
  var streetEditingController = TextEditingController();

  @observable
  var numberFocus = FocusNode();

  @observable
  var numberEditingController = TextEditingController();

  @observable
  var neighborhoodFocus = FocusNode();

  @observable
  var neighborhoodEditingController = TextEditingController();

  @observable
  var cityFocus = FocusNode();

  @observable
  var cityEditingController = TextEditingController();

  @observable
  String? selectState;

  @observable
  var oldPasswordFocus = FocusNode();

  @observable
  var oldPasswordEditingController = TextEditingController();

  @observable
  var newPasswordFocus = FocusNode();

  @observable
  var newPasswordEditingController = TextEditingController();

  @observable
  var emailFocus = FocusNode();

  @observable
  var emailEditingController = TextEditingController();

  @observable
  var passwordFocus = FocusNode();

  @observable
  var passwordEditingController = TextEditingController();

  @observable
  var phoneFocus = FocusNode();

  @observable
  var phoneEditingController = TextEditingController();

  @observable
  Address? addressSelected;

  @observable

  @action
  Address? getAddressSelected(){
    final prefs = GetIt.I.get<SharedPreferencesWithCache>();
    String? id = prefs.getString("address");
    if (id == null) return null;
    if (client == null || client!.addresses.isEmpty) return null;

    for (var i = 0; i < client!.addresses.length; i++){
      if (client!.addresses[i].id == id) {
        return client!.addresses[i];
      }
    }

    return null;
  }

  @action
  selectAddress(Address address){
    addressSelected = address;
    GetIt.I.get<SharedPreferencesWithCache>().setString("address", address.id!);
  }

  @action
  addNewAddress(BuildContext context){
    final theme = Theme.of(context);

    final textFieldBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1
      ),
    );

    final textFieldFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1.5
      ),
    );

    final textFieldErrorBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5
        )
    );

    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text("ADICIONAR ENDEREÇO", style: theme.textTheme.titleLarge,),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: cepFocus,
                          controller: cepEditingController,
                          validator: cepValidator,
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodyLarge,
                            labelText: "CEP",
                            border: textFieldBorder,
                            errorBorder: textFieldErrorBorder,
                            focusedBorder: textFieldFocusedBorder,
                            errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CepInputFormatter(ponto: false),
                          ],
                          onTapOutside: (_) => cepFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: streetFocus,
                          controller: streetEditingController,
                          validator: streetValidator,
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodyLarge,
                            labelText: "Rua/Avenida",
                            border: textFieldBorder,
                            errorBorder: textFieldErrorBorder,
                            focusedBorder: textFieldFocusedBorder,
                            errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => streetFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: numberFocus,
                          controller: numberEditingController,
                          validator: numberValidator,
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodyLarge,
                            labelText: "Número",
                            border: textFieldBorder,
                            errorBorder: textFieldErrorBorder,
                            focusedBorder: textFieldFocusedBorder,
                            errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => numberFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: neighborhoodFocus,
                          controller: neighborhoodEditingController,
                          validator: neighborhoodValidator,
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodyLarge,
                            labelText: "Bairro",
                            border: textFieldBorder,
                            errorBorder: textFieldErrorBorder,
                            focusedBorder: textFieldFocusedBorder,
                            errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => neighborhoodFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: cityFocus,
                          controller: cityEditingController,
                          validator: cityValidator,
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodyLarge,
                            labelText: "Cidade",
                            border: textFieldBorder,
                            errorBorder: textFieldErrorBorder,
                            focusedBorder: textFieldFocusedBorder,
                            errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => cityFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: Observer(
                          builder: (context) {
                            return DropdownButton(
                              borderRadius:  const BorderRadius.all(Radius.circular(5)),
                              style: theme.textTheme.bodyLarge,
                              value: selectState,
                              iconSize: 40,
                              items: List.generate(
                                Estados.listaEstados.length,
                                (index) => DropdownMenuItem(
                                  value: Estados.listaEstadosSigla[index],
                                  child: Text(Estados.listaEstados[index],)
                                ),
                              ),
                              onChanged: (value) => selectState = value,
                              menuWidth: 225,
                            );
                          }
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: GalaxyButton(
                          style: const ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate() && selectState != null){
                              try{
                                final address = Address(
                                    street: streetEditingController.text,
                                    number: numberEditingController.text,
                                    neighborhood: neighborhoodEditingController.text,
                                    city: cityEditingController.text,
                                    state: selectState!,
                                    cep: cepEditingController.text
                                );

                                streetEditingController.text = "";
                                numberEditingController.text = "";
                                neighborhoodEditingController.text = "";
                                cityEditingController.text = "";
                                cepEditingController.text = "";

                                client = await ClientRepositoryService.addAddress(address);
                                Navigator.pop(context);

                                selectState = "";

                              } on RepositoryException catch(e){
                                e.showMessageDialog(context, () => Navigator.pop(context));
                              }
                            }
                          },
                          child: const Text("ADICIONAR"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  @action
  Future<bool> removeAddress(BuildContext context, Address address) async{
    try{
      client = await ClientRepositoryService.remAddress(address.id!);
      return true;
    } on RepositoryException catch(e){
      e.showMessageDialog(context, ()=>Navigator.pop(context));
      return false;
    }
  }

  @action
  addNewPhone(BuildContext context){
    final theme = Theme.of(context);

    final textFieldBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1
      ),
    );

    final textFieldFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1.5
      ),
    );

    final textFieldErrorBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5
        )
    );

    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text("ADICIONAR TELEFONE", style: theme.textTheme.titleLarge,),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: phoneFocus,
                          controller: phoneEditingController,
                          validator: phoneValidator,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter()
                          ],
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodyLarge,
                            labelText: "Número de Telefone",
                            border: textFieldBorder,
                            errorBorder: textFieldErrorBorder,
                            focusedBorder: textFieldFocusedBorder,
                            errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => phoneFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: GalaxyButton(
                          style: const ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()){
                              try{
                                final phone = Phone(phone: phoneEditingController.text);

                                phoneEditingController.text = "";

                                client = await ClientRepositoryService.addPhone(phone);
                                Navigator.pop(context);

                              } on RepositoryException catch(e){
                                e.showMessageDialog(context, () => Navigator.pop(context));
                              }
                            }
                          },
                          child: const Text("ADICIONAR"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  @action
  Future<bool> removePhone(BuildContext context, Phone phone) async{
    try{
      client = await ClientRepositoryService.remPhone(phone.id!);
      return true;
    } on RepositoryException catch(e){
      e.showMessageDialog(context, ()=>Navigator.pop(context));
      return false;
    }
  }

  @action
  String? cepValidator(String? text){
    if (text == null || text.isEmpty) return "Campo da CEP vazio!";
    return null;
  }

  @action
  String? streetValidator(String? text){
    if (text == null || text.isEmpty) return "Campo da Rua/Avenida vazio!";
    return null;
  }

  @action
  String? numberValidator(String? text){
    if (text == null || text.isEmpty) return "Campo do Número vazio!";
    return null;
  }

  @action
  String? neighborhoodValidator(String? text){
    if (text == null || text.isEmpty) return "Campo do Bairro vazio!";
    return null;
  }

  @action
  String? cityValidator(String? text){
    if (text == null || text.isEmpty) return "Campo da Cidade vazio!";
    return null;
  }

  void _getClient(BuildContext context) async {
    try {
      client = await ClientRepositoryService.getUser();
      addressSelected = getAddressSelected();
    } on RepositoryException catch (e) {
      e.showMessageDialog(context, () => Navigator.of(context).pop());
    }
  }

  @action
  String? passwordValidator(String? password){
    if (password == null || password.isEmpty) return 'Campo da Senha vazio!';
    if (password.length < 8) return 'A senha deve ter, ao menos, 8 digitos!';
    return null;
  }

  @action
  String? emailValidator(String? email){
    if (email == null || email.isEmpty) return 'Campo do E-mail vazio!';
    return null;
  }

  @action
  String? phoneValidator(String? text){
    if (text == null || text.isEmpty) return "Campo do Número vazio!";
    return null;
  }

  @action
  editClient(BuildContext context){
    context.go("/edit");
  }

  @action
  changePassword(BuildContext context){
    final theme = Theme.of(context);

    final textFieldBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1
      ),
    );

    final textFieldFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1.5
      ),
    );

    final textFieldErrorBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5
        )
    );

    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text("ALTERAR SENHA", style: theme.textTheme.titleLarge,),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: oldPasswordFocus,
                          controller: oldPasswordEditingController,
                          obscureText: true,
                          validator: passwordValidator,
                          decoration: InputDecoration(
                              labelStyle: theme.textTheme.bodyLarge,
                              labelText: "Senha Atual",
                              border: textFieldBorder,
                              errorBorder: textFieldErrorBorder,
                              focusedBorder: textFieldFocusedBorder,
                              errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => oldPasswordFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: newPasswordFocus,
                          controller: newPasswordEditingController,
                          obscureText: true,
                          validator: passwordValidator,
                          decoration: InputDecoration(
                              labelStyle: theme.textTheme.bodyLarge,
                              labelText: "Senha Nova",
                              border: textFieldBorder,
                              errorBorder: textFieldErrorBorder,
                              focusedBorder: textFieldFocusedBorder,
                              errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => newPasswordFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: GalaxyButton(
                          style: const ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()){
                              try{

                                bool result = await ClientRepositoryService.changePassword(
                                  oldPassword: oldPasswordEditingController.text,
                                  newPassword: newPasswordEditingController.text,
                                );

                                if (result) {
                                  oldPasswordEditingController.text = "";
                                  newPasswordEditingController.text = "";
                                  Navigator.pop(context);
                                }

                              } on RepositoryException catch(e){
                                e.showMessageDialog(context, () => Navigator.pop(context));
                              }
                            }
                          },
                          child: const Text("SALVAR"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  @action
  deleteUser(BuildContext context){
    final theme = Theme.of(context);

    final textFieldBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1
      ),
    );

    final textFieldFocusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(
          color: theme.colorScheme.secondary,
          width: 1.5
      ),
    );

    final textFieldErrorBorder = UnderlineInputBorder(
        borderSide: BorderSide(
            color: theme.colorScheme.error,
            width: 1.5
        )
    );

    showDialog(
        context: context,
        builder: (context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Text("CONFIRMAÇÃO", style: theme.textTheme.titleLarge,),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 5),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: emailFocus,
                          controller: emailEditingController,
                          keyboardType: TextInputType.emailAddress,
                          validator: emailValidator,
                          decoration: InputDecoration(
                            labelStyle: theme.textTheme.bodyLarge,
                            labelText: "E-mail",
                            border: textFieldBorder,
                            errorBorder: textFieldErrorBorder,
                            focusedBorder: textFieldFocusedBorder,
                            errorStyle: TextStyle(color: theme.colorScheme.onError),
                          ),
                          onTapOutside: (_) => emailFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          cursorColor: theme.colorScheme.secondary,
                          cursorErrorColor: theme.colorScheme.secondary,
                          focusNode: passwordFocus,
                          controller: passwordEditingController,
                          obscureText: true,
                          validator: passwordValidator,
                          decoration: InputDecoration(
                              labelStyle: theme.textTheme.bodyLarge,
                              labelText: "Senha",
                              border: textFieldBorder,
                              errorBorder: textFieldErrorBorder,
                              focusedBorder: textFieldFocusedBorder,
                              errorStyle: TextStyle(color: theme.colorScheme.onError),

                          ),
                          onTapOutside: (_) => passwordFocus.unfocus(),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 10),
                        child: GalaxyButton(
                          style: const ButtonStyle(
                            fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                          ),
                          onPressed: () async {
                            if (formKey.currentState!.validate()){
                              try{

                                bool result = await ClientRepositoryService.delete(
                                  user: emailEditingController.text,
                                  password: passwordEditingController.text
                                );

                                if (result) {
                                  GetIt.I.get<SharedPreferencesWithCache>().clear();
                                  emailEditingController.text = "";
                                  passwordEditingController.text = "";
                                  GetIt.I.get<MainViewModel>().pageController.animateToPage(
                                      0,
                                      duration: kThemeChangeDuration,
                                      curve: Curves.linear
                                  );
                                  context.go("/signin");
                                }

                              } on RepositoryException catch(e){
                                e.showMessageDialog(context, () => Navigator.pop(context));
                              }
                            }
                          },
                          child: const Text("DELETAR"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  @action
  logout(BuildContext context){
    GetIt.I.get<SharedPreferencesWithCache>().clear();
    GetIt.I.get<MainViewModel>().pageController.animateToPage(
        0,
        duration: kThemeChangeDuration,
        curve: Curves.linear
    );
    context.go("/signin");
  }

}
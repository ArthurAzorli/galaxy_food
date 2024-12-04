import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/domain/address.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:galaxy_food/feature/user_page/user_viewmodel.dart';

import '../../core/domain/phone.dart';

class UserPage extends StatefulWidget{
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageState();

}

class _UserPageState extends State<UserPage>{

  late final UserViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = UserViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final configButtonStyle = ButtonStyle(
      side: const WidgetStatePropertyAll(BorderSide.none),
      fixedSize: const WidgetStatePropertyAll(Size(double.maxFinite, 70)),
      backgroundColor: WidgetStatePropertyAll(theme.colorScheme.onSurface),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            SizedBox(
              height: 295,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
        
                  Container(
                    height: 220,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withAlpha(130),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(800, 200))
                    ),
                    child: Container(
                      width: double.maxFinite,
                      height: 200,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(800, 200))
                      ),
                      child: Center(
                        child: Text("Bem-Vindo!", style: theme.textTheme.displaySmall,),
                      )
                    ),
                  ),
        
                  Positioned(
                    left: MediaQuery.of(context).size.width/2 - 75,
                    top: 140,
                    child: Column(
                      children: [
        
                        Observer(
                          builder: (context) {

                            ImageProvider image =
                            viewModel.client != null && viewModel.client!.image != null && viewModel.client!.image!.isNotEmpty
                                ? Image.memory(viewModel.client!.image!.toUint8List).image
                                : Image.asset("lib/images/user_default.png").image;

                            return Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.onSurface,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: image,
                                      fit: BoxFit.cover
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurStyle: BlurStyle.outer,
                                        blurRadius: 15
                                    )
                                  ]
                              ),
                            );
                          }
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),

            Observer(
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 15),
                    child: Center(
                      child: Text(
                        viewModel.client == null? "USER NAME" : viewModel.client!.name,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                  );
                }
            ),
        
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
              child: Column(
                children: [
                  
                  Row(
                    children: [
                      Icon(Icons.location_pin, color: theme.colorScheme.secondary, size: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Endereços", style: theme.textTheme.titleMedium),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Divider(color: theme.colorScheme.inverseSurface),
                  ),

                  Observer(
                    builder: (context) {
                      return Container(
                        height: 300,
                        margin: const EdgeInsets.only(top: 30, bottom: 15),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: theme.colorScheme.onSurface,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child:
                        viewModel.client == null || viewModel.client!.addresses.isEmpty
                          ? Center(
                              child: Text(
                                "NENHUM ENDEREÇO CADASTRADO!",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleLarge?.merge(
                                  TextStyle(color: theme.colorScheme.inverseSurface)
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: viewModel.client!.addresses.length,
                              itemBuilder: (context, index){
                                final address = viewModel.client!.addresses[index];
                                return _buildAddressItem(context, address, index);
                              },
                            ),
                          );
                    }
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 45),
                    child: GalaxyButton(
                        onPressed: () => viewModel.addNewAddress(context),
                        style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                        ),
                        child: Text("ADICIONAR", style: theme.textTheme.titleMedium,)
                    ),
                  ),

                  Row(
                    children: [
                      Icon(Icons.phone, color: theme.colorScheme.secondary, size: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Telefones", style: theme.textTheme.titleMedium),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Divider(color: theme.colorScheme.inverseSurface),
                  ),

                  Observer(
                      builder: (context) {
                        return Container(
                          height: 300,
                          margin: const EdgeInsets.only(top: 30, bottom: 15),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: viewModel.client == null || viewModel.client!.phones.isEmpty
                            ? Center(
                              child: Text(
                                "NENHUM TELEFONE CADASTRADO!",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleLarge?.merge(
                                    TextStyle(color: theme.colorScheme.inverseSurface)
                                ),
                              ),
                            )
                            : ListView.builder(
                                itemCount: viewModel.client!.phones.length,
                                itemBuilder: (context, index){
                                  final phone = viewModel.client!.phones[index];
                                  return _buildPhoneItem(context, phone, index);
                                },
                            ),
                        );
                      }
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 45),
                    child: GalaxyButton(
                        onPressed: () => viewModel.addNewPhone(context),
                        style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 60)),
                        ),
                        child: Text("ADICIONAR", style: theme.textTheme.titleMedium,)
                    ),
                  ),
        
                  Row(
                    children: [
                      Icon(Icons.settings, color: theme.colorScheme.secondary, size: 25,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("Configurações", style: theme.textTheme.titleMedium),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Divider(color: theme.colorScheme.inverseSurface),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GalaxyButton(
                        onPressed: () => viewModel.editClient(context),
                        style: configButtonStyle,
                        icon: Icon(Icons.edit, color: theme.colorScheme.secondary),
                        child: Text("EDITAR PERFIL", style: theme.textTheme.titleMedium,)
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GalaxyButton(
                        onPressed: () => viewModel.changePassword(context),
                        style: configButtonStyle,
                        icon: Icon(Icons.edit, color: theme.colorScheme.secondary),
                        child: Text("ALTERAR SENHA", style: theme.textTheme.titleMedium,)
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GalaxyButton(
                        onPressed: () => viewModel.logout(context),
                        style: configButtonStyle,
                        icon: Icon(Icons.logout, color: theme.colorScheme.secondary),
                        child: Text("SAIR DA CONTA", style: theme.textTheme.titleMedium,)
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 50),
                    child: GalaxyButton(
                        onPressed: () => viewModel.deleteUser(context),
                        style: configButtonStyle,
                        icon: Icon(Icons.delete_rounded, color: theme.colorScheme.secondary),
                        child: Text("EXCLUIR PERFIL", style: theme.textTheme.titleMedium,)
                    ),
                  ),
                ],
              ),
            )
        
          ],
        ),
      ),
    );
  }

  _buildAddressItem(BuildContext context, Address address, int index){
    final theme = Theme.of(context);
    final key = GlobalKey();

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: theme.colorScheme.tertiaryContainer
      ),
      child: Dismissible(
        key: key,
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
              color: theme.colorScheme.onError,
              borderRadius: BorderRadius.circular(2)
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("DELETE", style: theme.textTheme.titleLarge,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Icon(Icons.delete, color: theme.colorScheme.secondary, size: 35,),
                ),
              ],
            ),
          ),
        ),
        child: ListTile(
          minTileHeight: 120,
          title: Text("${address.street}, ${address.neighborhood}, ${address.number}", style: theme.textTheme.bodyLarge,),
          subtitle: Text("${address.city} - ${address.state}, Brasil - ${address.cep}", style: theme.textTheme.labelMedium,),
          trailing: Transform.scale(
            scale: 1.25,
            child: Observer(
              builder: (context) {
                return Checkbox(
                  value: viewModel.addressSelected?.id == address.id,
                  onChanged: (value){
                    if (value??false) viewModel.selectAddress(address);
                  },
                  fillColor: WidgetStatePropertyAll(theme.colorScheme.surface),
                  checkColor: theme.colorScheme.inversePrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }
            ),
          ),
        ),
        confirmDismiss: (_) async {
          return viewModel.removeAddress(context, address);
        }
      ),
    );
  }

  _buildPhoneItem(BuildContext context, Phone phone, int index){
    final theme = Theme.of(context);
    final key = GlobalKey();

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: theme.colorScheme.tertiaryContainer
      ),
      child: Dismissible(
          key: key,
          direction: DismissDirection.endToStart,
          background: Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
                color: theme.colorScheme.onError,
                borderRadius: BorderRadius.circular(2)
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("DELETE", style: theme.textTheme.titleLarge,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(Icons.delete, color: theme.colorScheme.secondary, size: 35,),
                  ),
                ],
              ),
            ),
          ),
          child: ListTile(
            minTileHeight: 90,
            title: Text(phone.phone, style: theme.textTheme.titleMedium,),
          ),
          confirmDismiss: (_) async {
            return viewModel.removePhone(context, phone);
          }
      ),
    );
  }

}
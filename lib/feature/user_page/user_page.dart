

import 'package:flutter/material.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';

class UserPage extends StatefulWidget{
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageState();

}

class _UserPageState extends State<UserPage>{
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
              height: 320,
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
                    top: 150,
                    child: Column(
                      children: [
        
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: Image.network("https://clinicasrecuperacao.com/wp-content/uploads/2023/08/Quanto-Tempo-um-Usuario-de-Crack-Vive.jpg").image,
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
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("USER NAME", style: theme.textTheme.titleLarge,),
                        )
                      ],
                    ),
                  ),
        
        
                  Positioned(
                    top: 75,
                    left: 20,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.arrow_back, color: theme.colorScheme.secondary, size: 30,)
                    ),
                  )
                ],
              ),
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
        
                  Container(
                    height: 300,
                    margin: const EdgeInsets.only(top: 30, bottom: 15),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index){
                        final key = GlobalKey();
                        var check = true;

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
                                minTileHeight: 100,
                                onTap: () => setState(() => check = !check),
                                title: Text("Rua Avenida, Bairro Jardim, 675", style: theme.textTheme.bodyLarge,),
                                subtitle: Text("São Carlos - SP, Brasil - 13560-120", style: theme.textTheme.labelMedium,),
                                trailing: Transform.scale(
                                  scale: 1.25,
                                  child: Checkbox(
                                    value: check,
                                    onChanged: null,
                                    fillColor: WidgetStatePropertyAll(theme.colorScheme.surface),
                                    checkColor: theme.colorScheme.inversePrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              )
                          ),
                        );

                      },
                    ),
                  ),
        
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45),
                    child: GalaxyButton(
                        onPressed: (){},
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
                        onPressed: (){},
                        style: configButtonStyle,
                        icon: Icon(Icons.edit, color: theme.colorScheme.secondary),
                        child: Text("EDITAR PERFIL", style: theme.textTheme.titleMedium,)
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GalaxyButton(
                        onPressed: (){},
                        style: configButtonStyle,
                        icon: Icon(Icons.edit, color: theme.colorScheme.secondary),
                        child: Text("ALTERAR SENHA", style: theme.textTheme.titleMedium,)
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 50),
                    child: GalaxyButton(
                        onPressed: (){},
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

}


import 'package:flutter/material.dart';

class UserPage extends StatefulWidget{
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageState();

}

class _UserPageState extends State<UserPage>{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
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
            padding: EdgeInsets.only(top: 45, left: 15, right: 15),
            child: Column(
              children: [
                
                Text("")
                
              ],
            ),
          )

        ],
      ),
    );
  }

}
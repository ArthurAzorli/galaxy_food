import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:galaxy_food/feature/food_item/food_item.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: theme.colorScheme.inverseSurface
                  )
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  opacity: 0.5,
                  image: Image.network("https://media.istockphoto.com/id/496389174/pt/foto/delicioso-hamb%C3%BArgueres.jpg?s=612x612&w=0&k=20&c=HuwJXFQqqFySswhJ2I-aknIOnrt55TplmJ4ZJ7oN4MQ=").image
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(1800, 200)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xa0000000),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 20
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Container(
                          height: 50,
                          width: 50,
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

                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 16),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_pin),
                                    Text("LOCAL")
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text("Olá, USERNAME", style: theme.textTheme.headlineSmall,  textAlign: TextAlign.start,)
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Text("O que deseja comer hoje?", style: theme.textTheme.titleMedium, textAlign: TextAlign.start,)
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: SizedBox(
                                height: 55,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      const SizedBox(
                                        width: 50,
                                        child: Center(
                                          child: Icon(Icons.search_rounded, size: 30),
                                        ),
                                      ),

                                      Expanded(
                                        child: TextFormField(
                                          style: theme.textTheme.titleMedium,
                                          decoration: InputDecoration(
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            labelStyle: theme.textTheme.titleMedium,
                                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(
                                              color: theme.colorScheme.primary,
                                              width: 1.5
                                            )),
                                            enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                                            labelText: "Search...",
                                            enabled: true,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: VerticalDivider(color: theme.colorScheme.secondary,),
                                      ),

                                      const SizedBox(
                                        width: 50,
                                        child: Center(
                                          child: Icon(Icons.filter_list_rounded, size: 30),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              )
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
            ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 20),
              child: Column(
                children: [

                  SizedBox(
                    width: double.infinity,
                    height: 220,
                    child: ListView.builder(
                      itemCount: 2,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      itemBuilder: (context, item){
                        return Padding(
                          padding: const EdgeInsets.all(7.5),
                          child: Container(
                            width: 350,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xa0000000),
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 6.5
                                ),
                              ]
                            ),
                            child: const Center(
                              child: Text("Anúncio"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.inverseSurface,
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            height: 5,
                            width: 50,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.inverseSurface,
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                        )

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 2.5),
                    child: Divider(color: theme.dividerColor,),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.maxFinite,
                    child: Text("CATEGORIAS", style: theme.textTheme.titleSmall,)
                  ),

                  SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: ListView.builder(
                      itemCount: 5,
                      padding:  const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 20),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.onSurface,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x5a000000),
                                      blurStyle: BlurStyle.outer,
                                      blurRadius: 10
                                    ),
                                  ]
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 10, top: 7.5),
                              child: SizedBox(
                                width: 100,
                                child: Text("Comida Japonesa", style: theme.textTheme.labelMedium, maxLines: 2, textAlign: TextAlign.center)
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2.5),
                    child: Divider(color: theme.dividerColor,),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.maxFinite,
                    child: Text("EXPLORAR RESTAURANTES", style: theme.textTheme.titleSmall,)
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0xaa000000),
                            blurStyle: BlurStyle.outer,
                            blurRadius: 16
                        ),
                      ]
                    ),
                    child: Container(
                      height: 305,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.5),
                        color: theme.colorScheme.primaryContainer,
                        image: DecorationImage(
                          image: Image.network("https://nabarradatijuca.com.br/wp-content/uploads/2023/07/Hamburgueria_Barra_da_Tijuca.jpg").image,
                          fit: BoxFit.cover,
                          opacity: 0.5
                        )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7.5),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 2, sigmaX: 2),
                          child: Column(
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  child: Text("RESTAURANT NAME", style: theme.textTheme.headlineSmall, textAlign: TextAlign.left,)
                                ),
                              ),

                              SizedBox(
                                height: 250,
                                width: double.infinity,
                                child: ListView.builder(
                                  itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  itemBuilder: (context, index){
                                    return const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: FoodItem(size: FoodItemSize.medium)
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
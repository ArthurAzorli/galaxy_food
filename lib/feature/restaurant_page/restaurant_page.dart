import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:galaxy_food/core/domain/food.dart';
import 'package:galaxy_food/core/domain/restaurant.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:galaxy_food/feature/food_item/food_item.dart';
import 'package:go_router/go_router.dart';
import 'package:rate/rate.dart';

class RestaurantPage extends StatefulWidget{

  const RestaurantPage({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantPageState();
}

class RestaurantPageState extends State<RestaurantPage>{

  //TODO:: remover depois
  final foodTest = Food(id: "", name: "", price: 0, description: "", parent: "");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = GoRouterState.of(context).extra as Restaurant;
    final theme = Theme.of(context);
    var show = false;

    return Scaffold(
      body: Stack(
        children: [

          Padding(
            padding: show? const EdgeInsets.only(bottom: 295) : EdgeInsets.zero,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
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
                          image: Image.network("https://nabarradatijuca.com.br/wp-content/uploads/2023/07/Hamburgueria_Barra_da_Tijuca.jpg").image
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

                              IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.arrow_back, color: theme.colorScheme.secondary, size: 30,)
                              ),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
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
                            padding: const EdgeInsets.only(top: 75),
                            child: SizedBox(
                                width: double.maxFinite,
                                child: Text("RESTAURANT NAME", style: theme.textTheme.headlineSmall,  textAlign: TextAlign.start,)
                            ),
                          ),

                          SizedBox(
                            width: double.maxFinite,
                            child: Text("Speciality", style: theme.textTheme.titleLarge, textAlign: TextAlign.start,)
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Text("5 Pedidos Realizados", style: theme.textTheme.bodyLarge,),

                                const Rate(
                                  color: Colors.amber,
                                  initialValue: 5,
                                  iconSize: 30,
                                  allowHalf: true,
                                  readOnly: true,
                                )
                              ],
                            ),
                          )


                        ],
                      )
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 3.5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xaa000000),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 16
                          ),
                        ],

                      ),
                      child: Column(
                        children: [

                          Container(
                            height: 75,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary,
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xaa000000),
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 16
                                ),
                              ],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(Icons.restaurant_menu_outlined, color: theme.colorScheme.secondary, size: 30,),
                                  ),
                                  Text("CARDÁPIO", style: theme.textTheme.titleLarge,),
                                ],
                              ),
                            ),
                          ),

                          for (var i = 0; i<5; i++) buildExtensionTile(context, true)

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (show)
            Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 295,
              padding: const EdgeInsets.only(top: 5),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                boxShadow: const [
                  BoxShadow(
                      color: Color(0xa0000000),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 20
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 145,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: 7,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return FoodItem(size: FoodItemSize.small, packageItem: foodTest,);
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Valor Total: R\$ 49,90", style: theme.textTheme.titleLarge,),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text("Tempo de Espera: 1h", style: theme.textTheme.titleSmall,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GalaxyButton(
                            onPressed: (){},
                            child: const Text("FINIALIZAR COMPRA")
                        ),

                        GalaxyButton(
                            onPressed: (){},
                            child: const Text("CANCELAR")
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
          )
        ],
      ),

    );
  }

  int count = 0;
  bool value = true;
  Widget buildExtensionTile(BuildContext context, bool value){
    final theme = Theme.of(context);
    final controller = ExpansionTileController();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5, horizontal: 5),
      child: ExpansionTile(
        controller: controller,
        title: Text("Comidas ${count++}", style: theme.textTheme.titleMedium,),
        tilePadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        iconColor: theme.colorScheme.secondary,
        collapsedIconColor: theme.colorScheme.secondary,
        backgroundColor: value? theme.colorScheme.surface : theme.colorScheme.onSurface,
        collapsedBackgroundColor: value? theme.colorScheme.surface : theme.colorScheme.onSurface,
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        children: [
          if(count == 7) buildExtensionTile(context, !value),
          FoodItem(size: FoodItemSize.big, packageItem: foodTest,),
          FoodItem(size: FoodItemSize.big, packageItem: foodTest,),
          FoodItem(size: FoodItemSize.big, packageItem: foodTest,),
          FoodItem(size: FoodItemSize.big, packageItem: foodTest,),
        ],
      ),
    );
  }

}


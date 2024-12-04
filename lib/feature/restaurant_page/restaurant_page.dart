import 'dart:ui';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:galaxy_food/feature/food_item/food_item.dart';
import 'package:galaxy_food/feature/restaurant_page/restaurant_viewmodel.dart';

class RestaurantPage extends StatefulWidget{

  const RestaurantPage({super.key});

  @override
  State<StatefulWidget> createState() => RestaurantPageState();
}

class RestaurantPageState extends State<RestaurantPage>{

  late final RestaurantViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = RestaurantViewModel(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [

          SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  margin: const EdgeInsets.only(bottom: 25),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: theme.colorScheme.inverseSurface
                          )
                      ),
                      image: viewModel.restaurant == null || viewModel.restaurant?.image == null
                          ? null
                          : DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.5,
                          image: Image.memory(viewModel.restaurant!.image!.toUint8List).image
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
                                  onPressed: () => viewModel.backToHome(context),
                                  icon: Icon(Icons.arrow_back, color: theme.colorScheme.secondary, size: 30,)
                              ),

                              viewModel.restaurant == null
                                  ? Container()
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                                  child: Container(
                                    constraints: const BoxConstraints(maxWidth: 230),
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.secondaryContainer,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 16),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            const Icon(Icons.location_pin),
                                            Text(viewModel.restaurant!.address.toString())
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 75),
                            child: Observer(
                              builder: (context) {
                                return SizedBox(
                                    width: double.maxFinite,
                                    child: Text(
                                      viewModel.restaurant == null? "RESTAURANT": viewModel.restaurant!.name,
                                      style: theme.textTheme.headlineSmall,
                                      textAlign: TextAlign.start,
                                    )
                                );
                              }
                            ),
                          ),

                          Observer(
                            builder: (context) {
                              return SizedBox(
                                  width: double.maxFinite,
                                  child: viewModel.restaurant == null || viewModel.restaurant!.speciality == null
                                      ? null
                                      :Text(
                                    viewModel.restaurant!.speciality!,
                                    style: theme.textTheme.titleLarge,
                                    textAlign: TextAlign.start,
                                  )
                              );
                            }
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                Observer(
                                  builder: (context) {
                                    return Text(
                                      viewModel.buyCount == null? ""
                                      : viewModel.buyCount!<=0?  "Sem Pedidos"
                                      : viewModel.buyCount!>1? "${viewModel.buyCount} Pedidos Realizados"
                                      : "${viewModel.buyCount} Pedido Realizado",
                                      style: theme.textTheme.bodyLarge,
                                    );
                                  }
                                ),

                                Observer(
                                  builder: (context) {
                                    return Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(viewModel.score.toString(), style: theme.textTheme.headlineMedium,),
                                        const Icon(Icons.star, color: Colors.amber, size: 35,)
                                      ],
                                    );
                                  }
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
                  child: GalaxyButton(
                      style: const ButtonStyle(
                          fixedSize: WidgetStatePropertyAll(Size(double.maxFinite, 80))
                      ),
                      onPressed: () => viewModel.avalition(context),
                      child: Text("AVALIAR", style: theme.textTheme.titleMedium,)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Observer(
                      builder: (context) {

                        if (viewModel.root == null) {
                          return Text(
                            "RESTAUARANTE SEM CARDÁPIO",
                            style: theme.textTheme.titleLarge?.merge(
                                TextStyle(color: theme.colorScheme.inverseSurface)
                            ),
                          );
                        }

                        return Container(
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

                              ...?viewModel.getMenu(context)

                            ],
                          ),
                        );
                      }
                  ),
                ),

                Observer(
                  builder: (context) {
                    return SizedBox(
                      height: viewModel.initBuy? 295 : 0,
                    );
                  }
                )
              ],
            ),
          ),

          Observer(
            builder: (context) {
              if (!viewModel.initBuy) return IgnorePointer(child: Container(),);

              return Align(
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
                          itemCount: viewModel.listBuy.length,
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            final item = viewModel.listBuy.keys.toList()[index];
                            return FoodItem(
                              size: FoodItemSize.small,
                              packageItem: item,
                              onTap: () {viewModel.removeBuyItem(item);},
                              onAdd: () {viewModel.add(item);},
                              onRem: () {viewModel.rem(item);},
                              value: viewModel.listBuy[item],
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text("Valor Total: ${UtilBrasilFields.obterReal(viewModel.totalValue)}", style: theme.textTheme.titleLarge,),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GalaxyButton(
                                onPressed: () => viewModel.finishBuy(context),
                                child: const Text("FINALIZAR COMPRA")
                            ),

                            GalaxyButton(
                                onPressed: () => viewModel.cancel(),
                                child: const Text("CANCELAR")
                            )
                          ],
                        ),
                      )

                    ],
                  ),
                ),
              );
            }
          ),

        ],
      ),

    );
  }
}


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/domain/package_item.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:galaxy_food/feature/food_item/food_item.dart';
import 'package:galaxy_food/feature/home_page/home_viewmodel.dart';

import '../../core/domain/food.dart';

class HomePage extends StatefulWidget{

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  late final HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(context);
  }

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
                padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                       Observer(
                         builder: (context){

                           ImageProvider image =
                           viewModel.client != null && viewModel.client!.image != null
                               ? Image.memory(viewModel.client!.image!.toUint8List).image
                               : Image.asset("lib/images/user_default.png").image;

                           return Container(
                             height: 50,
                             width: 50,
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

                        Observer(
                          builder: (context) {
                            return ClipRRect(
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
                                          Text((viewModel.addressSelect?? "LOCAL").toString())
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Observer(
                        builder: (context) {

                          String name = viewModel.client != null
                              ? viewModel.client!.name
                              : "Usuário";

                          return SizedBox(
                            width: double.maxFinite,
                            child: Text("Olá, $name", style: theme.textTheme.headlineSmall,  textAlign: TextAlign.start,)
                          );
                        }
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
                      child: InkWell(
                        onTap: viewModel.search,
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
                                          child: IgnorePointer(
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
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2.5),
                    child: Divider(color: theme.dividerColor,),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: double.maxFinite,
                    child: Text("EXPLORAR RESTAURANTES", style: theme.textTheme.titleSmall,)
                  ),

                 Observer(
                   builder: (context) {

                     return SizedBox(
                       height: viewModel.restaurants.length*300+80,
                       child: Column(
                         children: List.generate(
                             viewModel.restaurants.length,
                             (index){
                               final restaurant = viewModel.restaurants[index];
                               final foods = viewModel.getFoodItemOf(context, restaurant);

                               return Container(
                                 margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
                                     height: 325,
                                     width: double.maxFinite,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.circular(7.5),
                                         color: theme.colorScheme.tertiaryContainer,
                                         image: restaurant.image != null? DecorationImage(
                                             image: Image.memory(restaurant.image!.toUint8List).image,
                                             fit: BoxFit.cover,
                                             opacity: 0.5
                                         ): null
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
                                                   child: Text(restaurant.name, style: theme.textTheme.headlineSmall, textAlign: TextAlign.left,)
                                               ),
                                             ),

                                             SizedBox(
                                               height: 270,
                                               width: double.infinity,
                                               child: FutureBuilder(
                                                   future: foods,
                                                   builder: (context, snapshot) {
                                                     if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) return Container();

                                                     return ListView.builder(
                                                       itemCount: snapshot.data!.length,
                                                       scrollDirection: Axis.horizontal,
                                                       padding: const EdgeInsets.symmetric(horizontal: 10),
                                                       itemBuilder: (context, index){
                                                         return Padding(
                                                             padding: const EdgeInsets.symmetric(horizontal: 10),
                                                             child: FoodItem(
                                                                 size: FoodItemSize.medium,
                                                                 packageItem: snapshot.data![index],
                                                                 onTap: (){
                                                                   viewModel.seeRestaurant(context, restaurant);
                                                                 }
                                                             )
                                                         );
                                                       },
                                                     );
                                                   }
                                               ),
                                             )
                                           ],
                                         ),
                                       ),
                                     )
                                 ),
                               );
                             }
                         ),
                       )
                     );
                   }
                 ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 2.5),
                    child: Divider(color: theme.dividerColor,),
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
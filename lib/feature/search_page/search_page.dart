import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/utils/bytes.dart';
import 'package:galaxy_food/feature/search_page/search_viewmodel.dart';
import 'package:lottie/lottie.dart';

import '../food_item/food_item.dart';

class SearchPage extends StatefulWidget{
  const SearchPage({super.key});

  @override
  State<StatefulWidget> createState() => SearchPageState();

}

class SearchPageState extends State<SearchPage>{

  final viewModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.maxFinite,
              decoration:  BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.elliptical(1800, 200)),
                  border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: theme.colorScheme.inverseSurface
                      )
                  ),
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

                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 15),
                    child: Center(
                        child: Text("Pesquisar Restaurantes", style: theme.textTheme.titleLarge, textAlign: TextAlign.center,)
                    ),
                  ),


                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 35, right: 30, left: 30, top: 10),
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
                                      focusNode: viewModel.focusSearch,
                                      controller: viewModel.textEditingControllerSearch,
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
                                      onTapOutside: (_) => viewModel.focusSearch.unfocus(),
                                      onChanged: (_) => viewModel.reset(),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: VerticalDivider(color: theme.colorScheme.secondary,),
                                  ),

                                  IconButton(
                                      padding: const EdgeInsets.all(2),
                                      iconSize: 30,
                                      icon: Icon(Icons.arrow_forward, size: 25, color: theme.colorScheme.secondary,),
                                      onPressed: () => viewModel.search(context),
                                  ),

                                ],
                              ),
                            ),
                          )
                      ),
                    ),
                  ),
                ],
              ) ,
            ),
        
            SizedBox(
              height: MediaQuery.of(context).size.height-280,
              width: double.maxFinite,
              child: Observer(
                builder: (context) {
                  if (viewModel.restaurants.isEmpty){
                    return Stack(
                      children: [
                        Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 180),
                              child: Transform.scale(
                                scale: 1.30,
                                child: Lottie.asset(
                                  "lib/animations/SearchAnimationLottie.json",
                                  fit: BoxFit.fill,
                                  alignment: Alignment.topCenter
                                ),
                              ),
                            )
                        ),

                        Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Text(viewModel.beforeSearch
                                ? "SEM RESULTADOS..."
                                : "EXPLORE AS\n POSSIBILIDADES...",
                              style: theme.textTheme.headlineSmall!.merge(
                                TextStyle(
                                  color: theme.colorScheme.inverseSurface,
                                )
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                      ],
                    );
                    
                    
                  }

                  return ListView.builder(
                    itemCount: viewModel.restaurants.length,
                    itemBuilder: (context, index){
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
                    },
                  );
                }
              ),
            )
        
        
          ],
        ),
      ),
    );
  }

}
import 'package:flutter/material.dart';

import '../core/domain/food.dart';
import '../core/widgets/galaxy_button.dart';

enum FoodItemSize{
  big,
  medium,
  small
}

class FoodItem extends StatefulWidget{

  //final Food food;
  final FoodItemSize size;

  const FoodItem({super.key, required this.size});

  @override
  State<StatefulWidget> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem>{
  @override
  Widget build(BuildContext context) {
    return switch(widget.size){
      FoodItemSize.big => foodItemBigState(context),
      FoodItemSize.medium => foodItemMediumState(context),
      FoodItemSize.small => foodItemSmallState(context)
    };
  }

  foodItemBigState(BuildContext context){
    // TODO: implement build
    throw UnimplementedError();
  }

  foodItemMediumState(BuildContext context){
    final theme = Theme.of(context);

    return SizedBox(
      height: 230,
      width: 290,
      child: Stack(
        children: [

          Positioned(
            top: 80,
            child: Container(
              height: 150,
              width: 280,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.elliptical(800, 300),
                    bottom:  Radius.circular(100),
                  ),
                  color: theme.colorScheme.onPrimary,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xaa000000),
                        blurStyle: BlurStyle.outer,
                        blurRadius: 16
                    ),
                  ]
              ),
              child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 150,
                              child: Text("X-Burguer Classic", style: theme.textTheme.titleMedium,)
                          ),

                          Text("R\$ 49,90", style: theme.textTheme.titleSmall,)
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 150,
                                height: 55,
                                child: SingleChildScrollView(
                                  child: Text("Pão com gergilim, hamguer bovino, queijo prato, alface, tomate", style: theme.textTheme.labelSmall,),
                                )
                            ),

                            GalaxyButton(
                                onPressed: (){},
                                style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll( EdgeInsets.all(6)),
                                ),
                                child: const Text("Ver")
                            )

                          ],
                        ),
                      )
                    ],
                  )
              ),
            ),
          ),

          Positioned(
            left: 75,
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  image: DecorationImage(
                      image: Image.network("https://static.vecteezy.com/system/resources/thumbnails/021/952/563/small_2x/tasty-hamburger-on-transparent-background-png.png").image,
                      fit: BoxFit.fill
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  foodItemSmallState(BuildContext context){
    // TODO: implement build
    throw UnimplementedError();
  }
}
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/domain/food.dart';
import 'package:galaxy_food/core/domain/package_item.dart';
import 'package:galaxy_food/feature/food_item/food_item_viewmodel.dart';

import '../../core/domain/combo.dart';
import '../../core/widgets/galaxy_button.dart';

enum FoodItemSize{
  big,
  medium,
  small
}

class FoodItem extends StatefulWidget{

  final PackageItem packageItem;
  final FoodItemSize size;
  Null Function()? onTap = (){};


  FoodItem({super.key, required this.size, required this.packageItem, this.onTap});

  @override
  State<StatefulWidget> createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem>{

  final viewModel = FoodItemViewModel();

  @override
  Widget build(BuildContext context) {
    return switch(widget.size){
      FoodItemSize.big => foodItemBigState(context),
      FoodItemSize.medium => foodItemMediumState(context),
      FoodItemSize.small => foodItemSmallState(context)
    };
  }

  foodItemBigState(BuildContext context){
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: SizedBox(
        height: 210,
        child: Stack(
          children: [

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 60),
              padding: const EdgeInsets.only(left: 95, top: 20, bottom: 30),
              decoration: BoxDecoration(
                color: theme.colorScheme.onPrimary,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.elliptical(1000, 800),
                  right: Radius.circular(10)
                ),
                border: Border(
                    left: BorderSide(
                      color: theme.colorScheme.secondary,
                      width: 1.5
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Text(widget.packageItem.name, style: theme.textTheme.titleMedium,),
                  Text(UtilBrasilFields.obterReal(widget.packageItem.price), style: theme.textTheme.titleLarge,),

                  Padding(
                    padding: const EdgeInsets.only(top: 12.5),
                    child: SizedBox(
                      height: 50,
                      child: SingleChildScrollView(
                        child: Text(
                         widget.packageItem is Food
                         ? (widget.packageItem as Food).description
                         : (widget.packageItem as Combo).items.ListToString
                        )
                      ),
                    ),
                  )
                ],
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    //color: theme.colorScheme.secondary,
                    image: DecorationImage(
                        image: Image.network("https://static.vecteezy.com/system/resources/thumbnails/021/952/563/small_2x/tasty-hamburger-on-transparent-background-png.png").image,
                        fit: BoxFit.fill
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: GalaxyButton(
                  onPressed: widget.onTap,
                  style: ButtonStyle(
                    overlayColor: const WidgetStatePropertyAll(Colors.deepOrangeAccent),
                    backgroundColor: const WidgetStatePropertyAll(Colors.deepOrange),
                    fixedSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width - 200, 45)),
                    padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                    side:const WidgetStatePropertyAll(BorderSide.none)
                  ),
                  child: const Text("COMPRAR"),
                ),
              )
            )

          ]
        ),
      ),
    );
  }

  foodItemMediumState(BuildContext context){
    final theme = Theme.of(context);

    return SizedBox(
      height: 250,
      width: 325,
      child: Stack(
        children: [

          Positioned(
            top: 80,
            child: Container(
              height: 170,
              width: 315,
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
                              width: 200,
                              child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(widget.packageItem.name, style: theme.textTheme.titleMedium,)
                              )
                          ),

                          Text(UtilBrasilFields.obterReal(widget.packageItem.price), style: theme.textTheme.titleMedium,)
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 200,
                                height: 72,
                                child: SingleChildScrollView(
                                  child: Text(
                                    widget.packageItem is Food
                                        ? (widget.packageItem as Food).description
                                        : (widget.packageItem as Combo).items.ListToString,
                                    style: theme.textTheme.labelSmall,
                                  ),
                                )
                            ),

                            GalaxyButton(
                                onPressed: widget.onTap,
                                style: const ButtonStyle(
                                  padding: WidgetStatePropertyAll( EdgeInsets.all(6)),
                                ),
                                child: const Text("Ver")
                            )

                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
          ),

          Positioned(
            left: 90,
            child: Container(
              height: 125,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
    final theme = Theme.of(context);

    assert(widget.packageItem is Food);

    return Container(
      height: 120,
      width: 265,
      margin: const EdgeInsets.only(right: 12.5),
      child: Stack(
        children: [
          Container(
            height: 115,
            width: 250,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(12.5),
            decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(7.5),
                boxShadow: const [
                  BoxShadow(
                      color: Color(0x5a000000),
                      blurStyle: BlurStyle.outer,
                      blurRadius: 10
                  ),
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 140,
                      height: 32,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.5),
                          child: Text(widget.packageItem.name, style: theme.textTheme.bodyMedium?.merge(const TextStyle(fontWeight: FontWeight.w600))),
                        )
                      )
                    ),
                    SizedBox(
                      width: 76,
                      height: 32,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.5),
                          child: Text(UtilBrasilFields.obterReal(widget.packageItem.price), style: theme.textTheme.bodyLarge?.merge(const TextStyle(fontWeight: FontWeight.w600))),
                        )
                    )
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GalaxyButton(
                        onPressed: viewModel.onAdd,
                        style: const ButtonStyle(padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30)
                        )),
                        child: const Icon(Icons.add,size: 20)
                    ),

                    Observer(
                      builder: (context) {
                        return Text(viewModel.value.toString(), style: theme.textTheme.headlineMedium,);
                      }
                    ),

                    GalaxyButton(
                        onPressed: viewModel.onRem,
                        style: const ButtonStyle(padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30)
                        )),
                        child: const Icon(Icons.remove,size: 20)
                    )

                  ],
                )
              ],
            ),
          ),

          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: widget.onTap,
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.secondary,
                    width: 1.5
                  )
                ),
                child: const Center(child: Icon(Icons.close)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
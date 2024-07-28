import 'package:flutter/material.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class OrderPage extends StatefulWidget{
  const OrderPage({super.key});

  @override
  State<StatefulWidget> createState() => OrderPageState();

}

class OrderPageState extends State<OrderPage>{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidPullToRefresh(
      height: MediaQuery.of(context).size.height-400,
      color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.secondary,
      borderWidth: 10,
      onRefresh: () async{
        await Future.delayed(const Duration(seconds: 5));
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Icon(Icons.history, color: theme.colorScheme.secondary,),
              ),
              Text("Histórico Pedidos", style: theme.textTheme.titleLarge,),
            ],
          ),
          backgroundColor: theme.colorScheme.primary,
          shadowColor: const Color(0xff000000),
          elevation: 20,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 60),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Text("Pedidos Recentes", style: theme.textTheme.titleLarge, textAlign: TextAlign.left,)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 2.5, bottom: 20),
                  child: Divider(color: theme.dividerColor,),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: OrderItem(withStatus: true,)
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: SizedBox(
                      width: double.maxFinite,
                      child: Text("Pedidos Recentes", style: theme.textTheme.titleLarge, textAlign: TextAlign.left,)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 2.5, bottom: 20),
                  child: Divider(color: theme.dividerColor,),
                ),

                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: OrderItem(withStatus: false,)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

enum OrderStatus{
  canceled(Colors.red),
  waiting(Colors.orange),
  making(Colors.amber),
  made(Colors.blue),
  delivered(Colors.green);

  final Color color;
  const OrderStatus(this.color);
}

class OrderItem extends StatefulWidget{
  final bool withStatus;

  const OrderItem({super.key, this.withStatus = false});

  @override
  State<StatefulWidget> createState() => _OrderItemState();

}

class _OrderItemState extends State<OrderItem>{
  @override
  Widget build(BuildContext context) {

    if (widget.withStatus) return buildOrderWithStatus(context);
    return buildOrderWithoutStatus(context);

  }

  Widget buildOrderWithStatus(BuildContext context){
    final theme = Theme.of(context);
    return Container(
      width: double.maxFinite,
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface,
        borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(7.5),
            left: Radius.circular(17.5)
        ),
        border: Border(left: BorderSide(
          color: OrderStatus.waiting.color,
          width: 10
        )),
        boxShadow: const [
          BoxShadow(
              color: Color(0xaa000000),
              blurStyle: BlurStyle.outer,
              blurRadius: 16
          ),
        ]
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 180,
                      child: Text("RESTAURANT NAME", style: theme.textTheme.titleSmall,)
                  ),
                  Text("R\$ 49,90", style: theme.textTheme.titleLarge,),
                ],
              ),

              Column(
                children: [

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: OrderStatus.waiting.color
                    ),
                    child:  const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 16),
                        child: Text("Em espera")
                    ),
                  ),


                ],
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text("Hoje, às 12:30", style: theme.textTheme.titleMedium,),
                  ),

                  Text("Tempo de espera: 1 hora", style: theme.textTheme.bodyMedium,),
                ],
              ),
            )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: GalaxyButton(
                  onPressed: (){},
                  child: const Text("Detalhes"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: GalaxyButton(
                  onPressed: (){},
                  child: const Text("Cancelar"),
                ),
              )
            ],
          )


        ],
      ),
    );
  }

  Widget buildOrderWithoutStatus(BuildContext context){
    final theme = Theme.of(context);
    return Container(
      width: double.maxFinite,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.onSurface,
        borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(7.5),
            left: Radius.circular(17.5)
        ),
        border: Border(left: BorderSide(
            color: OrderStatus.delivered.color,
            width: 10
        )),
        boxShadow: const [
          BoxShadow(
              color: Color(0xaa000000),
              blurStyle: BlurStyle.outer,
              blurRadius: 16
          ),
        ]
      ),
      child: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 180,
                      child: Text("RESTAURANT NAME", style: theme.textTheme.titleSmall,)
                  ),
                  Text("R\$ 49,90", style: theme.textTheme.titleLarge,),
                ],
              ),

              Column(
                children: [

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: OrderStatus.delivered.color
                    ),
                    child:  const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 16),
                        child: Text("Entregue")
                    ),
                  ),


                ],
              )
            ],
          ),

          Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text("Ontem, às 12:30", style: theme.textTheme.titleMedium,),
                ),
              )
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10),
                child: GalaxyButton(
                  onPressed: (){},
                  child: const Text("Detalhes"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: GalaxyButton(
                  onPressed: (){},
                  child: const Text("Imprimir"),
                ),
              ),
            ],
          )


        ],
      ),
    );
  }

}
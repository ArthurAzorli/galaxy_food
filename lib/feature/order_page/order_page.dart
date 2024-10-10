import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:galaxy_food/core/domain/order_status.dart';
import 'package:galaxy_food/core/widgets/galaxy_button.dart';
import 'package:galaxy_food/feature/order_page/order_viewmodel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:lottie/lottie.dart';

import '../../core/domain/buy.dart';

class OrderPage extends StatefulWidget{
  const OrderPage({super.key});

  @override
  State<StatefulWidget> createState() => OrderPageState();

}

class OrderPageState extends State<OrderPage>{

  late final viewModel = OrderViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.update(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LiquidPullToRefresh(
      height: MediaQuery.of(context).size.height-400,
      color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.secondary,
      borderWidth: 100,
      onRefresh: () async{
        await viewModel.update(context);
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
        body: Padding(
          padding: const EdgeInsets.only(top: 40, bottom: 60),
          child: SizedBox(
            height: MediaQuery.of(context).size.height-80,
            child: Observer(
              builder: (context) {

                if (viewModel.listIsEmpty){
                  return Stack(
                    children: [
                      Align(
                          alignment: Alignment.topCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                            child: Lottie.asset(
                                "lib/animations/OrderAnimationLottie.json",
                                fit: BoxFit.fill,
                                alignment: Alignment.topCenter
                            ),
                          )
                      ),

                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 420, right: 15, left: 15),
                          child: Text("FAÇA SEU PRIMEIRO PEDIDO!",
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

                return SingleChildScrollView(
                  child: SizedBox(
                    height: viewModel.newOrders.length*220+viewModel.oldOrders.length*220+80,
                    child: Column(
                      children: [
                  
                        if (viewModel.newOrders.isNotEmpty) ..._NewOrdersWidgets(context),
                        if (viewModel.oldOrders.isNotEmpty) ..._OldOrdersWidgets(context),
                  
                      ],
                    ),
                  ),
                );


              }
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _NewOrdersWidgets(BuildContext context){
    final theme = Theme.of(context);
    return [
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

      ...List.generate(
          viewModel.oldOrders.length,
              (index){
            final buy = viewModel.oldOrders[index];
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: OrderItem(
                    buy,
                    onDetails: () => viewModel.seeDetails(context, buy),
                    onSecondOption: buy.orderStatus != OrderStatus.delivered && buy.orderStatus != OrderStatus.canceled
                        ? () => viewModel.cancel(context, buy)
                        : () => viewModel.imprimir(),
                    withStatus: buy.orderStatus != OrderStatus.delivered && buy.orderStatus != OrderStatus.canceled,
                )
            );
          }
      ),
    ];
  }

  List<Widget> _OldOrdersWidgets(BuildContext context){
    final theme = Theme.of(context);
    return [
      Padding(
        padding: EdgeInsets.only(top: viewModel.newOrders.isNotEmpty? 50 : 0, left: 20, right: 20),
        child: SizedBox(
            width: double.maxFinite,
            child: Text("Pedidos Anteriores", style: theme.textTheme.titleLarge, textAlign: TextAlign.left,)
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 2.5, bottom: 20),
        child: Divider(color: theme.dividerColor,),
      ),

      ...List.generate(
          viewModel.oldOrders.length,
          (index){
            final buy = viewModel.oldOrders[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: OrderItem(
                buy,
                onDetails: () => viewModel.seeDetails(context, buy),
                onSecondOption: buy.orderStatus != OrderStatus.delivered && buy.orderStatus != OrderStatus.canceled
                    ? () => viewModel.cancel(context, buy)
                    : () => viewModel.imprimir(),
                withStatus: buy.orderStatus != OrderStatus.delivered //&& buy.orderStatus != OrderStatus.canceled,
              )
            );
          }
      ),
    ];
  }
}

class OrderItem extends StatefulWidget{
  final Buy buy;
  final bool withStatus;
  final Function() onDetails;
  final Function() onSecondOption;

  const OrderItem(this.buy, {super.key, this.withStatus = false, required this.onDetails, required this.onSecondOption});

  @override
  State<StatefulWidget> createState() => _OrderItemState();

}

class _OrderItemState extends State<OrderItem>{

  @override
  Widget build(BuildContext context) {

    double _getTotalValue(Buy buy){
      var value = 0.0;
      for (final item in buy.items){
        value += item.quantity*item.item.price;
      }
      return value;
    }

    final theme = Theme.of(context);
    final int differenceDate = widget.buy.date.difference(DateTime.now()).inHours;
    final dynamic date = differenceDate > -24
        ? "Hoje"
        : differenceDate > -48
        ? "Ontem"
        : differenceDate > -168
        ? _getWeekDay(widget.buy.date)
        : UtilData.obterDataDDMMAAAA(widget.buy.date);

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
              color: widget.buy.orderStatus.color,
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
                      child: Text(widget.buy.restaurant.name, style: theme.textTheme.titleSmall,)
                  ),
                  Text(UtilBrasilFields.obterReal(_getTotalValue(widget.buy)), style: theme.textTheme.titleLarge,),
                ],
              ),

              Column(
                children: [

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(200),
                        color: widget.buy.orderStatus.color
                    ),
                    child:  Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 16),
                        child: Text(widget.buy.orderStatus.toString())
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
                      child: Text(
                        "$date, às ${UtilData.obterHoraHHMM(widget.buy.date)}",
                        style: theme.textTheme.titleMedium,
                      ),
                    ),

                    Text("Forma de Pagamento: ${widget.buy.paymentForm.toString()}", style: theme.textTheme.bodyMedium,),
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
                  onPressed: widget.onDetails,
                  child: const Text("Detalhes"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10),
                child: GalaxyButton(
                  onPressed: widget.onSecondOption,
                  child: Text(widget.withStatus? "Cancelar" : "Imprimir"),
                ),
              )
            ],
          )


        ],
      ),
    );

  }

  String _getWeekDay(DateTime date){
    switch(date.weekday){
      case(DateTime.sunday):
        return "Domingo";
      case(DateTime.monday):
        return "Segunda-Feira";
      case(DateTime.tuesday):
        return "Terça-Feira";
      case(DateTime.wednesday):
        return "Quarta-Feira";
      case(DateTime.thursday):
        return "Quinta-Feira";
      case(DateTime.friday):
        return "Sexta-Feira";
      case(DateTime.saturday):
        return "Sabádo";
      default:
        return "";
    }
  }

}
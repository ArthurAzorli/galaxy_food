import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:galaxy_food/core/service/repository/buy_repository_service.dart';
import 'package:galaxy_food/core/utils/exception/repository_exception.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../core/domain/buy.dart';
import '../../core/widgets/galaxy_button.dart';

part 'order_viewmodel.g.dart';

class OrderViewModel = OrderViewModelBase with _$OrderViewModel;

abstract class OrderViewModelBase with Store {

  @observable
  List<Buy> oldOrders = [];

  @observable
  List<Buy> newOrders = [];

  @action
  update(BuildContext context) async {
    try {
      final buys = await BuyRepositoryService.getAll();
      final oldOrders = <Buy>[];
      final newOrders = <Buy>[];



      for (var buy in buys){
        print(buy.date.difference(DateTime.now()));
        print(buy.date.difference(DateTime.now()).inHours);

        if (buy.date.difference(DateTime.now()).inHours<-24){
          oldOrders.add(buy);
        } else {
          newOrders.add(buy);
        }
      }

      this.newOrders = newOrders;
      this.oldOrders = oldOrders;

    } on RepositoryException catch(e) {
      e.showMessageDialog(context, () {
        Navigator.of(context).pop();
        context.go("/signin");
      });
    }
  }

  @action
  cancel(BuildContext context, Buy buy){
    try {
      BuyRepositoryService.cancel(buy.id!);
    } on RepositoryException catch(e) {
      e.showMessageDialog(context, () => Navigator.pop(context));
    }
    update(context);
  }

  @action
  seeDetails(BuildContext context, Buy buy){
    final theme = Theme.of(context);

    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Detalhes", style: theme.textTheme.titleLarge),
            content: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Restaurante: ${buy.restaurant.name}", style: theme.textTheme.titleMedium),
                    Text("Endereço de Entrega: ${buy.sentAddress.toString()}", style: theme.textTheme.bodyLarge),
                
                    Padding(
                      padding: const EdgeInsets.only( top: 15),
                      child: Text("Data: ${UtilData.obterDataDDMMAAAA(buy.date)} ás ${UtilData.obterHoraHHMM(buy.date)}", style: theme.textTheme.bodyLarge),
                    ),
                    Text("Forma de Pagemanto: ${buy.paymentForm.toString()}", style: theme.textTheme.bodyLarge),
                    Text("Valor Total: ${UtilBrasilFields.obterReal(buy.deliveryFee)}", style: theme.textTheme.bodyLarge),
                    Text("Taxa de Entrega: ${UtilBrasilFields.obterReal(buy.deliveryFee)}", style: theme.textTheme.bodyLarge),
                    Text("Disconto Total: ${UtilBrasilFields.obterReal(buy.discount)}", style: theme.textTheme.bodyLarge),
                
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text("Itens Comprados:", style: theme.textTheme.bodyLarge),
                    ),
                    ListView.builder(
                      itemCount: buy.items.length,
                      itemBuilder: (context, index){
                        final item = buy.items[index];
                        return ListTile(
                          trailing: Text("${item.quantity}x"),
                          title: Text("${item.item.name} - ${UtilBrasilFields.obterReal(item.item.price*item.quantity)}"),
                        );
                      },
                    )
                
                  ],
                ),
              ),
            ),
            actions: [
              Center(
                child: GalaxyButton(
                    style: const ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(200, 50))
                    ),
                    onPressed: ()=>Navigator.pop(context),
                    child: const Text("FECHAR")
                ),
              )
            ],
          );
        }
    );
  }

  @action
  imprimir(){
    print("em breve");
  }

  @computed
  bool get listIsEmpty => newOrders.isEmpty && oldOrders.isEmpty;

}
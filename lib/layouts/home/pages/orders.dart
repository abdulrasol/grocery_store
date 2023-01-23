import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/layouts/widgets/order_card_loading.dart';
import 'package:grocery_store/layouts/widgets/order_cart.dart';
import 'package:grocery_store/models/order.dart';
import 'package:grocery_store/services/database.dart';

class Orders extends StatelessWidget {
  Orders({Key? key}) : super(key: key);
  final DatabaseController _dataBaseController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: pageTitle('My Orders'),
          ),
          sizedBox,
          Expanded(
            child: FutureBuilder(
              //future: _dataBaseController.getOrders(),
              builder: (context, AsyncSnapshot<List<Order>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return OrderCard(
                          date: snapshot.data![index].date!,
                          isComplete:
                              (snapshot.data![index].storeState == 'done' &&
                                  snapshot.data![index].userState == 'done'),
                          totalPrice: snapshot.data![index].price!,
                          order: snapshot.data![index],
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        //print(snapshot.data.runtimeType);
                        return const OrderShimmerCard();
                      },
                    );
                  }
                } else {
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const OrderShimmerCard();
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

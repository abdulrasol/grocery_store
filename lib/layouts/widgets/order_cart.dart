import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/home/pages/order.dart';
import 'package:grocery_store/models/order.dart' as models;

class OrderCard extends StatelessWidget {
  const OrderCard({
    Key? key,
    required this.date,
    required this.isComplete,
    required this.totalPrice,
    required this.order,
  }) : super(key: key);

  final String date;
  final bool isComplete;
  final double totalPrice;
  final models.Order order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => Order(
              order: order,
              formChechout: false,
            ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            width: 1,
            color: Colors.grey[300]!,
          ),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Image.asset('assets/images/groceries.png'),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Total Price: ${totalPrice.toStringAsFixed(2)} \$',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              FittedBox(
                child: Icon(
                  isComplete ? Icons.done : Boxicons.bxs_hourglass,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/home/pages/select_location.dart';
import 'package:grocery_store/layouts/widgets/confirm_order_card.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/models/order.dart';
import 'package:grocery_store/services/database_dontroller.dart';
import 'package:grocery_store/layouts/home/pages/order.dart' as pages;
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ConfirmOrder extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ConfirmOrder({Key? key}) : super(key: key);

  late final Order order;

  @override
  _ConfirmOrderState createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final _databaseController = Get.put(DatabaseController());
  final _btncontroller = RoundedLoadingButtonController();
  Future<List> updateAddress(double lat, double lng) async {
    dynamic a = await placemarkFromCoordinates(lat, lng);
    a = a.first.street!;

    return [a, GeoPoint(lat, lng)];
  }

  @override
  void initState() {
    widget.order = Order(
      user: _databaseController.uid,
      location: _databaseController.user.value.location,
      price: _databaseController.cartTolatPrice.value,
      items: _databaseController.cart,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _databaseController.calculateItemPrice();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Text(
          'Order View And Confirm',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Address',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Text(
                      widget.order.location![0],
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () async {
                        await Get.dialog(const SelectLocation())
                            .then((latLng) async {
                          widget.order.location = await updateAddress(
                              latLng.latitude, latLng.longitude);
                        });
                        setState(() {});
                      },
                      icon: const Icon(Boxicons.bx_location_plus),
                      label: const Text('Different address'),
                    ),
                    const Text(
                      'Items',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: ConfiemOrderItemCard(
                                elememt: _databaseController.cart[index],
                              ),
                            );
                          },
                          itemCount: _databaseController.cart.length),
                    ),
                    const Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 60,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Center(
                  child: Text(
                    'Total Price: ${_databaseController.cartTolatPrice.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RoundedLoadingButton(
                    controller: _btncontroller,
                    onPressed: () async {
                      if (widget.order.location![0].isNotEmpty) {
                        if (widget.order.price! > 0) {
                          Order order = await _databaseController
                              .confirmOrder(widget.order);
                          Get.off(() => pages.Order(
                                order: order,
                                formChechout: true,
                              ));
                        } else {
                          _btncontroller.reset();
                          showSnackbar(
                            'Error',
                            'Please Re-Add Items to Cart',
                            'assets/images/alert.png',
                            isLocalImage: true,
                          );
                        }
                      } else {
                        _btncontroller.reset();
                        showSnackbar(
                          'Error',
                          'Please Select your Location!',
                          'assets/images/alert.png',
                          isLocalImage: true,
                        );
                      }
                    },
                    color: Colors.black87,
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

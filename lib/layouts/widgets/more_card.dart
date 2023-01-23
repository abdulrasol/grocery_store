import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MoreCard extends StatelessWidget {
  MoreCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
  }) : super(key: key);
  IconData icon;
  String title;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => route);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(child: SizedBox(width: 8)),
              Icon(icon),
            ],
          ),
        ),
      ),
    );
  }
}

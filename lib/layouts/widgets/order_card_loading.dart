import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'package:shimmer/shimmer.dart';

class OrderShimmerCard extends StatelessWidget {
  const OrderShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          width: 1,
          color: Colors.grey[300]!,
        ),
      ),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white,
        child: SizedBox(
          height: 70,
          width: double.infinity,
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
                    Container(
                      width: 160,
                      height: 18,
                      color: Colors.grey[200],
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: 60,
                      height: 18,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                const Icon(Boxicons.bx_time),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

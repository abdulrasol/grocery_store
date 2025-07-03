import 'package:flutter/material.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:shimmer/shimmer.dart';

class ItemShimmerCard extends StatelessWidget {
  const ItemShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[200]!,
        highlightColor: Colors.white,
        child: SizedBox(
          height: 245,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 134,
                  height: 100,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey[100],
                  ),
                ),
                sizedBox,
                Container(
                  width: 60,
                  height: 18,
                  color: Colors.grey[200],
                ),
                const SizedBox(height: 5),
                Container(
                  width: 90,
                  height: 14,
                  color: Colors.grey[200],
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 30,
                      height: 18,
                      color: Colors.grey[200],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      color: Colors.grey[200],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

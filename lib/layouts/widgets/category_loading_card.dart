import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CategoryShimmerCard extends StatelessWidget {
  const CategoryShimmerCard({Key? key}) : super(key: key);

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
          height: 250,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  width: 150,
                  child: Image.asset('assets/images/groceries.png'),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 150,
                  height: 18,
                  color: Colors.grey[200],
                ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

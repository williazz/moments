import 'package:skeleton_text/skeleton_text.dart';
import 'package:flutter/material.dart';

class SkeletonPostWidget extends StatelessWidget {
  const SkeletonPostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: SkeletonAnimation(
            shimmerColor: Colors.grey,
            borderRadius: BorderRadius.circular(20),
            shimmerDuration: 1000,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.only(top: 40),
            )));
  }
}

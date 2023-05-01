import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../styles/colors.dart';

class ShimmerGenreList extends StatelessWidget {
  const ShimmerGenreList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        colors: [
          kDavysGrey,
          kGrey,
        ],
        begin: Alignment(-1.0, -0.5),
        end: Alignment(1.0, 0.5),
      ),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: kDavysGrey,
        ),
      ),
    );
  }
}

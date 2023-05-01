import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContentList extends StatelessWidget {
  const ShimmerContentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.withOpacity(0.5),
          Colors.grey.withOpacity(0.3),
          Colors.grey.withOpacity(0.5),
        ],
        begin: const Alignment(-1.0, -0.5),
        end: const Alignment(1.0, 0.5),
      ),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[300],
        ),
      ),
    );
  }
}

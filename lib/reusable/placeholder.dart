import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContentPlaceHolder extends StatelessWidget {
  final double width;
  final double height;

  const ContentPlaceHolder({Key? key, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 2),
        baseColor: Colors.grey.withOpacity(0.5),
        highlightColor: Colors.white.withOpacity(0.4),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
              color: Colors.grey,
            ),
          ),
        );
  }
}

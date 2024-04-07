import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerEffectUI extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerEffectUI.rectangular({
    super.key,
    this.width = double.infinity,
    required this.height,
  }) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerEffectUI.circular({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: context.theme.colorScheme.brightness == Brightness.light ? Colors.grey[300]! : Colors.grey[800]!,
        highlightColor:
            context.theme.colorScheme.brightness == Brightness.light ? Colors.grey[100]! : Colors.grey[900]!,
        period: const Duration(seconds: 3),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[300]!,
            shape: shapeBorder,
          ),
        ),
      );
}

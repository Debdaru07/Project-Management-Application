import 'package:flutter/material.dart';
import '../theme/app_palette.dart';
import '../theme/app_text_styles.dart';

class AppLinearProgress extends StatelessWidget {
  final double value; // between 0.0 and 1.0
  final String? label;
  final Color? color;
  final double height;
  final BorderRadiusGeometry borderRadius;

  const AppLinearProgress({
    super.key,
    required this.value,
    this.label,
    this.color,
    this.height = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              label!,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppPalette.primarySwatch,
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '${(value * 100).toStringAsFixed(0)}% Complete',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppPalette.primarySwatch,
              ),
            ),
          ),
        ClipRRect(
          borderRadius: borderRadius,
          child: LinearProgressIndicator(
            value: value.clamp(0.0, 1.0),
            minHeight: height,
            backgroundColor: AppPalette.magnolia,
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? AppPalette.resolutionBlue,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../theme/app_palette.dart' as palette;
import '../theme/app_palette.dart';
import '../theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  final String text;
  final TextStyle? textstyle;
  final Widget? prefixIcon;
  final String? followersText;
  final Color? backgroundColor;
  final double? height;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;

  const AppButton({
    super.key,
    required this.text,
    this.textstyle,
    this.prefixIcon,
    this.followersText,
    this.backgroundColor,
    this.height,
    this.borderRadius,
    this.padding,
    this.margin,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height ?? 48,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
          margin: margin ?? EdgeInsets.zero,
          decoration: BoxDecoration(
            color: backgroundColor ?? palette.AppPalette.raisinBlack,
            borderRadius: BorderRadius.circular(borderRadius ?? 4),
            border: Border.all(
              color: AppPalette.primarySwatch.withOpacity(0.625),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 0.5,
                blurRadius: 1,
                offset: const Offset(0, 0.5),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (prefixIcon != null) ...[
                prefixIcon!,
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style:
                    textstyle ??
                    AppTextStyles.bodyLarge.copyWith(
                      color: palette.AppPalette.magnolia,
                    ),
              ),
              if (followersText != null)
                Text(
                  followersText!,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: palette.AppPalette.periwinkle,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

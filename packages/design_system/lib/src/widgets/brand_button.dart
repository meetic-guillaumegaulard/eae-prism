import 'package:flutter/material.dart';

enum BrandButtonVariant {
  primary,
  secondary,
  outline,
}

enum BrandButtonSize {
  small,
  medium,
  large,
}

class BrandButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final BrandButtonVariant variant;
  final BrandButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  const BrandButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.variant = BrandButtonVariant.primary,
    this.size = BrandButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Size configuration
    final double height;
    final double horizontalPadding;
    final double fontSize;
    final double iconSize;

    switch (size) {
      case BrandButtonSize.small:
        height = 36;
        horizontalPadding = 16;
        fontSize = 14;
        iconSize = 16;
        break;
      case BrandButtonSize.medium:
        height = 48;
        horizontalPadding = 24;
        fontSize = 16;
        iconSize = 20;
        break;
      case BrandButtonSize.large:
        height = 56;
        horizontalPadding = 32;
        fontSize = 18;
        iconSize = 24;
        break;
    }

    // Style configuration based on variant
    final Color backgroundColor;
    final Color foregroundColor;
    final BorderSide? borderSide;

    switch (variant) {
      case BrandButtonVariant.primary:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        borderSide = null;
        break;
      case BrandButtonVariant.secondary:
        backgroundColor = colorScheme.secondary;
        foregroundColor = colorScheme.onSecondary;
        borderSide = null;
        break;
      case BrandButtonVariant.outline:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.primary;
        borderSide = BorderSide(color: colorScheme.primary, width: 2);
        break;
    }

    Widget buttonContent = isLoading
        ? SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: iconSize),
                const SizedBox(width: 8),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w600,
                  color: foregroundColor,
                ),
              ),
            ],
          );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: borderSide != null ? Border.fromBorderSide(borderSide) : null,
            ),
            child: Center(child: buttonContent),
          ),
        ),
      ),
    );
  }
}


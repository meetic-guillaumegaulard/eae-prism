import 'package:flutter/material.dart';

enum ButtonEAEVariant {
  primary,
  secondary,
  outline,
}

enum ButtonEAESize {
  small,
  medium,
  large,
}

class ButtonEAE extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonEAEVariant variant;
  final ButtonEAESize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  // Optional overrides for advanced customization (like SelectableButton)
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderSide? borderSide;

  const ButtonEAE({
    Key? key,
    required this.label,
    this.onPressed,
    this.variant = ButtonEAEVariant.primary,
    this.size = ButtonEAESize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderSide,
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
      case ButtonEAESize.small:
        height = 36;
        horizontalPadding = 16;
        fontSize = 14;
        iconSize = 16;
        break;
      case ButtonEAESize.medium:
        height = 48;
        horizontalPadding = 24;
        fontSize = 16;
        iconSize = 20;
        break;
      case ButtonEAESize.large:
        height = 56;
        horizontalPadding = 32;
        fontSize = 18;
        iconSize = 24;
        break;
    }

    // Style configuration based on variant, unless overridden
    final Color effectiveBackgroundColor;
    final Color effectiveForegroundColor;
    final BorderSide? effectiveBorderSide;

    if (backgroundColor != null ||
        foregroundColor != null ||
        borderSide != null) {
      // If overrides are present, use them (falling back to variant defaults if a specific one is missing but unlikely mixed usage)
      // For simplicity, we calculate defaults then override.
      Color defaultBg;
      Color defaultFg;
      BorderSide? defaultBorder;

      switch (variant) {
        case ButtonEAEVariant.primary:
          defaultBg = colorScheme.primary;
          defaultFg = colorScheme.onPrimary;
          defaultBorder = null;
          break;
        case ButtonEAEVariant.secondary:
          defaultBg = colorScheme.secondary;
          defaultFg = colorScheme.onSecondary;
          defaultBorder = null;
          break;
        case ButtonEAEVariant.outline:
          defaultBg = Colors.transparent;
          defaultFg = colorScheme.primary;
          defaultBorder = BorderSide(color: colorScheme.primary, width: 2);
          break;
      }

      effectiveBackgroundColor = backgroundColor ?? defaultBg;
      effectiveForegroundColor = foregroundColor ?? defaultFg;
      effectiveBorderSide = borderSide ?? defaultBorder;
    } else {
      // Standard variant logic
      switch (variant) {
        case ButtonEAEVariant.primary:
          effectiveBackgroundColor = colorScheme.primary;
          effectiveForegroundColor = colorScheme.onPrimary;
          effectiveBorderSide = null;
          break;
        case ButtonEAEVariant.secondary:
          effectiveBackgroundColor = colorScheme.secondary;
          effectiveForegroundColor = colorScheme.onSecondary;
          effectiveBorderSide = null;
          break;
        case ButtonEAEVariant.outline:
          effectiveBackgroundColor = Colors.transparent;
          effectiveForegroundColor = colorScheme.primary;
          effectiveBorderSide =
              BorderSide(color: colorScheme.primary, width: 2);
          break;
      }
    }

    Widget buttonContent = isLoading
        ? SizedBox(
            width: iconSize,
            height: iconSize,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor:
                  AlwaysStoppedAnimation<Color>(effectiveForegroundColor),
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
                  color: effectiveForegroundColor,
                ),
              ),
            ],
          );

    final elevatedButtonTheme = theme.elevatedButtonTheme.style;
    final double elevation = elevatedButtonTheme?.elevation?.resolve({}) ?? 0.0;
    final Color? shadowColor = elevatedButtonTheme?.shadowColor?.resolve({});

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: height,
      child: Material(
        color: effectiveBackgroundColor,
        elevation: elevation,
        shadowColor: shadowColor,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: effectiveBorderSide != null
                  ? Border.fromBorderSide(effectiveBorderSide)
                  : null,
            ),
            child: Center(child: buttonContent),
          ),
        ),
      ),
    );
  }
}

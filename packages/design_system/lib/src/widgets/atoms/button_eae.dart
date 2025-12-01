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

  // New properties for layout flexibility
  final Widget? trailing;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? contentPadding;

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
    this.trailing,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final elevatedButtonTheme = theme.elevatedButtonTheme.style;

    // Retrieve padding from theme or override
    double? themeHorizontalPadding;
    double? themeVerticalPadding;

    final resolvedPadding =
        contentPadding?.resolve(Directionality.of(context)) ??
            elevatedButtonTheme?.padding?.resolve({});

    if (resolvedPadding != null) {
      themeHorizontalPadding = resolvedPadding.horizontal / 2;
      themeVerticalPadding = resolvedPadding.vertical / 2;
    }

    // Size configuration
    final double minHeight;
    final double horizontalPadding;
    final double fontSize;
    final double iconSize;

    switch (size) {
      case ButtonEAESize.small:
        minHeight = 36;
        horizontalPadding =
            themeHorizontalPadding != null ? themeHorizontalPadding * 0.75 : 16;
        fontSize = 14;
        iconSize = 16;
        break;
      case ButtonEAESize.medium:
        minHeight = 48;
        horizontalPadding = themeHorizontalPadding ?? 24;
        fontSize = 16;
        iconSize = 20;
        break;
      case ButtonEAESize.large:
        minHeight = 56;
        horizontalPadding =
            themeHorizontalPadding != null ? themeHorizontalPadding * 1.25 : 32;
        fontSize = 18;
        iconSize = 24;
        break;
    }

    // Style configuration based on variant, unless overridden
    final Color effectiveBackgroundColor;
    final Color effectiveForegroundColor;
    final BorderSide? effectiveBorderSide;

    final bool isDisabled = onPressed == null;

    if (isDisabled) {
      // Disabled state logic
      // Use 'resolve' on the standard backgroundColor/foregroundColor properties with MaterialState.disabled
      effectiveBackgroundColor = elevatedButtonTheme?.backgroundColor
              ?.resolve({WidgetState.disabled}) ??
          theme.colorScheme.onSurface.withOpacity(0.12);

      effectiveForegroundColor = elevatedButtonTheme?.foregroundColor
              ?.resolve({WidgetState.disabled}) ??
          theme.colorScheme.onSurface.withOpacity(0.38);

      effectiveBorderSide = null;
    } else if (backgroundColor != null ||
        foregroundColor != null ||
        borderSide != null) {
      // Custom overrides
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
            mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: mainAxisAlignment,
            children: [
              // Content Group
              isFullWidth
                  ? Expanded(
                      child: _buildInnerContent(mainAxisAlignment, icon,
                          iconSize, effectiveForegroundColor, label, fontSize),
                    )
                  : Flexible(
                      child: _buildInnerContent(mainAxisAlignment, icon,
                          iconSize, effectiveForegroundColor, label, fontSize),
                    ),

              if (trailing != null) ...[
                if (mainAxisAlignment != MainAxisAlignment.spaceBetween)
                  const SizedBox(width: 8),
                trailing!,
              ],
            ],
          );

    final double elevation = elevatedButtonTheme?.elevation?.resolve({}) ?? 0.0;
    final Color? shadowColor = elevatedButtonTheme?.shadowColor?.resolve({});

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: Material(
        color: effectiveBackgroundColor,
        elevation: isDisabled ? 0.0 : elevation, // No elevation when disabled
        shadowColor: shadowColor,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: (isLoading || isDisabled) ? null : onPressed,
          borderRadius: BorderRadius.circular(999),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: themeVerticalPadding ?? 0,
            ),
            constraints: BoxConstraints(
                minHeight: themeVerticalPadding != null ? 0 : minHeight),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: effectiveBorderSide != null
                  ? Border.fromBorderSide(effectiveBorderSide)
                  : null,
            ),
            child: buttonContent,
          ),
        ),
      ),
    );
  }

  Widget _buildInnerContent(
    MainAxisAlignment mainAxisAlignment,
    IconData? icon,
    double iconSize,
    Color effectiveForegroundColor,
    String label,
    double fontSize,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment == MainAxisAlignment.center
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(icon, size: iconSize, color: effectiveForegroundColor),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: effectiveForegroundColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

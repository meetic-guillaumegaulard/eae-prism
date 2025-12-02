import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';

class ProgressBarEAE extends StatelessWidget {
  final int min;
  final int max;
  final int value;
  final bool showCounter;
  final Color? activeColor;
  final Gradient? activeGradient;
  final Color? inactiveColor;
  final Color? counterTextColor;
  final double? height;
  final double? borderRadius;

  const ProgressBarEAE({
    Key? key,
    required this.min,
    required this.max,
    required this.value,
    this.showCounter = true,
    this.activeColor,
    this.activeGradient,
    this.inactiveColor,
    this.counterTextColor,
    this.height,
    this.borderRadius,
  })  : assert(min < max, 'min must be less than max'),
        assert(value >= min && value <= max,
            'value must be between min and max'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progressBarTheme = theme.extension<BrandProgressBarTheme>();

    // Calculate progress percentage
    final progress = (value - min) / (max - min);

    // Effective colors, gradient and dimensions
    final effectiveActiveGradient =
        activeGradient ?? progressBarTheme?.activeGradient;
    final effectiveActiveColor =
        activeColor ?? progressBarTheme?.activeColor ?? colorScheme.primary;
    final effectiveInactiveColor = inactiveColor ??
        progressBarTheme?.inactiveColor ??
        Colors.grey.shade300;
    final effectiveCounterTextColor = counterTextColor ??
        progressBarTheme?.counterTextColor ??
        theme.textTheme.bodyMedium?.color ??
        Colors.black87;
    final effectiveHeight = height ?? progressBarTheme?.height ?? 8.0;
    final effectiveBorderRadius =
        borderRadius ?? progressBarTheme?.borderRadius ?? 4.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          child: SizedBox(
            height: effectiveHeight,
            child: Stack(
              children: [
                // Background (inactive track)
                Container(
                  decoration: BoxDecoration(
                    color: effectiveInactiveColor,
                    borderRadius: BorderRadius.circular(effectiveBorderRadius),
                  ),
                ),
                // Active track
                FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: effectiveActiveGradient == null
                          ? effectiveActiveColor
                          : null,
                      gradient: effectiveActiveGradient,
                      borderRadius:
                          BorderRadius.circular(effectiveBorderRadius),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Counter
        if (showCounter) ...[
          const SizedBox(height: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '$value/$max',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: effectiveCounterTextColor,
              ),
            ),
          ),
        ],
      ],
    );
  }
}


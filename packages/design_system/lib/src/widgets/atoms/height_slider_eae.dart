import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import '../../theme/brand_theme_extensions.dart';

/// Enum to define the measurement system
enum HeightMeasurementSystem {
  metric, // Centimeters
  imperial, // Feet and inches
}

/// A vertical slider for selecting height
/// Supports both metric (cm) and imperial (feet/inches) systems
class HeightSliderEAE extends StatefulWidget {
  /// Minimum height value (in cm for metric, in inches for imperial)
  final int minValue;

  /// Maximum height value (in cm for metric, in inches for imperial)
  final int maxValue;

  /// Initial height value (in cm for metric, in inches for imperial)
  final int? initialValue;

  /// Callback when height changes
  final ValueChanged<int>? onChanged;

  /// Measurement system to use
  final HeightMeasurementSystem measurementSystem;

  /// Height of the slider widget
  final double sliderHeight;

  /// Whether to show the current value label
  final bool showCurrentValue;

  /// Optional label for the slider
  final String? label;

  /// Number of steps/indicators to display on the scale
  /// If specified, this takes priority over scaleInterval
  final int? numberOfSteps;

  /// Interval for displaying marks on the scale (in cm or inches)
  /// Only used if numberOfSteps is not specified
  final int? scaleInterval;

  const HeightSliderEAE({
    Key? key,
    required this.minValue,
    required this.maxValue,
    this.initialValue,
    this.onChanged,
    this.measurementSystem = HeightMeasurementSystem.metric,
    this.sliderHeight = 400.0,
    this.showCurrentValue = true,
    this.label,
    this.numberOfSteps = 5,
    this.scaleInterval,
  }) : super(key: key);

  @override
  State<HeightSliderEAE> createState() => _HeightSliderEAEState();
}

class _HeightSliderEAEState extends State<HeightSliderEAE> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = (widget.initialValue ?? widget.minValue).toDouble();
  }

  @override
  void didUpdateWidget(HeightSliderEAE oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != null &&
        widget.initialValue != oldWidget.initialValue) {
      _currentValue = widget.initialValue!.toDouble();
    }
  }

  /// Converts total inches to feet and inches
  Map<String, int> _inchesToFeetInches(int totalInches) {
    final feet = totalInches ~/ 12;
    final inches = totalInches % 12;
    return {'feet': feet, 'inches': inches};
  }

  /// Formats the height value based on the measurement system
  String _formatHeight(int value) {
    if (widget.measurementSystem == HeightMeasurementSystem.metric) {
      return '$value cm';
    } else {
      final converted = _inchesToFeetInches(value);
      return '${converted['feet']}\' ${converted['inches']}"';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Get slider theme from theme extensions
    final sliderTheme = Theme.of(context).extension<BrandSliderTheme>() ??
        const BrandSliderTheme();

    final activeTrackColor =
        sliderTheme.activeTrackColor ?? colorScheme.primary;
    final inactiveTrackColor = sliderTheme.inactiveTrackColor ??
        (sliderTheme.activeTrackColor ?? colorScheme.primary).withOpacity(0.3);
    final thumbColor = sliderTheme.thumbColor ?? colorScheme.primary;
    final overlayColor = sliderTheme.overlayColor ??
        (sliderTheme.thumbColor ?? colorScheme.primary).withOpacity(0.2);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (widget.showCurrentValue)
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              _formatHeight(_currentValue.round()),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: activeTrackColor,
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scale marks on the left
            Padding(
              padding: EdgeInsets.symmetric(vertical: sliderTheme.thumbRadius),
              child: _buildScale(colorScheme),
            ),
            const SizedBox(width: 16),
            // Vertical slider
            SizedBox(
              height: widget.sliderHeight,
              child: RotatedBox(
                quarterTurns: 3,
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: sliderTheme.trackHeight,
                    thumbShape: _buildThumbShape(sliderTheme),
                    overlayShape: RoundSliderOverlayShape(
                        overlayRadius: sliderTheme.overlayRadius),
                    activeTrackColor: activeTrackColor,
                    inactiveTrackColor: inactiveTrackColor,
                    thumbColor: thumbColor,
                    overlayColor: overlayColor,
                    showValueIndicator: ShowValueIndicator.never,
                    trackShape: const RoundedRectSliderTrackShape(),
                  ),
                  child: Slider(
                    value: _currentValue,
                    min: widget.minValue.toDouble(),
                    max: widget.maxValue.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        _currentValue = value;
                      });
                      widget.onChanged?.call(value.round());
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  SliderComponentShape _buildThumbShape(BrandSliderTheme sliderTheme) {
    return HeightSliderThumbShape(
      thumbRadius: sliderTheme.thumbRadius,
      elevation: sliderTheme.thumbElevation,
      shadowColor: sliderTheme.thumbShadowColor ?? Colors.black26,
      borderWidth: sliderTheme.thumbBorderWidth,
      borderColor: sliderTheme.thumbBorderColor,
      lineLength: 40.0,
      lineHeight: 6.0,
    );
  }

  Widget _buildScale(ColorScheme colorScheme) {
    // Generate scale marks
    final range = widget.maxValue - widget.minValue;

    // Calculate number of marks and interval
    late final int numberOfMarks;
    late final double interval;

    if (widget.numberOfSteps != null) {
      // Use numberOfSteps if specified
      numberOfMarks = widget.numberOfSteps!;
      interval = range / (numberOfMarks - 1);
    } else if (widget.scaleInterval != null) {
      // Use scaleInterval if specified
      interval = widget.scaleInterval!.toDouble();
      numberOfMarks = (range / interval).floor() + 1;
    } else {
      // Default: 5 steps
      numberOfMarks = 5;
      interval = range / (numberOfMarks - 1);
    }

    return Container(
      height: widget.sliderHeight,
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(numberOfMarks, (index) {
          // Scale goes from max to min (top to bottom)
          final value = (widget.maxValue - (index * interval)).round();
          if (value < widget.minValue) return const SizedBox.shrink();

          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _formatHeight(value),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 12,
                height: 2,
                color: colorScheme.onSurface.withOpacity(0.3),
              ),
            ],
          );
        }),
      ),
    );
  }
}

/// Custom slider thumb shape with horizontal line pointing left (for vertical height slider)
class HeightSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double elevation;
  final Color shadowColor;
  final double? borderWidth;
  final Color? borderColor;
  final double lineLength;
  final double lineHeight;

  const HeightSliderThumbShape({
    required this.thumbRadius,
    this.elevation = 4.0,
    this.shadowColor = Colors.black26,
    this.borderWidth,
    this.borderColor,
    this.lineLength = 40.0,
    this.lineHeight = 6.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final thumbColor = sliderTheme.thumbColor ?? Colors.white;

    // Create a combined path for shadow: circle + line
    if (elevation > 0) {
      final shadowPath = Path();

      // Add circle
      shadowPath.addOval(Rect.fromCircle(center: center, radius: thumbRadius));

      // Add line rectangle (pointing up in canvas coords, which becomes left after rotation)
      final lineRect = RRect.fromRectAndRadius(
        Rect.fromLTRB(
          center.dx - lineHeight / 2,
          center.dy - lineLength,
          center.dx + lineHeight / 2,
          center.dy,
        ),
        Radius.circular(lineHeight / 2),
      );
      shadowPath.addRRect(lineRect);

      canvas.drawShadow(shadowPath, shadowColor, elevation, true);
    }

    // Draw the horizontal line pointing up (will be left after rotation)
    final linePaint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    final lineRect = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        center.dx - lineHeight / 2,
        center.dy - lineLength,
        center.dx + lineHeight / 2,
        center.dy,
      ),
      Radius.circular(lineHeight / 2),
    );
    canvas.drawRRect(lineRect, linePaint);

    // Draw thumb circle
    final thumbPaint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, thumbPaint);

    // Draw border on circle if specified
    if (borderWidth != null && borderWidth! > 0 && borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth!;

      canvas.drawCircle(center, thumbRadius, borderPaint);
    }
  }
}

@Preview(name: 'Height Slider EAE')
Widget preview() {
  return HeightSliderEAE(
    minValue: 100,
    maxValue: 200,
    initialValue: 150,
  );
}

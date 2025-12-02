import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';

/// Custom slider thumb shape with shadow support
class ShadowSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  final double elevation;
  final Color shadowColor;
  final double? borderWidth;
  final Color? borderColor;

  const ShadowSliderThumbShape({
    required this.thumbRadius,
    this.elevation = 4.0,
    this.shadowColor = Colors.black26,
    this.borderWidth,
    this.borderColor,
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

    // Draw shadow if elevation > 0
    if (elevation > 0) {
      final shadowPath = Path()
        ..addOval(Rect.fromCircle(center: center, radius: thumbRadius));
      canvas.drawShadow(shadowPath, shadowColor, elevation, true);
    }

    // Draw thumb
    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    // Draw border if specified
    if (borderWidth != null && borderWidth! > 0 && borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth!;

      canvas.drawCircle(center, thumbRadius, borderPaint);
    }
  }
}

/// Custom range slider thumb shape with shadow support
class ShadowRangeSliderThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
  final double elevation;
  final Color shadowColor;
  final double? borderWidth;
  final Color? borderColor;

  const ShadowRangeSliderThumbShape({
    required this.thumbRadius,
    this.elevation = 4.0,
    this.shadowColor = Colors.black26,
    this.borderWidth,
    this.borderColor,
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
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    TextDirection? textDirection,
    required SliderThemeData sliderTheme,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    // Draw shadow if elevation > 0
    if (elevation > 0) {
      final shadowPath = Path()
        ..addOval(Rect.fromCircle(center: center, radius: thumbRadius));
      canvas.drawShadow(shadowPath, shadowColor, elevation, true);
    }

    // Draw thumb
    final paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    // Draw border if specified
    if (borderWidth != null && borderWidth! > 0 && borderColor != null) {
      final borderPaint = Paint()
        ..color = borderColor!
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth!;

      canvas.drawCircle(center, thumbRadius, borderPaint);
    }
  }
}

enum SliderEAEMode {
  single,
  range,
}

class SliderEAE extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int? initialValue; // Pour le mode single
  final RangeValues? initialRange; // Pour le mode range
  final SliderEAEMode mode;
  final ValueChanged<int>? onChanged; // Pour le mode single
  final ValueChanged<RangeValues>? onRangeChanged; // Pour le mode range
  final bool showLabels;
  final String? label;
  final bool showMinMaxLabels;

  const SliderEAE.single({
    Key? key,
    required this.minValue,
    required this.maxValue,
    this.initialValue,
    this.onChanged,
    this.showLabels = true,
    this.label,
    this.showMinMaxLabels = true,
  })  : mode = SliderEAEMode.single,
        initialRange = null,
        onRangeChanged = null,
        super(key: key);

  const SliderEAE.range({
    Key? key,
    required this.minValue,
    required this.maxValue,
    this.initialRange,
    this.onRangeChanged,
    this.showLabels = true,
    this.label,
    this.showMinMaxLabels = true,
  })  : mode = SliderEAEMode.range,
        initialValue = null,
        onChanged = null,
        super(key: key);

  @override
  State<SliderEAE> createState() => _SliderEAEState();
}

class _SliderEAEState extends State<SliderEAE> {
  late double _currentValue;
  late RangeValues _currentRange;

  @override
  void initState() {
    super.initState();

    if (widget.mode == SliderEAEMode.single) {
      _currentValue = (widget.initialValue ?? widget.minValue).toDouble();
    } else {
      _currentRange = widget.initialRange ??
          RangeValues(
            widget.minValue.toDouble(),
            widget.maxValue.toDouble(),
          );
    }
  }

  @override
  void didUpdateWidget(SliderEAE oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.mode == SliderEAEMode.single) {
      if (widget.initialValue != null &&
          widget.initialValue != oldWidget.initialValue) {
        _currentValue = widget.initialValue!.toDouble();
      }
    } else {
      if (widget.initialRange != null &&
          widget.initialRange != oldWidget.initialRange) {
        _currentRange = widget.initialRange!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
        ],
        if (widget.mode == SliderEAEMode.single)
          _buildSingleSlider(colorScheme)
        else
          _buildRangeSlider(colorScheme),
      ],
    );
  }

  Widget _buildSingleSlider(ColorScheme colorScheme) {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabels)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${_currentValue.round()}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: activeTrackColor,
              ),
            ),
          ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: sliderTheme.trackHeight,
            thumbShape: (sliderTheme.thumbElevation > 0 ||
                    sliderTheme.thumbBorderWidth > 0)
                ? ShadowSliderThumbShape(
                    thumbRadius: sliderTheme.thumbRadius,
                    elevation: sliderTheme.thumbElevation,
                    shadowColor: sliderTheme.thumbShadowColor ?? Colors.black26,
                    borderWidth: sliderTheme.thumbBorderWidth,
                    borderColor: sliderTheme.thumbBorderColor,
                  )
                : RoundSliderThumbShape(
                    enabledThumbRadius: sliderTheme.thumbRadius),
            overlayShape: RoundSliderOverlayShape(
                overlayRadius: sliderTheme.overlayRadius),
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: thumbColor,
            overlayColor: overlayColor,
            showValueIndicator: ShowValueIndicator.never,
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
        if (widget.showMinMaxLabels)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.minValue}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                Text(
                  '${widget.maxValue}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRangeSlider(ColorScheme colorScheme) {
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
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showLabels)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              '${_currentRange.start.round()} - ${_currentRange.end.round()}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: activeTrackColor,
              ),
            ),
          ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: sliderTheme.trackHeight,
            thumbShape: (sliderTheme.thumbElevation > 0 ||
                    sliderTheme.thumbBorderWidth > 0)
                ? ShadowSliderThumbShape(
                    thumbRadius: sliderTheme.thumbRadius,
                    elevation: sliderTheme.thumbElevation,
                    shadowColor: sliderTheme.thumbShadowColor ?? Colors.black26,
                    borderWidth: sliderTheme.thumbBorderWidth,
                    borderColor: sliderTheme.thumbBorderColor,
                  )
                : RoundSliderThumbShape(
                    enabledThumbRadius: sliderTheme.thumbRadius),
            overlayShape: RoundSliderOverlayShape(
                overlayRadius: sliderTheme.overlayRadius),
            activeTrackColor: activeTrackColor,
            inactiveTrackColor: inactiveTrackColor,
            thumbColor: thumbColor,
            overlayColor: overlayColor,
            showValueIndicator: ShowValueIndicator.never,
            rangeThumbShape: (sliderTheme.thumbElevation > 0 ||
                    sliderTheme.thumbBorderWidth > 0)
                ? ShadowRangeSliderThumbShape(
                    thumbRadius: sliderTheme.thumbRadius,
                    elevation: sliderTheme.thumbElevation,
                    shadowColor: sliderTheme.thumbShadowColor ?? Colors.black26,
                    borderWidth: sliderTheme.thumbBorderWidth,
                    borderColor: sliderTheme.thumbBorderColor,
                  )
                : RoundRangeSliderThumbShape(
                    enabledThumbRadius: sliderTheme.thumbRadius),
            rangeTrackShape: const RoundedRectRangeSliderTrackShape(),
          ),
          child: RangeSlider(
            values: _currentRange,
            min: widget.minValue.toDouble(),
            max: widget.maxValue.toDouble(),
            onChanged: (values) {
              setState(() {
                _currentRange = values;
              });
              widget.onRangeChanged?.call(values);
            },
          ),
        ),
        if (widget.showMinMaxLabels)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.minValue}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                Text(
                  '${widget.maxValue}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

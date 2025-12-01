import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';

class CheckboxEAE extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxEAE({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final checkboxTheme = theme.extension<BrandCheckboxTheme>();
    
    // Default fallback values
    final activeColor = checkboxTheme?.activeColor ?? theme.colorScheme.primary;
    final checkColor = checkboxTheme?.checkColor ?? theme.colorScheme.onPrimary;
    final backgroundColor = checkboxTheme?.backgroundColor ?? activeColor;
    final borderRadius = checkboxTheme?.borderRadius ?? 4.0;
    
    // Determine border width based on selection state
    final borderWidth = value 
        ? (checkboxTheme?.selectedBorderWidth ?? 2.0) 
        : (checkboxTheme?.borderWidth ?? 2.0);
        
    final checkStrokeWidth = checkboxTheme?.checkStrokeWidth ?? 2.0;

    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: value ? backgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: value ? activeColor : (theme.brightness == Brightness.light ? Colors.grey[400]! : Colors.white70),
            width: borderWidth,
          ),
        ),
        child: value
            ? CustomPaint(
                painter: _CheckPainter(
                  color: checkColor,
                  strokeWidth: checkStrokeWidth,
                ),
              )
            : null,
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  _CheckPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    
    final w = size.width;
    final h = size.height;
    
    path.moveTo(w * 0.25, h * 0.52);
    path.lineTo(w * 0.42, h * 0.69);
    path.lineTo(w * 0.75, h * 0.31);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CheckPainter oldDelegate) =>
      color != oldDelegate.color || strokeWidth != oldDelegate.strokeWidth;
}

import 'package:flutter/material.dart';
import '../theme/brand_theme_extensions.dart';

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
    final borderWidth = checkboxTheme?.borderWidth ?? 2.0;

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
            ? Icon(
                Icons.check,
                size: 16,
                color: checkColor,
              )
            : null,
      ),
    );
  }
}


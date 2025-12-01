import 'package:flutter/material.dart';
import '../theme/brand_theme_extensions.dart';

class RadioButtonEAE<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;

  const RadioButtonEAE({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radioTheme = theme.extension<BrandRadioButtonTheme>();
    
    final isSelected = value == groupValue;

    // Default fallback values
    final unselectedBorderColor = radioTheme?.unselectedBorderColor ?? Colors.grey;
    final selectedBorderColor = radioTheme?.selectedBorderColor ?? theme.colorScheme.primary;
    final selectedBackgroundColor = radioTheme?.selectedBackgroundColor ?? theme.colorScheme.primary;
    final dotColor = radioTheme?.dotColor ?? theme.colorScheme.onPrimary;
    final borderWidth = radioTheme?.borderWidth ?? 2.0;

    return InkWell(
      onTap: onChanged != null ? () => onChanged!(value) : null,
      customBorder: const CircleBorder(),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? selectedBackgroundColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? selectedBorderColor : unselectedBorderColor,
            width: borderWidth,
          ),
        ),
        child: isSelected
            ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}


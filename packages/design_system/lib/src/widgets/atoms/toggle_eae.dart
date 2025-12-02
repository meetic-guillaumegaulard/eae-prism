import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';

class ToggleEAE extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const ToggleEAE({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final toggleTheme = theme.extension<BrandToggleTheme>();

    // Default fallback values
    final activeTrackColor =
        toggleTheme?.activeTrackColor ?? theme.colorScheme.primary;
    final inactiveTrackColor =
        toggleTheme?.inactiveTrackColor ?? Colors.grey[300]!;
    final activeKnobColor = toggleTheme?.activeKnobColor ?? Colors.white;
    final inactiveKnobColor = toggleTheme?.inactiveKnobColor ?? Colors.white;
    final trackWidth = toggleTheme?.trackWidth ?? 52.0;
    final trackHeight = toggleTheme?.trackHeight ?? 32.0;
    final knobSize = toggleTheme?.knobSize ?? 28.0;
    final borderWidth = toggleTheme?.borderWidth ?? 0.0;
    final activeBorderColor = toggleTheme?.activeBorderColor;
    final inactiveBorderColor = toggleTheme?.inactiveBorderColor;

    final knobPadding = (trackHeight - knobSize) / 2;

    return GestureDetector(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: trackWidth,
        height: trackHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(trackHeight / 2),
          color: value ? activeTrackColor : inactiveTrackColor,
          border: borderWidth > 0
              ? Border.all(
                  color: value
                      ? (activeBorderColor ?? activeTrackColor)
                      : (inactiveBorderColor ?? inactiveTrackColor),
                  width: borderWidth,
                )
              : null,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: EdgeInsets.all(knobPadding),
            width: knobSize,
            height: knobSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? activeKnobColor : inactiveKnobColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


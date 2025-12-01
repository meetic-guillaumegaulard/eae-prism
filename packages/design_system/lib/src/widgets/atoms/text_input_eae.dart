import 'package:flutter/material.dart';
import '../../theme/brand_theme_extensions.dart';

class TextInputEAE extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;

  const TextInputEAE({
    Key? key,
    this.label,
    this.hintText,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.extension<BrandInputTheme>();

    // Determine if we need to override the filled state for error
    final isError = errorText != null;
    final errorFillColor = inputTheme?.errorFillColor;
    final shouldFillOnError = isError && errorFillColor != null;

    // Determine effective fill color
    // If we are in error state and have a specific error fill color, use it.
    // Otherwise, rely on the default theme behavior (InputDecorationTheme).
    // However, InputDecorationTheme doesn't support "errorFillColor", only "fillColor".
    // So we must manually override fillColor in InputDecoration if needed.

    final effectiveFillColor = shouldFillOnError ? errorFillColor : null;
    final effectiveFilled = shouldFillOnError ? true : null;
    
    // Check if we have custom label padding
    final inputConfig = inputTheme?.labelPadding;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null && inputConfig != null) ...[
          Padding(
            padding: inputConfig,
            child: Text(
              label!,
              style: theme.inputDecorationTheme.labelStyle,
            ),
          ),
          TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: obscureText,
            enabled: enabled,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: effectiveFilled,
              fillColor: effectiveFillColor,
            ),
          ),
        ] else
          TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            obscureText: obscureText,
            enabled: enabled,
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              labelText: label,
              hintText: hintText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              filled: effectiveFilled,
              fillColor: effectiveFillColor,
            ),
          ),
      ],
    );
  }
}

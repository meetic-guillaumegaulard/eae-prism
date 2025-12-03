import 'package:flutter/material.dart';
import '../form_state_manager.dart';

/// A widget that connects a form field to the FormStateManager
class FormFieldWidget<T> extends StatefulWidget {
  final String? field;
  final FormStateManager formState;
  final T defaultValue;
  final Widget Function(T value, ValueChanged<T> onChanged) builder;

  const FormFieldWidget({
    super.key,
    required this.field,
    required this.formState,
    required this.defaultValue,
    required this.builder,
  });

  @override
  State<FormFieldWidget<T>> createState() => _FormFieldWidgetState<T>();
}

class _FormFieldWidgetState<T> extends State<FormFieldWidget<T>> {
  late T _value;

  @override
  void initState() {
    super.initState();
    // Initialize with existing value from formState or default
    if (widget.field != null) {
      final existingValue = widget.formState.getValue<T>(widget.field!);
      _value = existingValue ?? widget.defaultValue;
      // Set initial value in formState
      widget.formState.setValue(widget.field!, _value);
    } else {
      _value = widget.defaultValue;
    }

    // Listen to changes from formState
    widget.formState.addListener(_onFormStateChanged);
  }

  @override
  void dispose() {
    widget.formState.removeListener(_onFormStateChanged);
    super.dispose();
  }

  void _onFormStateChanged() {
    if (widget.field != null) {
      final newValue = widget.formState.getValue<T>(widget.field!);
      if (newValue != null && newValue != _value) {
        setState(() {
          _value = newValue;
        });
      }
    }
  }

  void _onValueChanged(T newValue) {
    setState(() {
      _value = newValue;
    });
    if (widget.field != null) {
      widget.formState.setValue(widget.field!, newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(_value, _onValueChanged);
  }
}


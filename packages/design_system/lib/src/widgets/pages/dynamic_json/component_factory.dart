import 'package:flutter/material.dart';
import 'component_config.dart';
import 'form_state_manager.dart';
import '../../atoms/button_eae.dart';
import '../../atoms/text_eae.dart';
import '../../atoms/text_input_eae.dart';
import '../../atoms/checkbox_eae.dart';
import '../../atoms/radio_button_eae.dart';
import '../../atoms/toggle_eae.dart';
import '../../atoms/height_slider_eae.dart';
import '../../atoms/linked_text_eae.dart';
import '../../atoms/tag_eae.dart';
import '../../atoms/progress_bar_eae.dart';
import '../../atoms/selectable_button_eae.dart';
import '../../molecules/labeled_control_eae.dart';
import '../../molecules/selection_group_eae.dart';
import '../../molecules/selectable_button_group_eae.dart';
import '../../molecules/selectable_tag_group_eae.dart';

/// Factory class to build Flutter widgets from ComponentConfig
class ComponentFactory {
  /// Form state manager to automatically collect values
  final FormStateManager formState;

  /// Map of action callbacks that can be referenced by name (for buttons)
  final Map<String, VoidCallback> actions;

  const ComponentFactory({
    required this.formState,
    this.actions = const {},
  });

  /// Build a widget from a ComponentConfig
  Widget build(ComponentConfig config) {
    switch (config.type.toLowerCase()) {
      // Layout components
      case 'column':
        return _buildColumn(config);
      case 'row':
        return _buildRow(config);
      case 'container':
        return _buildContainer(config);
      case 'padding':
        return _buildPadding(config);
      case 'center':
        return _buildCenter(config);
      case 'expanded':
        return _buildExpanded(config);
      case 'sizedbox':
      case 'sized_box':
        return _buildSizedBox(config);
      case 'spacer':
        return _buildSpacer(config);

      // Atoms
      case 'button':
        return _buildButton(config);
      case 'text':
        return _buildText(config);
      case 'text_input':
        return _buildTextInput(config);
      case 'checkbox':
        return _buildCheckbox(config);
      case 'radio_button':
        return _buildRadioButton(config);
      case 'toggle':
        return _buildToggle(config);
      case 'height_slider':
        return _buildHeightSlider(config);
      case 'linked_text':
        return _buildLinkedText(config);
      case 'tag':
        return _buildTag(config);
      case 'progress_bar':
        return _buildProgressBar(config);
      case 'selectable_button':
        return _buildSelectableButton(config);

      // Molecules
      case 'labeled_control':
        return _buildLabeledControl(config);
      case 'selection_group':
        return _buildSelectionGroup(config);
      case 'selectable_button_group':
        return _buildSelectableButtonGroup(config);
      case 'selectable_tag_group':
        return _buildSelectableTagGroup(config);

      default:
        return _buildError('Unknown component type: ${config.type}');
    }
  }

  /// Build children widgets from a list of configs
  List<Widget> _buildChildren(List<ComponentConfig>? configs) {
    if (configs == null || configs.isEmpty) return [];
    return configs.map((config) => build(config)).toList();
  }

  // ============================================================================
  // LAYOUT COMPONENTS
  // ============================================================================

  Widget _buildColumn(ComponentConfig config) {
    return Column(
      mainAxisAlignment: _parseMainAxisAlignment(
        config.getProp<String>('mainAxisAlignment'),
      ),
      crossAxisAlignment: _parseCrossAxisAlignment(
        config.getProp<String>('crossAxisAlignment'),
      ),
      mainAxisSize: config.getProp<String>('mainAxisSize') == 'min'
          ? MainAxisSize.min
          : MainAxisSize.max,
      children: _buildChildren(config.children),
    );
  }

  Widget _buildRow(ComponentConfig config) {
    return Row(
      mainAxisAlignment: _parseMainAxisAlignment(
        config.getProp<String>('mainAxisAlignment'),
      ),
      crossAxisAlignment: _parseCrossAxisAlignment(
        config.getProp<String>('crossAxisAlignment'),
      ),
      mainAxisSize: config.getProp<String>('mainAxisSize') == 'min'
          ? MainAxisSize.min
          : MainAxisSize.max,
      children: _buildChildren(config.children),
    );
  }

  Widget _buildContainer(ComponentConfig config) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = build(config.children!.first);
    }

    return Container(
      width: config.getProp<double>('width'),
      height: config.getProp<double>('height'),
      padding: _parseEdgeInsets(config.getProp<dynamic>('padding')),
      margin: _parseEdgeInsets(config.getProp<dynamic>('margin')),
      decoration: BoxDecoration(
        color: config.getProp<Color>('color'),
        borderRadius: BorderRadius.circular(
          config.getProp<double>('borderRadius') ?? 0.0,
        ),
      ),
      child: child,
    );
  }

  Widget _buildPadding(ComponentConfig config) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = build(config.children!.first);
    }

    return Padding(
      padding: _parseEdgeInsets(config.getProp<dynamic>('padding')) ??
          EdgeInsets.zero,
      child: child,
    );
  }

  Widget _buildCenter(ComponentConfig config) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = build(config.children!.first);
    }

    return Center(child: child);
  }

  Widget _buildExpanded(ComponentConfig config) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = build(config.children!.first);
    }

    return Expanded(
      flex: config.getProp<int>('flex') ?? 1,
      child: child ?? const SizedBox(),
    );
  }

  Widget _buildSizedBox(ComponentConfig config) {
    Widget? child;
    if (config.children != null && config.children!.isNotEmpty) {
      child = build(config.children!.first);
    }

    return SizedBox(
      width: config.getProp<double>('width'),
      height: config.getProp<double>('height'),
      child: child,
    );
  }

  Widget _buildSpacer(ComponentConfig config) {
    return Spacer(
      flex: config.getProp<int>('flex') ?? 1,
    );
  }

  // ============================================================================
  // ATOMS
  // ============================================================================

  Widget _buildButton(ComponentConfig config) {
    final actionName = config.getProp<String>('action');
    final callback = actionName != null ? actions[actionName] : null;

    return ButtonEAE(
      label: config.getProp<String>('label') ?? 'Button',
      onPressed: callback,
      variant: _parseButtonVariant(config.getProp<String>('variant')),
      size: _parseButtonSize(config.getProp<String>('size')),
      isLoading: config.getProp<bool>('isLoading') ?? false,
      isFullWidth: config.getProp<bool>('isFullWidth') ?? false,
      icon: _parseIconData(config.getProp<String>('icon')),
    );
  }

  Widget _buildText(ComponentConfig config) {
    return TextEAE(
      config.getProp<String>('text') ?? '',
      type: _parseTextType(config.getProp<String>('type')),
      color: config.getProp<Color>('color'),
      fontWeight: _parseFontWeight(config.getProp<String>('fontWeight')),
      textAlign: _parseTextAlign(config.getProp<String>('textAlign')),
      maxLines: config.getProp<int>('maxLines'),
      overflow: _parseTextOverflow(config.getProp<String>('overflow')),
    );
  }

  Widget _buildTextInput(ComponentConfig config) {
    final field = config.getProp<String>('field');
    
    return _FormField<String>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<String>('defaultValue') ?? '',
      builder: (value, onChanged) => TextInputEAE(
        label: config.getProp<String>('label'),
        hintText: config.getProp<String>('hintText'),
        obscureText: config.getProp<bool>('obscureText') ?? false,
        enabled: config.getProp<bool>('enabled') ?? true,
        errorText: config.getProp<String>('errorText'),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildCheckbox(ComponentConfig config) {
    final field = config.getProp<String>('field');
    
    return _FormField<bool>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (value, onChanged) => CheckboxEAE(
        value: value,
        onChanged: (v) => onChanged(v ?? false),
      ),
    );
  }

  Widget _buildRadioButton(ComponentConfig config) {
    final field = config.getProp<String>('field');
    final radioValue = config.getProp<String>('value') ?? '';
    
    return _FormField<String>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<String>('defaultValue') ?? '',
      builder: (groupValue, onChanged) => RadioButtonEAE<String>(
        value: radioValue,
        groupValue: groupValue,
        onChanged: (v) => onChanged(v ?? ''),
      ),
    );
  }

  Widget _buildToggle(ComponentConfig config) {
    final field = config.getProp<String>('field');
    
    return _FormField<bool>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (value, onChanged) => ToggleEAE(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildHeightSlider(ComponentConfig config) {
    final field = config.getProp<String>('field');
    final minValue = config.getProp<int>('minValue') ?? 140;
    final maxValue = config.getProp<int>('maxValue') ?? 220;
    
    return _FormField<int>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<int>('defaultValue') ?? 170,
      builder: (value, onChanged) => HeightSliderEAE(
        minValue: minValue,
        maxValue: maxValue,
        initialValue: value,
        onChanged: onChanged,
        label: config.getProp<String>('label'),
        showCurrentValue: config.getProp<bool>('showCurrentValue') ?? true,
      ),
    );
  }

  Widget _buildLinkedText(ComponentConfig config) {
    return LinkedTextEAE(
      htmlText: config.getProp<String>('htmlText') ?? config.getProp<String>('text') ?? '',
      textAlign: _parseTextAlign(config.getProp<String>('textAlign')) ?? TextAlign.start,
    );
  }

  Widget _buildTag(ComponentConfig config) {
    final field = config.getProp<String>('field');
    
    if (field != null) {
      return _FormField<bool>(
        field: field,
        formState: formState,
        defaultValue: config.getProp<bool>('defaultValue') ?? false,
        builder: (isSelected, onChanged) => TagEAE(
          label: config.getProp<String>('label') ?? 'Tag',
          isSelected: isSelected,
          onSelectedChanged: onChanged,
          size: _parseTagSize(config.getProp<String>('size')),
        ),
      );
    }
    
    return TagEAE(
      label: config.getProp<String>('label') ?? 'Tag',
      size: _parseTagSize(config.getProp<String>('size')),
    );
  }

  Widget _buildProgressBar(ComponentConfig config) {
    final value = config.getProp<int>('value') ?? 
                  ((config.getProp<double>('progress') ?? 0.0) * 100).toInt();
    
    return ProgressBarEAE(
      min: config.getProp<int>('min') ?? 0,
      max: config.getProp<int>('max') ?? 100,
      value: value,
      showCounter: config.getProp<bool>('showPercentage') ?? config.getProp<bool>('showCounter') ?? true,
    );
  }

  Widget _buildSelectableButton(ComponentConfig config) {
    final field = config.getProp<String>('field');
    
    return _FormField<bool>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (isSelected, onChanged) => SelectableButtonEAE(
        label: config.getProp<String>('label') ?? 'Button',
        isSelected: isSelected,
        onChanged: onChanged,
        size: _parseButtonSize(config.getProp<String>('size')),
        isFullWidth: config.getProp<bool>('isFullWidth') ?? false,
      ),
    );
  }

  // ============================================================================
  // MOLECULES
  // ============================================================================

  Widget _buildLabeledControl(ComponentConfig config) {
    final field = config.getProp<String>('field');
    final controlTypeStr = config.getProp<String>('controlType');
    final controlType = controlTypeStr == 'toggle' 
        ? ControlType.toggle 
        : ControlType.checkbox;

    return _FormField<bool>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<bool>('defaultValue') ?? false,
      builder: (value, onChanged) => LabeledControlEAE(
        htmlLabel: config.getProp<String>('htmlLabel') ?? config.getProp<String>('label') ?? '',
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        controlType: controlType,
        expanded: config.getProp<bool>('expanded') ?? true,
      ),
    );
  }

  Widget _buildSelectionGroup(ComponentConfig config) {
    final field = config.getProp<String>('field');
    final typeStr = config.getProp<String>('selectionType') ?? 'checkbox';
    final selectionType = typeStr == 'radio' 
        ? SelectionType.radio 
        : SelectionType.checkbox;

    // Parse options from labels array
    final labels = config.getProp<List<dynamic>>('labels')?.cast<String>() ?? [];
    final options = labels.map((label) => 
      SelectionOption<String>(label: label, value: label)
    ).toList();

    if (selectionType == SelectionType.radio) {
      return _FormField<String>(
        field: field,
        formState: formState,
        defaultValue: config.getProp<String>('defaultValue') ?? '',
        builder: (selectedValue, onChanged) => SelectionGroupEAE<String>(
          options: options,
          selectionType: selectionType,
          selectedValue: selectedValue,
          onRadioChanged: (value) => onChanged(value ?? ''),
          spacing: config.getProp<double>('spacing') ?? 8.0,
        ),
      );
    } else {
      final defaultValues = config.getProp<List<dynamic>>('defaultValue')?.cast<String>() ?? [];
      
      return _FormField<List<String>>(
        field: field,
        formState: formState,
        defaultValue: defaultValues,
        builder: (selectedValues, onChanged) => SelectionGroupEAE<String>(
          options: options,
          selectionType: selectionType,
          selectedValues: selectedValues,
          onCheckboxChanged: onChanged,
          spacing: config.getProp<double>('spacing') ?? 8.0,
        ),
      );
    }
  }

  Widget _buildSelectableButtonGroup(ComponentConfig config) {
    final field = config.getProp<String>('field');
    final labels = config.getProp<List<dynamic>>('labels')?.cast<String>() ?? [];
    final options = labels.map((label) => 
      SelectableButtonOption<String>(label: label, value: label)
    ).toList();

    return _FormField<String>(
      field: field,
      formState: formState,
      defaultValue: config.getProp<String>('defaultValue') ?? '',
      builder: (selectedValue, onChanged) => SelectableButtonGroupEAE<String>(
        options: options,
        selectedValue: selectedValue,
        onChanged: onChanged,
        spacing: config.getProp<double>('spacing') ?? 8.0,
        size: _parseButtonSize(config.getProp<String>('size')),
      ),
    );
  }

  Widget _buildSelectableTagGroup(ComponentConfig config) {
    final field = config.getProp<String>('field');
    final labels = config.getProp<List<dynamic>>('labels')?.cast<String>() ?? [];
    
    // Convert labels to tag options
    final options = labels.map((label) => 
      TagOption<String>(label: label, value: label)
    ).toList();
    
    // Create a single group
    final group = TagGroup<String>(
      title: config.getProp<String>('title') ?? '',
      options: options,
    );

    final defaultValues = config.getProp<List<dynamic>>('defaultValue')?.cast<String>() ?? [];

    return _FormField<List<String>>(
      field: field,
      formState: formState,
      defaultValue: defaultValues,
      builder: (selectedValues, onChanged) => SelectableTagGroupEAE<String>(
        groups: [group],
        initialSelectedValues: selectedValues,
        onSelectionChanged: onChanged,
        tagSize: _parseTagSize(config.getProp<String>('tagSize')),
        tagSpacing: config.getProp<double>('tagSpacing') ?? 8.0,
      ),
    );
  }

  // ============================================================================
  // ERROR WIDGET
  // ============================================================================

  Widget _buildError(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.red.withOpacity(0.1),
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  // ============================================================================
  // PARSING HELPERS
  // ============================================================================

  MainAxisAlignment _parseMainAxisAlignment(String? value) {
    switch (value?.toLowerCase()) {
      case 'start':
        return MainAxisAlignment.start;
      case 'end':
        return MainAxisAlignment.end;
      case 'center':
        return MainAxisAlignment.center;
      case 'spacebetween':
      case 'space_between':
        return MainAxisAlignment.spaceBetween;
      case 'spacearound':
      case 'space_around':
        return MainAxisAlignment.spaceAround;
      case 'spaceevenly':
      case 'space_evenly':
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.start;
    }
  }

  CrossAxisAlignment _parseCrossAxisAlignment(String? value) {
    switch (value?.toLowerCase()) {
      case 'start':
        return CrossAxisAlignment.start;
      case 'end':
        return CrossAxisAlignment.end;
      case 'center':
        return CrossAxisAlignment.center;
      case 'stretch':
        return CrossAxisAlignment.stretch;
      case 'baseline':
        return CrossAxisAlignment.baseline;
      default:
        return CrossAxisAlignment.center;
    }
  }

  EdgeInsetsGeometry? _parseEdgeInsets(dynamic value) {
    if (value == null) return null;
    if (value is num) {
      return EdgeInsets.all(value.toDouble());
    }
    if (value is Map) {
      return EdgeInsets.only(
        left: (value['left'] as num?)?.toDouble() ?? 0,
        top: (value['top'] as num?)?.toDouble() ?? 0,
        right: (value['right'] as num?)?.toDouble() ?? 0,
        bottom: (value['bottom'] as num?)?.toDouble() ?? 0,
      );
    }
    return null;
  }

  ButtonEAEVariant _parseButtonVariant(String? value) {
    switch (value?.toLowerCase()) {
      case 'primary':
        return ButtonEAEVariant.primary;
      case 'secondary':
        return ButtonEAEVariant.secondary;
      case 'outline':
        return ButtonEAEVariant.outline;
      default:
        return ButtonEAEVariant.primary;
    }
  }

  ButtonEAESize _parseButtonSize(String? value) {
    switch (value?.toLowerCase()) {
      case 'small':
        return ButtonEAESize.small;
      case 'medium':
        return ButtonEAESize.medium;
      case 'large':
        return ButtonEAESize.large;
      default:
        return ButtonEAESize.medium;
    }
  }

  TagEAESize _parseTagSize(String? value) {
    switch (value?.toLowerCase()) {
      case 'small':
        return TagEAESize.small;
      case 'medium':
        return TagEAESize.medium;
      case 'large':
        return TagEAESize.large;
      default:
        return TagEAESize.medium;
    }
  }

  TextTypeEAE _parseTextType(String? value) {
    switch (value?.toLowerCase()) {
      case 'displaylarge':
      case 'display_large':
        return TextTypeEAE.displayLarge;
      case 'displaymedium':
      case 'display_medium':
        return TextTypeEAE.displayMedium;
      case 'displaysmall':
      case 'display_small':
        return TextTypeEAE.displaySmall;
      case 'headlinelarge':
      case 'headline_large':
        return TextTypeEAE.headlineLarge;
      case 'headlinemedium':
      case 'headline_medium':
        return TextTypeEAE.headlineMedium;
      case 'headlinesmall':
      case 'headline_small':
        return TextTypeEAE.headlineSmall;
      case 'titlelarge':
      case 'title_large':
        return TextTypeEAE.titleLarge;
      case 'titlemedium':
      case 'title_medium':
        return TextTypeEAE.titleMedium;
      case 'titlesmall':
      case 'title_small':
        return TextTypeEAE.titleSmall;
      case 'bodylarge':
      case 'body_large':
        return TextTypeEAE.bodyLarge;
      case 'bodymedium':
      case 'body_medium':
        return TextTypeEAE.bodyMedium;
      case 'bodysmall':
      case 'body_small':
        return TextTypeEAE.bodySmall;
      case 'labellarge':
      case 'label_large':
        return TextTypeEAE.labelLarge;
      case 'labelmedium':
      case 'label_medium':
        return TextTypeEAE.labelMedium;
      case 'labelsmall':
      case 'label_small':
        return TextTypeEAE.labelSmall;
      default:
        return TextTypeEAE.bodyMedium;
    }
  }

  FontWeight? _parseFontWeight(String? value) {
    switch (value?.toLowerCase()) {
      case 'thin':
        return FontWeight.w100;
      case 'extralight':
        return FontWeight.w200;
      case 'light':
        return FontWeight.w300;
      case 'normal':
        return FontWeight.w400;
      case 'medium':
        return FontWeight.w500;
      case 'semibold':
        return FontWeight.w600;
      case 'bold':
        return FontWeight.w700;
      case 'extrabold':
        return FontWeight.w800;
      case 'black':
        return FontWeight.w900;
      default:
        return null;
    }
  }

  TextAlign? _parseTextAlign(String? value) {
    switch (value?.toLowerCase()) {
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      case 'justify':
        return TextAlign.justify;
      case 'start':
        return TextAlign.start;
      case 'end':
        return TextAlign.end;
      default:
        return null;
    }
  }

  TextOverflow? _parseTextOverflow(String? value) {
    switch (value?.toLowerCase()) {
      case 'clip':
        return TextOverflow.clip;
      case 'fade':
        return TextOverflow.fade;
      case 'ellipsis':
        return TextOverflow.ellipsis;
      case 'visible':
        return TextOverflow.visible;
      default:
        return null;
    }
  }

  IconData? _parseIconData(String? value) {
    if (value == null) return null;
    // Simple icon name mapping - can be extended
    switch (value.toLowerCase()) {
      case 'add':
        return Icons.add;
      case 'remove':
        return Icons.remove;
      case 'check':
        return Icons.check;
      case 'close':
        return Icons.close;
      case 'arrow_forward':
        return Icons.arrow_forward;
      case 'arrow_back':
        return Icons.arrow_back;
      case 'home':
        return Icons.home;
      case 'settings':
        return Icons.settings;
      case 'search':
        return Icons.search;
      case 'favorite':
        return Icons.favorite;
      case 'star':
        return Icons.star;
      default:
        return null;
    }
  }
}

/// A widget that connects a form field to the FormStateManager
class _FormField<T> extends StatefulWidget {
  final String? field;
  final FormStateManager formState;
  final T defaultValue;
  final Widget Function(T value, ValueChanged<T> onChanged) builder;

  const _FormField({
    required this.field,
    required this.formState,
    required this.defaultValue,
    required this.builder,
  });

  @override
  State<_FormField<T>> createState() => _FormFieldState<T>();
}

class _FormFieldState<T> extends State<_FormField<T>> {
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

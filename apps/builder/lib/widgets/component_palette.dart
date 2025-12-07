import 'package:flutter/material.dart';
import '../models/component_spec.dart';
import 'component_tree.dart';

class ComponentPalette extends StatefulWidget {
  final ComponentSpecs? specs;
  final void Function(String section, Map<String, dynamic> component) onAddComponent;

  const ComponentPalette({
    super.key,
    this.specs,
    required this.onAddComponent,
  });

  @override
  State<ComponentPalette> createState() => _ComponentPaletteState();
}

class _ComponentPaletteState extends State<ComponentPalette> {
  String _selectedCategory = 'atoms';

  @override
  Widget build(BuildContext context) {
    if (widget.specs == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.widgets, size: 18, color: Color(0xFF6C63FF)),
                  const SizedBox(width: 8),
                  const Text(
                    'Composants',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.drag_indicator, size: 10, color: Color(0xFF4CAF50)),
                        SizedBox(width: 2),
                        Text(
                          'Drag',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Glissez les composants vers la structure ou cliquez pour ajouter',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
        // Category tabs
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildCategoryTab('layouts', 'Layouts', Icons.dashboard),
                _buildCategoryTab('atoms', 'Atoms', Icons.circle_outlined),
                _buildCategoryTab('molecules', 'Molecules', Icons.blur_circular),
                _buildCategoryTab('templates', 'Templates', Icons.layers),
              ],
            ),
          ),
        ),
        // Component list
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: _getComponentsForCategory()
                .map((spec) => _buildDraggableComponentCard(spec))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryTab(String key, String label, IconData icon) {
    final isSelected = _selectedCategory == key;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Material(
        color: isSelected
            ? const Color(0xFF6C63FF).withValues(alpha: 0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: () => setState(() => _selectedCategory = key),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: isSelected ? const Color(0xFF6C63FF) : Colors.white54,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? const Color(0xFF6C63FF) : Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<ComponentSpec> _getComponentsForCategory() {
    switch (_selectedCategory) {
      case 'layouts':
        return widget.specs!.layouts;
      case 'atoms':
        return widget.specs!.atoms;
      case 'molecules':
        return widget.specs!.molecules;
      case 'templates':
        return widget.specs!.templates;
      default:
        return [];
    }
  }

  Widget _buildDraggableComponentCard(ComponentSpec spec) {
    final component = _createDefaultComponent(spec);
    final dragData = DragComponentData(
      sourcePath: null, // null = new component
      sourceSection: 'content', // default section
      sourceIndex: null,
      component: component,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Draggable<DragComponentData>(
        data: dragData,
        feedback: Material(
          color: Colors.transparent,
          child: Container(
            width: 200,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6C63FF),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    _getIconForType(spec.type),
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        spec.label,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Glissez vers la structure',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        childWhenDragging: Opacity(
          opacity: 0.4,
          child: _buildComponentCardContent(spec),
        ),
        child: _buildComponentCardContent(spec, onTap: () => _showAddDialog(spec)),
      ),
    );
  }

  Widget _buildComponentCardContent(ComponentSpec spec, {VoidCallback? onTap}) {
    return Material(
      color: const Color(0xFF252538),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _getIconColor(spec.type).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  _getIconForType(spec.type),
                  size: 16,
                  color: _getIconColor(spec.type),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spec.label,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      spec.description,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white54,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.drag_indicator,
                size: 18,
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDialog(ComponentSpec spec) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text('Ajouter ${spec.label}'),
        content: const Text(
          'Dans quelle section voulez-vous ajouter ce composant?',
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addComponent(spec, 'header');
            },
            child: const Text('Header'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addComponent(spec, 'content');
            },
            child: const Text('Content'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _addComponent(spec, 'footer');
            },
            child: const Text('Footer'),
          ),
        ],
      ),
    );
  }

  void _addComponent(ComponentSpec spec, String section) {
    final component = _createDefaultComponent(spec);
    widget.onAddComponent(section, component);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${spec.label} ajouté au $section'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF6C63FF),
      ),
    );
  }

  Map<String, dynamic> _createDefaultComponent(ComponentSpec spec) {
    final props = <String, dynamic>{};

    // Add required props with defaults
    for (final entry in spec.props.entries) {
      final propSpec = entry.value;
      if (propSpec.required) {
        props[entry.key] = _getDefaultValue(entry.key, propSpec);
      } else if (propSpec.defaultValue != null) {
        props[entry.key] = propSpec.defaultValue;
      }
    }

    return {
      'type': spec.type,
      'props': props,
      if (spec.hasChildren) 'children': <Map<String, dynamic>>[],
    };
  }

  dynamic _getDefaultValue(String key, PropSpec propSpec) {
    if (propSpec.defaultValue != null) return propSpec.defaultValue;

    switch (propSpec.type) {
      case 'string':
        if (key == 'text' || key == 'label') return 'Texte';
        if (key == 'field') return 'field_name';
        return '';
      case 'number':
        return 0;
      case 'boolean':
        return false;
      case 'color':
        return '#FFFFFF';
      case 'enum':
        return propSpec.enumValues?.firstOrNull ?? '';
      default:
        return null;
    }
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'text':
        return Icons.text_fields;
      case 'button':
        return Icons.smart_button;
      case 'text_input':
        return Icons.edit;
      case 'checkbox':
        return Icons.check_box_outlined;
      case 'toggle':
        return Icons.toggle_on_outlined;
      case 'slider':
        return Icons.linear_scale;
      case 'progress_bar':
        return Icons.percent;
      case 'icon':
        return Icons.emoji_emotions_outlined;
      case 'logo':
        return Icons.branding_watermark;
      case 'header':
        return Icons.title;
      case 'selection_group':
        return Icons.checklist;
      case 'selectable_button_group':
        return Icons.grid_view;
      case 'container':
        return Icons.crop_square;
      case 'column':
        return Icons.view_column;
      case 'row':
        return Icons.view_stream;
      case 'padding':
        return Icons.padding;
      case 'expanded':
        return Icons.expand;
      case 'sized_box':
        return Icons.crop;
      case 'center':
        return Icons.center_focus_strong;
      case 'scrollable':
        return Icons.unfold_more;
      case 'screen_layout':
        return Icons.smartphone;
      case 'landing':
        return Icons.web;
      default:
        return Icons.widgets;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'text':
      case 'button':
      case 'text_input':
      case 'checkbox':
      case 'toggle':
      case 'slider':
      case 'progress_bar':
      case 'icon':
      case 'logo':
        return const Color(0xFF4CAF50); // Green for atoms
      case 'header':
      case 'selection_group':
      case 'selectable_button_group':
        return const Color(0xFF2196F3); // Blue for molecules
      case 'container':
      case 'column':
      case 'row':
      case 'padding':
      case 'expanded':
      case 'sized_box':
      case 'center':
      case 'scrollable':
        return const Color(0xFFFF9800); // Orange for layouts
      case 'screen_layout':
      case 'landing':
        return const Color(0xFF9C27B0); // Purple for templates
      default:
        return const Color(0xFF6C63FF);
    }
  }
}

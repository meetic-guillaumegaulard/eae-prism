import 'package:flutter/material.dart';

/// Data transferred during drag operations
class DragComponentData {
  final String? sourcePath; // null for new components from palette
  final String? sourceSection; // null for new components
  final int? sourceIndex;
  final Map<String, dynamic> component;

  const DragComponentData({
    this.sourcePath,
    this.sourceSection,
    this.sourceIndex,
    required this.component,
  });

  bool get isNew => sourcePath == null;
}

class ComponentTree extends StatefulWidget {
  final Map<String, dynamic>? screen;
  final String? selectedPath;
  final void Function(String?) onSelect;
  final void Function(String path) onRemove;
  final void Function(String path, Map<String, dynamic> component) onInsert;
  final void Function(
      String sourcePath, String targetParentPath, int targetIndex) onMove;

  const ComponentTree({
    super.key,
    this.screen,
    this.selectedPath,
    required this.onSelect,
    required this.onRemove,
    required this.onInsert,
    required this.onMove,
  });

  @override
  State<ComponentTree> createState() => _ComponentTreeState();
}

class _ComponentTreeState extends State<ComponentTree> {
  String? _hoveredDropZone;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    if (widget.screen == null) {
      return Center(
        child: Text(
          'No page',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.5)),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildHeader(),
        // Tree content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection('header', 'Header', Icons.vertical_align_top),
                const SizedBox(height: 8),
                _buildSection('content', 'Content', Icons.view_agenda),
                const SizedBox(height: 8),
                _buildSection('footer', 'Footer', Icons.vertical_align_bottom),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    final isSelected = widget.selectedPath == 'root';

    return InkWell(
      onTap: () => widget.onSelect('root'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00E4D7).withValues(alpha: 0.1)
              : null,
          border: Border(
            bottom: BorderSide(
              color: isSelected
                  ? const Color(0xFF00E4D7)
                  : Colors.white.withValues(alpha: 0.1),
              width: 2, // Largeur fixe pour éviter le changement de hauteur
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.web,
                size: 16,
                color: isSelected ? const Color(0xFF00E4D7) : Colors.white70),
            const SizedBox(width: 8),
            Text(
              'Page',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.white70,
              ),
            ),
            const SizedBox(width: 8),
            // Edit icon indicator
            Icon(
              Icons.edit,
              size: 12,
              color: isSelected ? const Color(0xFF00E4D7) : Colors.white24,
            ),
            const Spacer(),
            if (widget.selectedPath != null)
              IconButton(
                icon: const Icon(Icons.deselect, size: 16),
                onPressed: () => widget.onSelect(null),
                tooltip: 'Deselect',
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white54,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(28, 28),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String section, String label, IconData icon) {
    final components = widget.screen?[section] as List<dynamic>? ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header (also a drop target for adding to end)
        _buildSectionHeader(section, label, icon, components.length),
        // Components with drop zones
        Container(
          margin: const EdgeInsets.only(left: 8),
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 2,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First drop zone (before first element)
              _buildDropZone(section, 0),
              // Components interleaved with drop zones
              for (int i = 0; i < components.length; i++) ...[
                _buildDraggableItem(
                  components[i] as Map<String, dynamic>,
                  section,
                  i,
                  parentPath: section,
                ),
                _buildDropZone(section, i + 1),
              ],
              // Empty state
              if (components.isEmpty) _buildEmptyState(section),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
      String section, String label, IconData icon, int count) {
    return DragTarget<DragComponentData>(
      onWillAcceptWithDetails: (details) {
        // Prevent dropping a section onto itself
        if (details.data.sourcePath != null &&
            details.data.sourcePath == section) return false;
        return true;
      },
      onAcceptWithDetails: (details) {
        _handleDrop(details.data, section, count);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovered = candidateData.isNotEmpty;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: isHovered
                ? const Color(0xFF00E4D7).withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border:
                isHovered ? Border.all(color: const Color(0xFF00E4D7)) : null,
          ),
          child: Row(
            children: [
              Icon(icon, size: 14, color: Colors.white38),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$count',
                  style: const TextStyle(fontSize: 10, color: Colors.white38),
                ),
              ),
              if (isHovered) ...[
                const Spacer(),
                const Text(
                  'Add to end',
                  style: TextStyle(fontSize: 10, color: Color(0xFF00E4D7)),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildDropZone(String parentPath, int index) {
    final dropZoneId = '$parentPath:$index';
    final isHovered = _hoveredDropZone == dropZoneId;

    return DragTarget<DragComponentData>(
      onWillAcceptWithDetails: (details) {
        final data = details.data;

        // Always accept new components
        if (data.isNew) return true;

        // Prevent dropping onto itself or its own children
        if (data.sourcePath != null) {
          if (parentPath.startsWith(data.sourcePath!)) {
            return false;
          }

          final sourceParent = _getParentPath(data.sourcePath!);
          if (sourceParent == parentPath) {
            final sourceIndex = _getIndexFromPath(data.sourcePath!);
            if (index == sourceIndex || index == sourceIndex + 1) {
              return false;
            }
          }
        }

        return true;
      },
      onAcceptWithDetails: (details) {
        setState(() => _hoveredDropZone = null);
        _handleDrop(details.data, parentPath, index);
      },
      onMove: (details) {
        if (_hoveredDropZone != dropZoneId) {
          setState(() => _hoveredDropZone = dropZoneId);
        }
      },
      onLeave: (_) {
        if (_hoveredDropZone == dropZoneId) {
          setState(() => _hoveredDropZone = null);
        }
      },
      builder: (context, candidateData, rejectedData) {
        final showActive = isHovered || candidateData.isNotEmpty;

        // Fixed height container to prevent layout shifts
        // This acts as the margin between components
        return Container(
          height: 10,
          width: double.infinity,
          margin: const EdgeInsets.only(left: 12, right: 4),
          alignment: Alignment.center,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            height: showActive ? 2 : (_isDragging ? 1 : 0),
            width: double.infinity,
            decoration: BoxDecoration(
              color: showActive
                  ? const Color(0xFF00E4D7)
                  : (_isDragging
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(1),
              boxShadow: showActive
                  ? [
                      BoxShadow(
                        color: const Color(0xFF00E4D7).withValues(alpha: 0.5),
                        blurRadius: 4,
                        spreadRadius: 0,
                      )
                    ]
                  : null,
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(String section) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 4, top: 4, bottom: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Drop components here',
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.4),
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget _buildDraggableItem(
    Map<String, dynamic> component,
    String section,
    int index, {
    required String parentPath,
    int depth = 0,
  }) {
    final type = component['type'] as String? ?? 'unknown';
    final props = component['props'] as Map<String, dynamic>? ?? {};
    final children = component['children'] as List<dynamic>?;

    // Construct full path: "content.0.children.1"
    final currentPath = parentPath == section
        ? '$section.$index'
        : '$parentPath.children.$index';

    final isSelected = widget.selectedPath == currentPath;

    // Get display label
    String label = type;
    if (props.containsKey('label')) {
      label = '$type: "${props['label']}"';
    } else if (props.containsKey('text')) {
      final text = props['text'] as String;
      label =
          '$type: "${text.length > 15 ? '${text.substring(0, 15)}...' : text}"';
    } else if (props.containsKey('field')) {
      label = '$type [${props['field']}]';
    }

    final dragData = DragComponentData(
      sourcePath: currentPath,
      sourceSection: section,
      sourceIndex: index,
      component: _deepCopy(component),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Draggable<DragComponentData>(
          data: dragData,
          onDragStarted: () => setState(() => _isDragging = true),
          onDragEnd: (_) => setState(() {
            _isDragging = false;
            _hoveredDropZone = null;
          }),
          onDraggableCanceled: (_, __) => setState(() {
            _isDragging = false;
            _hoveredDropZone = null;
          }),
          feedback: _buildDragFeedback(type, label, children?.length ?? 0),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: _buildItemContent(
                type, label, children, false, currentPath, depth),
          ),
          child: _buildItemContent(
              type, label, children, isSelected, currentPath, depth),
        ),
        // Render children recursively
        if (children != null && children.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: const Color(0xFF00E4D7).withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First drop zone for children
                _buildDropZone(currentPath, 0),
                for (int i = 0; i < children.length; i++) ...[
                  _buildDraggableItem(
                    children[i] as Map<String, dynamic>,
                    section,
                    i,
                    parentPath: currentPath,
                    depth: depth + 1,
                  ),
                  _buildDropZone(currentPath, i + 1),
                ],
              ],
            ),
          ),
        // Empty drop zone if container has no children
        if (children != null && children.isEmpty)
          _buildDropZone(currentPath, 0),
      ],
    );
  }

  Widget _buildDragFeedback(String type, String label, int childrenCount) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF00E4D7),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getIconForType(type), size: 16, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (childrenCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '+$childrenCount',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildItemContent(
    String type,
    String label,
    List<dynamic>? children,
    bool isSelected,
    String path, [
    int depth = 0,
  ]) {
    return InkWell(
      onTap: () => widget.onSelect(path),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        margin: const EdgeInsets.only(left: 12, right: 4),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF00E4D7).withValues(alpha: 0.2)
              : const Color(0xFF2D1B4E),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00E4D7)
                : Colors.white.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Drag handle
            MouseRegion(
              cursor: SystemMouseCursors.grab,
              child: Container(
                padding: const EdgeInsets.all(2),
                child: Icon(
                  Icons.drag_indicator,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(width: 6),
            // Component icon
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: _getIconColor(type).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                _getIconForType(type),
                size: 12,
                color: _getIconColor(type),
              ),
            ),
            const SizedBox(width: 8),
            // Label
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Children count
            if (children != null && children.isNotEmpty) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${children.length}',
                  style: const TextStyle(fontSize: 9, color: Colors.white38),
                ),
              ),
              const SizedBox(width: 4),
            ],
            // Delete button
            InkWell(
              onTap: () => widget.onRemove(path),
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDrop(
      DragComponentData data, String targetParentPath, int targetIndex) {
    if (data.isNew) {
      // Add new component
      // Construct the full path including the target index
      String fullPath;
      if (targetParentPath == 'header' ||
          targetParentPath == 'content' ||
          targetParentPath == 'footer') {
        // Root section insert: "content.0"
        fullPath = '$targetParentPath.$targetIndex';
      } else {
        // Nested insert: "content.0.children.1"
        fullPath = '$targetParentPath.children.$targetIndex';
      }
      widget.onInsert(fullPath, data.component);
    } else {
      // Move existing component
      if (data.sourcePath != null) {
        widget.onMove(data.sourcePath!, targetParentPath, targetIndex);
      }
    }
  }

  String _getParentPath(String path) {
    final parts = path.split('.');
    if (parts.length <= 2) return parts[0]; // section

    // Remove ".children.index" from end
    return parts.sublist(0, parts.length - 2).join('.');
  }

  int _getIndexFromPath(String path) {
    final parts = path.split('.');
    return int.tryParse(parts.last) ?? 0;
  }

  Map<String, dynamic> _deepCopy(Map<String, dynamic> original) {
    final copy = <String, dynamic>{};
    for (final entry in original.entries) {
      if (entry.value is Map<String, dynamic>) {
        copy[entry.key] = _deepCopy(entry.value as Map<String, dynamic>);
      } else if (entry.value is List) {
        copy[entry.key] = (entry.value as List).map((item) {
          if (item is Map<String, dynamic>) {
            return _deepCopy(item);
          }
          return item;
        }).toList();
      } else {
        copy[entry.key] = entry.value;
      }
    }
    return copy;
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
        return const Color(0xFF4CAF50);
      case 'header':
      case 'selection_group':
        return const Color(0xFF2196F3);
      case 'container':
      case 'column':
      case 'row':
      case 'padding':
      case 'expanded':
      case 'sized_box':
      case 'center':
      case 'scrollable':
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF00E4D7);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import '../services/api_service.dart';
import '../models/component_spec.dart';
import '../widgets/component_tree.dart';
import '../widgets/property_editor.dart';
import '../widgets/component_palette.dart';
import '../widgets/preview_panel.dart';
import '../widgets/navigation_editor.dart';

class EditorScreen extends StatefulWidget {
  final String filePath;
  final bool isNew;

  const EditorScreen({
    super.key,
    required this.filePath,
    this.isNew = false,
  });

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  Map<String, dynamic>? _pageConfig;
  ComponentSpecs? _componentSpecs;
  bool _isLoading = true;
  String? _error;
  bool _hasChanges = false;
  String? _selectedComponentPath;
  Brand _previewBrand = Brand.meetic;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Load component specs
      final specsResponse = await ApiService.getComponentSpecs();
      _componentSpecs = ComponentSpecs.fromJson(specsResponse);

      if (widget.isNew) {
        // Create default page config
        _pageConfig = _createDefaultPageConfig();
      } else {
        // Load existing file
        final fileResponse = await ApiService.readFile(widget.filePath);
        _pageConfig = fileResponse['content'] as Map<String, dynamic>?;
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Map<String, dynamic> _createDefaultPageConfig() {
    final pathParts = widget.filePath.split('/');

    return {
      'navigation': {
        'type': 'navigate',
        'direction': 'left',
        'scope': 'content',
        'durationMs': 300,
      },
      'screen': {
        'template': 'screen_layout',
        'props': {
          'backgroundColor': '#FFFFFF',
          'screenId': pathParts.lastOrNull ?? 'new-screen',
          'topBarHeight': 80,
        },
        'header': [],
        'content': [],
        'footer': [],
      },
    };
  }

  Future<void> _saveFile() async {
    if (_pageConfig == null) return;

    try {
      await ApiService.saveFile(widget.filePath, _pageConfig!);
      setState(() => _hasChanges = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Fichier sauvegardé'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _updatePageConfig(Map<String, dynamic> newConfig) {
    setState(() {
      _pageConfig = newConfig;
      _hasChanges = true;
    });
  }

  void _updateNavigation(Map<String, dynamic> navigation) {
    if (_pageConfig == null) return;
    _updatePageConfig({
      ..._pageConfig!,
      'navigation': navigation,
    });
  }

  void _selectComponent(String? path) {
    setState(() {
      _selectedComponentPath = path;
    });
  }

  void _addComponent(String section, Map<String, dynamic> component) {
    if (_pageConfig == null) return;

    final screen = Map<String, dynamic>.from(_pageConfig!['screen'] ?? {});
    final sectionList = List<dynamic>.from(screen[section] ?? []);
    sectionList.add(component);
    screen[section] = sectionList;

    _updatePageConfig({
      ..._pageConfig!,
      'screen': screen,
    });
  }

  void _insertComponent(String path, Map<String, dynamic> component) {
    if (_pageConfig == null) return;

    final parts = path.split('.');
    if (parts.length < 2) return;

    final section = parts[0];
    final screen = Map<String, dynamic>.from(_pageConfig!['screen'] ?? {});
    final list = List<dynamic>.from(screen[section] ?? []);

    if (parts.length == 2) {
      // Insert at root of section
      final index = int.tryParse(parts[1]) ?? list.length;
      list.insert(index.clamp(0, list.length), component);
      screen[section] = list;
    } else {
      // Insert inside a container
      _insertNestedComponent(list, parts.sublist(1), component);
      screen[section] = list;
    }

    _updatePageConfig({
      ..._pageConfig!,
      'screen': screen,
    });
  }

  void _insertNestedComponent(List<dynamic> list, List<String> pathParts, Map<String, dynamic> component) {
    if (pathParts.isEmpty) return;

    final index = int.tryParse(pathParts[0]);
    if (index == null || index >= list.length) return;

    if (pathParts.length == 1) {
      // Should not happen for insertion logic as we always target an index
      return;
    }

    if (pathParts[1] == 'children') {
      final parent = Map<String, dynamic>.from(list[index]);
      final children = List<dynamic>.from(parent['children'] ?? []);
      
      if (pathParts.length == 2) {
        // Append to children
        children.add(component);
      } else {
        // Recurse deeper or insert at specific child index
        final childIndex = int.tryParse(pathParts[2]);
        if (pathParts.length == 3 && childIndex != null) {
          children.insert(childIndex.clamp(0, children.length), component);
        } else {
          _insertNestedComponent(children, pathParts.sublist(2), component);
        }
      }
      
      parent['children'] = children;
      list[index] = parent;
    }
  }

  void _moveComponent(String sourcePath, String targetParentPath, int targetIndex) {
    if (_pageConfig == null) return;
    
    // 1. Create a deep copy of the entire screen configuration
    // This ensures we can modify it freely without state issues until we're done
    final screen = _deepCopy(_pageConfig!['screen'] ?? {});
    
    // 2. Locate source list and item
    final sourceParts = sourcePath.split('.');
    final sourceSection = sourceParts[0];
    final sourceParentParts = sourceParts.sublist(1, sourceParts.length - 1); // exclude index
    final sourceIndex = int.tryParse(sourceParts.last);
    
    if (sourceIndex == null) return;
    
    // Find the list containing the source item
    List<dynamic>? sourceList;
    if (sourceParentParts.isEmpty) {
      sourceList = screen[sourceSection] as List<dynamic>?;
    } else {
      final container = _findContainerByPath(screen[sourceSection], sourceParentParts);
      if (container is List) {
        sourceList = container;
      } else if (container is Map) {
         // If path ended at a map but we expected a list (e.g. "children"), take it?
         // No, our path logic always ends with the list property name if it's nested
         // Wait, sourceParentParts from "content.0.children.1" is "0.children"
         // _findContainerByPath will return the children list.
         // BUT wait, in findContainer logic:
         // part "0" -> current becomes map
         // part "children" -> current becomes list
         // So it returns List. Correct.
      }
      sourceList = container as List<dynamic>?;
    }
    
    if (sourceList == null || sourceIndex >= sourceList.length) return;
    
    // 3. Locate target list
    final targetParts = targetParentPath.split('.');
    final targetSection = targetParts[0];
    final targetParentParts = targetParts.length > 1 ? targetParts.sublist(1) : <String>[];
    
    dynamic targetContainer;
    List<dynamic>? targetList;
    
    if (targetParentParts.isEmpty) {
      // Root section list
      targetList = screen[targetSection] as List<dynamic>?;
    } else {
      // Find the container element that holds the list
      targetContainer = _findContainerByPath(screen[targetSection], targetParentParts);
      
      if (targetContainer is Map) {
        // We found a component, get or create its children list
        if (targetContainer['children'] == null) {
          targetContainer['children'] = [];
        }
        targetList = targetContainer['children'] as List<dynamic>?;
      } else if (targetContainer is List) {
        // Should not happen with our path logic, but just in case
        targetList = targetContainer;
      }
    }
    
    if (targetList == null) return;
    
    // 4. Perform the move
    // If source and target are the exact same list instance (check identity implies complexity with copies, so check paths)
    // Note: We need to check if we are moving within the same parent list
    // sourcePath parent is implicit from the structure
    final sourceParentPath = sourcePath.substring(0, sourcePath.lastIndexOf('.'));
    final isSameList = sourceParentPath == targetParentPath;
    
    if (isSameList) {
      // Moving within same list
      if (sourceIndex < sourceList.length) {
        final item = sourceList.removeAt(sourceIndex);
        // Adjust target index because removal might shift it
        final adjustedIndex = targetIndex > sourceIndex ? targetIndex - 1 : targetIndex;
        targetList.insert(adjustedIndex.clamp(0, targetList.length), item);
      }
    } else {
      // Moving to different list
      if (sourceIndex < sourceList.length) {
        final item = sourceList.removeAt(sourceIndex);
        targetList.insert(targetIndex.clamp(0, targetList.length), item);
      }
    }
    
    // 5. Update state once with the fully modified tree
    _updatePageConfig({
      ..._pageConfig!,
      'screen': screen,
    });
  }

  // Returns the List containing the item at the end of path, OR the Map if the path points to a container
  // For path ["0", "children", "1"], it returns the List at "children"
  // For path ["0"], it returns the Map at index 0
  dynamic _findListByPath(dynamic root, List<String> parts) {
    // This helper was confusing. Let's use _findContainerByPath instead.
    return null;
  }
  
  // Follows the path to find the element pointed to by the path
  // path ["0"] -> returns element at index 0 (Map)
  // path ["0", "children", "1"] -> returns element at index 1 of children (Map)
  dynamic _findContainerByPath(dynamic root, List<String> parts) {
    if (root == null) return null;
    dynamic current = root; // Start with the section list
    
    for (int i = 0; i < parts.length; i++) {
      final part = parts[i];
      
      if (current is List) {
        final index = int.tryParse(part);
        if (index != null && index < current.length) {
          current = current[index];
        } else {
          return null;
        }
      } else if (current is Map) {
        if (part == 'children') {
          current = current['children'];
        } else {
          // Maybe it's an index into a children list that was implicit?
          // No, our paths are explicit: "0.children.1"
          return null;
        }
      } else {
        return null;
      }
    }
    
    return current;
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

  void _removeComponent(String path) {
    if (_pageConfig == null) return;

    // Parse path like "content.0.children.1"
    final parts = path.split('.');
    if (parts.length < 2) return;

    final section = parts[0];
    final screen = Map<String, dynamic>.from(_pageConfig!['screen'] ?? {});
    
    if (parts.length == 2) {
      // Direct child of section
      final index = int.tryParse(parts[1]);
      if (index != null) {
        final list = List<dynamic>.from(screen[section] ?? []);
        if (index < list.length) {
          list.removeAt(index);
          screen[section] = list;
        }
      }
    } else {
      // Nested component - need to navigate and remove
      _removeNestedComponent(screen, section, parts.sublist(1));
    }

    _updatePageConfig({
      ..._pageConfig!,
      'screen': screen,
    });

    if (_selectedComponentPath == path) {
      _selectComponent(null);
    }
  }

  void _removeNestedComponent(Map<String, dynamic> screen, String section, List<String> pathParts) {
    final list = List<dynamic>.from(screen[section] ?? []);
    dynamic current = list;

    for (var i = 0; i < pathParts.length - 1; i++) {
      final part = pathParts[i];
      if (part == 'children') {
        if (current is Map && current['children'] != null) {
          current = List<dynamic>.from(current['children']);
        }
      } else {
        final index = int.tryParse(part);
        if (index != null && current is List && index < current.length) {
          current = Map<String, dynamic>.from(current[index]);
        }
      }
    }

    final lastIndex = int.tryParse(pathParts.last);
    if (lastIndex != null && current is List && lastIndex < current.length) {
      current.removeAt(lastIndex);
    }

    screen[section] = list;
  }

  void _updateComponent(String path, Map<String, dynamic> props) {
    if (_pageConfig == null) return;

    final parts = path.split('.');
    if (parts.length < 2) return;

    final section = parts[0];
    final screen = Map<String, dynamic>.from(_pageConfig!['screen'] ?? {});
    final list = List<dynamic>.from(screen[section] ?? []);

    // Navigate to component and update props
    _updateNestedComponent(list, parts.sublist(1), props);

    screen[section] = list;
    _updatePageConfig({
      ..._pageConfig!,
      'screen': screen,
    });
  }

  void _updateNestedComponent(List<dynamic> list, List<String> pathParts, Map<String, dynamic> props) {
    if (pathParts.isEmpty) return;

    final firstIndex = int.tryParse(pathParts[0]);
    if (firstIndex == null || firstIndex >= list.length) return;

    if (pathParts.length == 1) {
      // Update this component
      final component = Map<String, dynamic>.from(list[firstIndex]);
      component['props'] = {
        ...(component['props'] as Map<String, dynamic>? ?? {}),
        ...props,
      };
      list[firstIndex] = component;
    } else if (pathParts[1] == 'children') {
      // Navigate to children
      final component = Map<String, dynamic>.from(list[firstIndex]);
      final children = List<dynamic>.from(component['children'] ?? []);
      _updateNestedComponent(children, pathParts.sublist(2), props);
      component['children'] = children;
      list[firstIndex] = component;
    }
  }

  Map<String, dynamic>? _getComponentAtPath(String? path) {
    if (path == null || _pageConfig == null) return null;

    final parts = path.split('.');
    if (parts.length < 2) return null;

    final section = parts[0];
    final screen = _pageConfig!['screen'] as Map<String, dynamic>?;
    if (screen == null) return null;

    final list = screen[section] as List<dynamic>?;
    if (list == null) return null;

    return _getNestedComponent(list, parts.sublist(1));
  }

  Map<String, dynamic>? _getNestedComponent(List<dynamic> list, List<String> pathParts) {
    if (pathParts.isEmpty) return null;

    final firstIndex = int.tryParse(pathParts[0]);
    if (firstIndex == null || firstIndex >= list.length) return null;

    final component = list[firstIndex] as Map<String, dynamic>;

    if (pathParts.length == 1) {
      return component;
    } else if (pathParts[1] == 'children') {
      final children = component['children'] as List<dynamic>?;
      if (children == null) return null;
      return _getNestedComponent(children, pathParts.sublist(2));
    }

    return null;
  }

  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text('Modifications non sauvegardées'),
        content: const Text('Voulez-vous sauvegarder avant de quitter?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ne pas sauvegarder'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              await _saveFile();
              if (context.mounted) Navigator.pop(context, true);
            },
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              final shouldPop = await _onWillPop();
              if (shouldPop && mounted) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Retour',
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), Color(0xFF9D4EDD)],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.edit_document,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.filePath,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    if (_hasChanges) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Non sauvegardé',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  widget.isNew ? 'Nouvelle page' : 'Édition',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          // Preview brand selector
          const Text(
            'Aperçu:',
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(width: 8),
          SegmentedButton<Brand>(
            segments: const [
              ButtonSegment(value: Brand.match, label: Text('Match')),
              ButtonSegment(value: Brand.meetic, label: Text('Meetic')),
              ButtonSegment(value: Brand.okc, label: Text('OKC')),
              ButtonSegment(value: Brand.pof, label: Text('POF')),
            ],
            selected: {_previewBrand},
            onSelectionChanged: (selection) {
              setState(() => _previewBrand = selection.first);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF6C63FF);
                }
                return Colors.transparent;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white;
                }
                return Colors.white54;
              }),
              side: WidgetStateProperty.all(
                BorderSide(color: Colors.white.withValues(alpha: 0.2)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton.icon(
            onPressed: _saveFile,
            icon: const Icon(Icons.save, size: 18),
            label: const Text('Sauvegarder'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _hasChanges ? const Color(0xFF6C63FF) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF6C63FF),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Erreur de chargement',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: const TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _loadData,
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        // Column 1: Component palette
        Expanded(
          flex: 2,
          child: ComponentPalette(
            specs: _componentSpecs,
            onAddComponent: _addComponent,
          ),
        ),
        VerticalDivider(
          width: 1,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        // Column 2: Structure (Navigation + Tree)
        Expanded(
          flex: 2,
          child: Column(
            children: [
              // Navigation editor
              NavigationEditor(
                navigation: _pageConfig?['navigation'] as Map<String, dynamic>?,
                onUpdate: _updateNavigation,
              ),
              // Component tree
              Expanded(
                child: ComponentTree(
                  screen: _pageConfig?['screen'] as Map<String, dynamic>?,
                  selectedPath: _selectedComponentPath,
                  onSelect: _selectComponent,
                  onRemove: _removeComponent,
                  onInsert: _insertComponent,
                  onMove: _moveComponent,
                ),
              ),
            ],
          ),
        ),
        VerticalDivider(
          width: 1,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        // Column 3: Properties
        Expanded(
          flex: 2,
          child: PropertyEditor(
            component: _getComponentAtPath(_selectedComponentPath),
            componentPath: _selectedComponentPath,
            specs: _componentSpecs,
            onUpdate: _updateComponent,
          ),
        ),
        VerticalDivider(
          width: 1,
          color: Colors.white.withValues(alpha: 0.1),
        ),
        // Column 4: Preview
        Expanded(
          flex: 3,
          child: PreviewPanel(
            pageConfig: _pageConfig,
            brand: _previewBrand,
            selectedPath: _selectedComponentPath,
            onSelect: _selectComponent,
          ),
        ),
      ],
    );
  }
}

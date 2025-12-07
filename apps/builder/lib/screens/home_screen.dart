import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/file_tree.dart';
import 'editor_screen.dart';
import '../widgets/folder_graph_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FileTreeItem> _fileTree = [];
  bool _isLoading = true;
  String? _error;
  final Set<String> _expandedFolders = {};
  String? _selectedFolderForGraph;

  @override
  void initState() {
    super.initState();
    _loadFileTree();
  }

  Future<void> _loadFileTree() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await ApiService.getFileTree();
      setState(() {
        _fileTree = parseFileTree(response);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _openEditor(String path) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditorScreen(filePath: path),
      ),
    );
  }

  void _openGraph(String path) {
    setState(() {
      _selectedFolderForGraph = path;
    });
  }

  void _closeGraph() {
    setState(() {
      _selectedFolderForGraph = null;
    });
  }

  void _createNewFile() {
    _showCreateDialog(isFolder: false);
  }

  void _createNewFolder() {
    _showCreateDialog(isFolder: true);
  }

  void _showCreateDialog({required bool isFolder}) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF201034),
        title: Text(isFolder ? 'New Folder' : 'New Page'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Path',
            hintText: isFolder ? 'brand/flow' : 'brand/flow/screen',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final path = controller.text.trim();
              if (path.isEmpty) return;

              Navigator.pop(context);

              try {
                if (isFolder) {
                  await ApiService.createFolder(path);
                  await _loadFileTree();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Folder "$path" created')),
                    );
                  }
                } else {
                  // For files, navigate to editor in create mode
                  if (mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditorScreen(
                          filePath: path,
                          isNew: true,
                        ),
                      ),
                    );
                  }
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteItem(FileTreeItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF201034),
        title: const Text('Confirm Deletion'),
        content: Text(
          'Are you sure you want to delete "${item.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      if (item.isFolder) {
        await ApiService.deleteFolder(item.path);
      } else {
        await ApiService.deleteFile(item.path);
      }
      await _loadFileTree();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${item.name}" deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF201034),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: null,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/eae-prism-logo.png',
                        height: 80,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                          Icons.dashboard_customize,
                          color: Color(0xFF00E4D7),
                          size: 80,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
                const Spacer(),
                // Actions
                OutlinedButton.icon(
                  onPressed: _createNewFolder,
                  icon: const Icon(Icons.create_new_folder, size: 18),
                  label: const Text('New Folder'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side:
                        BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _createNewFile,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('New Page'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00E4D7),
                    foregroundColor: const Color(0xFF201034),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00E4D7),
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
              'Connection Error',
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
              onPressed: _loadFileTree,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_fileTree.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 80,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 16),
            Text(
              'No Files',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Start by creating a new page',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _createNewFile,
              icon: const Icon(Icons.add),
              label: const Text('New Page'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Files',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: _loadFileTree,
                icon: const Icon(Icons.refresh, size: 18),
                tooltip: 'Refresh',
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children:
                  _fileTree.map((item) => _buildTreeItem(item, 0)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeItem(FileTreeItem item, int depth) {
    final isExpanded = _expandedFolders.contains(item.path);
    final isGraphView = _selectedFolderForGraph == item.path;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (item.isFolder) {
              if (item.hasScreens) {
                // Toggle between graph and list view
                if (isGraphView) {
                  _closeGraph();
                  setState(() {
                    _expandedFolders.add(item.path);
                  });
                } else {
                  _openGraph(item.path);
                  setState(() {
                    _expandedFolders.remove(item.path);
                  });
                }
              } else {
                setState(() {
                  if (isExpanded) {
                    _expandedFolders.remove(item.path);
                  } else {
                    _expandedFolders.add(item.path);
                  }
                });
              }
            } else {
              _openEditor(item.path);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.only(
              left: 12 + depth * 24.0,
              right: 12,
              top: 10,
              bottom: 10,
            ),
            child: Row(
              children: [
                if (item.isFolder) ...[
                  Icon(
                    item.hasScreens
                        ? (isGraphView ? Icons.hub : Icons.hub_outlined)
                        : (isExpanded ? Icons.folder_open : Icons.folder),
                    color: item.hasScreens
                        ? const Color(0xFF00E4D7)
                        : _getBrandColor(item.name),
                    size: 20,
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E4D7).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.description,
                      color: Color(0xFF00E4D7),
                      size: 14,
                    ),
                  ),
                ],
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.name,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontWeight:
                          item.isFolder ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                if (item.isFolder) ...[
                  if (item.children != null && !isGraphView) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${item.children!.length}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white54,
                        ),
                      ),
                    ),
                  ],
                  // Toggle button for flow folders to switch to list view
                  if (item.hasScreens) ...[
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        isGraphView ? Icons.list : Icons.hub,
                        size: 18,
                      ),
                      tooltip: isGraphView
                          ? 'Switch to List View'
                          : 'Switch to Graph View',
                      onPressed: () {
                        if (isGraphView) {
                          _closeGraph();
                          setState(() {
                            _expandedFolders.add(item.path);
                          });
                        } else {
                          _openGraph(item.path);
                          setState(() {
                            _expandedFolders.remove(item.path);
                          });
                        }
                      },
                      style: IconButton.styleFrom(
                        foregroundColor: Colors.white54,
                      ),
                    ),
                  ],
                ],
                if (!item.isFolder) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 18),
                    onPressed: () => _deleteItem(item),
                    style: IconButton.styleFrom(
                      foregroundColor: Colors.white38,
                    ),
                    tooltip: 'Delete',
                  ),
                ],
              ],
            ),
          ),
        ),
        // Render Graph View inline
        if (isGraphView)
          Container(
            height: 400,
            margin: const EdgeInsets.only(top: 8, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FolderGraphView(
                folderPath: item.path,
                onFileTap: _openEditor,
              ),
            ),
          ),
        // Render Children (List View)
        if (item.isFolder &&
            isExpanded &&
            item.children != null &&
            !isGraphView)
          ...item.children!.map((child) => _buildTreeItem(child, depth + 1)),
      ],
    );
  }

  Color _getBrandColor(String name) {
    switch (name.toLowerCase()) {
      case 'match':
        return const Color(0xFF11144C);
      case 'meetic':
        return const Color(0xFF9D4EDD);
      case 'okc':
        return const Color(0xFF0046D5);
      case 'pof':
        return const Color(0xFF333333);
      default:
        return const Color(0xFFFFAB00);
    }
  }
}

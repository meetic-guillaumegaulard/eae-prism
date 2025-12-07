import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/file_tree.dart';
import 'editor_screen.dart';

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
        backgroundColor: const Color(0xFF1A1A2E),
        title: Text(isFolder ? 'Nouveau dossier' : 'Nouvelle page'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: 'Chemin',
            hintText: isFolder
                ? 'brand/flow'
                : 'brand/flow/screen',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
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
                      SnackBar(content: Text('Dossier "$path" créé')),
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
                      content: Text('Erreur: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Créer'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteItem(FileTreeItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        title: const Text('Confirmer la suppression'),
        content: Text(
          'Voulez-vous vraiment supprimer "${item.name}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
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
          SnackBar(content: Text('"${item.name}" supprimé')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
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
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6C63FF), Color(0xFF9D4EDD)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.dashboard_customize,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EAE Page Builder',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Éditeur WYSIWYG pour pages dynamiques',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Actions
                OutlinedButton.icon(
                  onPressed: _createNewFolder,
                  icon: const Icon(Icons.create_new_folder, size: 18),
                  label: const Text('Nouveau dossier'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _createNewFile,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Nouvelle page'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C63FF),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
              'Erreur de connexion',
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
              label: const Text('Réessayer'),
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
              'Aucun fichier',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Commencez par créer une nouvelle page',
              style: TextStyle(color: Colors.white54),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _createNewFile,
              icon: const Icon(Icons.add),
              label: const Text('Nouvelle page'),
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
                'Fichiers',
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
                tooltip: 'Actualiser',
                style: IconButton.styleFrom(
                  foregroundColor: Colors.white54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: _fileTree.map((item) => _buildTreeItem(item, 0)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTreeItem(FileTreeItem item, int depth) {
    final isExpanded = _expandedFolders.contains(item.path);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (item.isFolder) {
              setState(() {
                if (isExpanded) {
                  _expandedFolders.remove(item.path);
                } else {
                  _expandedFolders.add(item.path);
                }
              });
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
                    isExpanded ? Icons.folder_open : Icons.folder,
                    color: _getBrandColor(item.name),
                    size: 20,
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.description,
                      color: Color(0xFF6C63FF),
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
                      fontWeight: item.isFolder ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                if (item.isFolder && item.children != null) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 18),
                  onPressed: () => _deleteItem(item),
                  style: IconButton.styleFrom(
                    foregroundColor: Colors.white38,
                  ),
                  tooltip: 'Supprimer',
                ),
              ],
            ),
          ),
        ),
        if (item.isFolder && isExpanded && item.children != null)
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


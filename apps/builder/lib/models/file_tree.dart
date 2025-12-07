/// Model for file tree items
class FileTreeItem {
  final String name;
  final String type;
  final String path;
  final List<FileTreeItem>? children;

  const FileTreeItem({
    required this.name,
    required this.type,
    required this.path,
    this.children,
  });

  bool get isFolder => type == 'folder';
  bool get isFile => type == 'file';

  factory FileTreeItem.fromJson(Map<String, dynamic> json) {
    return FileTreeItem(
      name: json['name'] as String,
      type: json['type'] as String,
      path: json['path'] as String,
      children: json['children'] != null
          ? (json['children'] as List)
              .map((item) => FileTreeItem.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'path': path,
        if (children != null) 'children': children!.map((c) => c.toJson()).toList(),
      };
}

/// Parse file tree from API response
List<FileTreeItem> parseFileTree(Map<String, dynamic> response) {
  final tree = response['tree'] as List?;
  if (tree == null) return [];
  return tree
      .map((item) => FileTreeItem.fromJson(item as Map<String, dynamic>))
      .toList();
}


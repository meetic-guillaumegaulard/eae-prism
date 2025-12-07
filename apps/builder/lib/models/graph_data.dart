class GraphNode {
  final String id;
  final String label;
  final String type;
  final String path;

  GraphNode({
    required this.id,
    required this.label,
    required this.type,
    required this.path,
  });

  factory GraphNode.fromJson(Map<String, dynamic> json) {
    return GraphNode(
      id: json['id'] as String,
      label: json['label'] as String,
      type: json['type'] as String,
      path: json['path'] as String,
    );
  }
}

class GraphEdge {
  final String source;
  final String target;
  final String? label;

  GraphEdge({
    required this.source,
    required this.target,
    this.label,
  });

  factory GraphEdge.fromJson(Map<String, dynamic> json) {
    return GraphEdge(
      source: json['source'] as String,
      target: json['target'] as String,
      label: json['label'] as String?,
    );
  }
}

class GraphData {
  final List<GraphNode> nodes;
  final List<GraphEdge> edges;

  GraphData({
    required this.nodes,
    required this.edges,
  });

  factory GraphData.fromJson(Map<String, dynamic> json) {
    return GraphData(
      nodes: (json['nodes'] as List)
          .map((e) => GraphNode.fromJson(e as Map<String, dynamic>))
          .toList(),
      edges: (json['edges'] as List)
          .map((e) => GraphEdge.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}


import 'package:flutter/material.dart';
import '../models/graph_data.dart';
import '../services/api_service.dart';

class FolderGraphView extends StatefulWidget {
  final String folderPath;
  final Function(String path) onFileTap;

  const FolderGraphView({
    super.key,
    required this.folderPath,
    required this.onFileTap,
  });

  @override
  State<FolderGraphView> createState() => _FolderGraphViewState();
}

class _FolderGraphViewState extends State<FolderGraphView> {
  GraphData? _graphData;
  bool _isLoading = true;
  String? _error;
  Map<String, Offset> _nodePositions = {};

  @override
  void initState() {
    super.initState();
    _loadGraph();
  }

  @override
  void didUpdateWidget(FolderGraphView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.folderPath != oldWidget.folderPath) {
      _loadGraph();
    }
  }

  Future<void> _loadGraph() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await ApiService.getFolderGraph(widget.folderPath);
      final data = GraphData.fromJson(response);
      _calculateLayout(data);
      setState(() {
        _graphData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _calculateLayout(GraphData data) {
    _nodePositions.clear();
    if (data.nodes.isEmpty) return;

    // Simple rank-based layout
    // 1. Build adjacency list and in-degree map
    final adj = <String, List<String>>{};
    final inDegree = <String, int>{};
    
    for (var node in data.nodes) {
      adj[node.id] = [];
      inDegree[node.id] = 0;
    }

    for (var edge in data.edges) {
      adj[edge.source]?.add(edge.target);
      inDegree[edge.target] = (inDegree[edge.target] ?? 0) + 1;
    }

    // 2. Assign ranks (levels) using BFS/Topological sort-ish
    final ranks = <String, int>{};
    // Find "start" node or nodes with in-degree 0
    var queue = <String>[];
    
    // Prefer "start" as root
    final startNode = data.nodes.any((n) => n.id == 'start') ? 'start' : null;
    if (startNode != null) {
      queue.add(startNode);
      ranks[startNode] = 0;
    } else {
      // Fallback to all in-degree 0 nodes
      for (var node in data.nodes) {
        if (inDegree[node.id] == 0) {
          queue.add(node.id);
          ranks[node.id] = 0;
        }
      }
    }
    
    // If still empty (cycles?), pick arbitrary
    if (queue.isEmpty && data.nodes.isNotEmpty) {
      queue.add(data.nodes.first.id);
      ranks[data.nodes.first.id] = 0;
    }

    final visited = <String>{...queue};
    
    while (queue.isNotEmpty) {
      final u = queue.removeAt(0);
      final r = ranks[u]!;
      
      for (var v in adj[u] ?? []) {
        if (!visited.contains(v)) {
          visited.add(v);
          ranks[v] = r + 1;
          queue.add(v);
        } else {
          // If already visited but rank is unset or we found a longer path?
          // For visualization, max rank is usually better
          if (ranks.containsKey(v)) {
             ranks[v] = (ranks[v]! < r + 1) ? r + 1 : ranks[v]!;
          } else {
             ranks[v] = r + 1;
          }
        }
      }
    }

    // Handle disconnected components
    for (var node in data.nodes) {
      if (!ranks.containsKey(node.id)) {
        ranks[node.id] = 0; // Place unreachables at rank 0
      }
    }

    // 3. Assign positions
    // Group by rank
    final nodesByRank = <int, List<String>>{};
    ranks.forEach((nodeId, rank) {
      nodesByRank.putIfAbsent(rank, () => []).add(nodeId);
    });

    const cardWidth = 200.0;
    const cardHeight = 100.0;
    const xSpacing = 250.0;
    const ySpacing = 150.0;
    const startX = 50.0;
    const startY = 50.0;

    nodesByRank.forEach((rank, nodeIds) {
      double currentY = startY;
      for (var nodeId in nodeIds) {
        _nodePositions[nodeId] = Offset(startX + rank * xSpacing, currentY);
        currentY += ySpacing;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF00E4D7)),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error loading graph: $_error',
                style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadGraph,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_graphData == null || _graphData!.nodes.isEmpty) {
      return const Center(
        child: Text(
          'No files in this folder',
          style: TextStyle(color: Colors.white54),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return InteractiveViewer(
          constrained: false,
          boundaryMargin: const EdgeInsets.all(double.infinity),
          minScale: 0.1,
          maxScale: 4.0,
          child: SizedBox(
            width: 2000, // Arbitrary large size for scrollable area
            height: 2000,
            child: Stack(
              children: [
                // Edges
                CustomPaint(
                  size: const Size(2000, 2000),
                  painter: EdgePainter(
                    edges: _graphData!.edges,
                    nodePositions: _nodePositions,
                    cardWidth: 200,
                    cardHeight: 100,
                  ),
                ),
                // Nodes
                ..._graphData!.nodes.map((node) {
                  final pos = _nodePositions[node.id] ?? Offset.zero;
                  return Positioned(
                    left: pos.dx,
                    top: pos.dy,
                    child: _buildNodeCard(node),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNodeCard(GraphNode node) {
    final isStart = node.id == 'start';
    
    return GestureDetector(
      onTap: () => widget.onFileTap(node.path),
      child: Container(
        width: 200,
        height: 100,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF2D1B4E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isStart 
                ? const Color(0xFF00E4D7) 
                : Colors.white.withValues(alpha: 0.1),
            width: isStart ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isStart ? Icons.flag : Icons.web,
                  size: 16,
                  color: isStart ? const Color(0xFF00E4D7) : Colors.white70,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    node.label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              node.id,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EdgePainter extends CustomPainter {
  final List<GraphEdge> edges;
  final Map<String, Offset> nodePositions;
  final double cardWidth;
  final double cardHeight;

  EdgePainter({
    required this.edges,
    required this.nodePositions,
    required this.cardWidth,
    required this.cardHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final arrowPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    for (var edge in edges) {
      final startPos = nodePositions[edge.source];
      final endPos = nodePositions[edge.target];

      if (startPos != null && endPos != null) {
        // Calculate connecting points (right side of source to left side of target)
        final start = Offset(startPos.dx + cardWidth, startPos.dy + cardHeight / 2);
        final end = Offset(endPos.dx, endPos.dy + cardHeight / 2);

        // Draw bezier curve
        final path = Path();
        path.moveTo(start.dx, start.dy);
        
        final controlPoint1 = Offset(start.dx + 50, start.dy);
        final controlPoint2 = Offset(end.dx - 50, end.dy);
        
        path.cubicTo(
          controlPoint1.dx, controlPoint1.dy,
          controlPoint2.dx, controlPoint2.dy,
          end.dx, end.dy,
        );

        canvas.drawPath(path, paint);

        // Draw arrow head
        final arrowPath = Path();
        arrowPath.moveTo(end.dx, end.dy);
        arrowPath.lineTo(end.dx - 10, end.dy - 5);
        arrowPath.lineTo(end.dx - 10, end.dy + 5);
        arrowPath.close();
        
        canvas.drawPath(arrowPath, arrowPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant EdgePainter oldDelegate) => true;
}


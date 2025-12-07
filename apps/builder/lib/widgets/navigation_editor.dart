import 'package:flutter/material.dart';

class NavigationEditor extends StatelessWidget {
  final Map<String, dynamic>? navigation;
  final void Function(Map<String, dynamic> navigation) onUpdate;

  const NavigationEditor({
    super.key,
    this.navigation,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final nav = navigation ?? {};
    final type = nav['type'] as String? ?? 'navigate';
    final direction = nav['direction'] as String? ?? 'left';
    final scope = nav['scope'] as String? ?? 'content';
    final durationMs = nav['durationMs'] as int? ?? 300;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(Icons.navigation, size: 16, color: Color(0xFF6C63FF)),
              const SizedBox(width: 8),
              const Text(
                'Navigation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              _buildInfoBadge(type, direction),
            ],
          ),
          const SizedBox(height: 12),
          
          // Type & Direction row
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Type',
                  value: type,
                  items: const ['navigate', 'refresh'],
                  onChanged: (value) => _updateField('type', value),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdown(
                  label: 'Direction',
                  value: direction,
                  items: const ['left', 'right', 'up', 'down'],
                  onChanged: (value) => _updateField('direction', value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          
          // Scope & Duration row
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  label: 'Scope',
                  value: scope,
                  items: const ['content', 'full'],
                  onChanged: (value) => _updateField('scope', value),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildNumberInput(
                  label: 'Durée (ms)',
                  value: durationMs,
                  onChanged: (value) => _updateField('durationMs', value),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBadge(String type, String direction) {
    final icon = type == 'refresh' 
        ? Icons.refresh 
        : _getDirectionIcon(direction);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF6C63FF)),
          const SizedBox(width: 4),
          Text(
            type == 'refresh' ? 'Refresh' : direction,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF6C63FF),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getDirectionIcon(String direction) {
    switch (direction) {
      case 'left':
        return Icons.arrow_back;
      case 'right':
        return Icons.arrow_forward;
      case 'up':
        return Icons.arrow_upward;
      case 'down':
        return Icons.arrow_downward;
      default:
        return Icons.arrow_forward;
    }
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF252538),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: items.contains(value) ? value : items.first,
              isExpanded: true,
              isDense: true,
              dropdownColor: const Color(0xFF252538),
              style: const TextStyle(fontSize: 12, color: Colors.white),
              icon: Icon(
                Icons.expand_more,
                size: 16,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberInput({
    required String label,
    required int value,
    required void Function(int) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFF252538),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => onChanged((value - 50).clamp(0, 2000)),
                child: Container(
                  width: 28,
                  height: 32,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.remove,
                    size: 14,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '$value',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () => onChanged((value + 50).clamp(0, 2000)),
                child: Container(
                  width: 28,
                  height: 32,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                    size: 14,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _updateField(String key, dynamic value) {
    final nav = Map<String, dynamic>.from(navigation ?? {});
    nav[key] = value;
    onUpdate(nav);
  }
}


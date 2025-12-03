/// Modèle représentant un centre d'intérêt
class Interest {
  final int id;
  final String name;
  final String category;
  final String description;
  final String? emoji;

  const Interest({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    this.emoji,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'description': description,
        if (emoji != null) 'emoji': emoji,
      };

  factory Interest.fromJson(Map<String, dynamic> json) => Interest(
        id: json['id'] as int,
        name: json['name'] as String,
        category: json['category'] as String,
        description: json['description'] as String,
        emoji: json['emoji'] as String?,
      );

  @override
  String toString() => 'Interest($id: $name)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Interest && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}


class SubCategory {
  final int? id;
  final String name;
  final String? description;
  final int? categoryId;

  SubCategory({
    this.id,
    required this.name,
    this.description,
    this.categoryId,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      categoryId: json['category']?['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': categoryId != null ? {'id': categoryId} : null,
    };
  }
}

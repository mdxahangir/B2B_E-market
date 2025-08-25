class Product {
  int? id;
  String name;
  String? description;
  double price;
  int stock;
  int discount;
  int? categoryId;
  int? subCategoryId;
  String? imageUrl;

  String? createdByCode;
  String? createdByName;
  DateTime? createdAt;

  String? updatedByCode;
  String? updatedByName;
  DateTime? updatedAt;

  Product({
    this.id,
    required this.name,
    this.description,
    required this.price,
    required this.stock,
    required this.discount,
    this.categoryId,
    this.subCategoryId,
    this.imageUrl,
    this.createdByCode,
    this.createdByName,
    this.createdAt,
    this.updatedByCode,
    this.updatedByName,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] is int)
          ? (json['price'] as int).toDouble()
          : (json['price'] as double),
      stock: json['stock'],
      discount: json['discount'],
      categoryId: json['category'] != null ? json['category']['id'] : null,
      subCategoryId:
          json['subCategory'] != null ? json['subCategory']['id'] : null,
      imageUrl: json['image_url'],
      createdByCode: json['createdByCode'],
      createdByName: json['createdByName'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedByCode: json['updatedByCode'],
      updatedByName: json['updatedByName'],
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'discount': discount,
      'category': categoryId != null ? {'id': categoryId} : null,
      'subCategory': subCategoryId != null ? {'id': subCategoryId} : null,
      'image_url': imageUrl,
      'createdByCode': createdByCode,
      'createdByName': createdByName,
      'createdAt': createdAt?.toIso8601String(),
      'updatedByCode': updatedByCode,
      'updatedByName': updatedByName,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

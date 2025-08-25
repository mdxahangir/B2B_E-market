class ShippingMethod {
  final int? id;
  final String name;
  final String? description;
  final double cost;
  final String provider; // Keep as String unless you want to create a Dart enum for ShippingProvider
  final int estimatedDeliveryDays;
  final bool isActive;  // Added to match the Spring Boot model

  ShippingMethod({
    this.id,
    required this.name,
    this.description,
    required this.cost,
    required this.provider,
    required this.estimatedDeliveryDays,
    required this.isActive,
  });

  factory ShippingMethod.fromJson(Map<String, dynamic> json) {
    return ShippingMethod(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      cost: (json['cost'] as num).toDouble(),
      provider: json['provider'],
      estimatedDeliveryDays: json['estimatedDeliveryDays'],
      isActive: json['isActive'] ?? true, // Default true if not provided
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'cost': cost,
      'provider': provider,
      'estimatedDeliveryDays': estimatedDeliveryDays,
      'isActive': isActive,
    };
  }
}

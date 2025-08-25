// class OrderSummary {
//   int? id;
//   int userId;
//   int addressId;
//   int productId; 
//   String? name;  
//   int? quantity; 
//   double grandTotal;
//   DateTime? orderDate; 

//   OrderSummary({
//     this.id,
//     required this.userId,
//     required this.addressId,
//     required this.productId,
//     this.name,
//     this.quantity,
//     required this.grandTotal,
//     this.orderDate,
//   });

//   factory OrderSummary.fromJson(Map<String, dynamic> json) {
//     return OrderSummary(
//       id: json['id'],
//       userId: json['userId'],
//       addressId: json['addressId'],
//       productId: json['productId'],
//       name: json['name'],
//       quantity: json['quantity'],
//       grandTotal: (json['grandTotal'] as num).toDouble(),
//       orderDate: json['orderDate'] != null ? DateTime.parse(json['orderDate']) : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         if (id != null) 'id': id,
//         'userId': userId,
//         'addressId': addressId,
//         'productId': productId,
//         if (name != null) 'name': name,
//         if (quantity != null) 'quantity': quantity,
//         'grandTotal': grandTotal,
//         if (orderDate != null) 'orderDate': orderDate!.toIso8601String(),
//       };
// }
import 'payment_status.dart';
import 'payment_method.dart';


class OrderSummary {
  int? id;
  int userId;
  int addressId;
  int productId;
  String name;
  int quantity;
  double grandTotal;
  DateTime orderDate;
  PaymentStatus status;
  PaymentMethod method;

  OrderSummary({
    this.id,
    required this.userId,
    required this.addressId,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.grandTotal,
    required this.orderDate,
    required this.status,
    required this.method,
  });

  factory OrderSummary.fromJson(Map<String, dynamic> json) {
    return OrderSummary(
      id: json['id'],
      userId: json['userId'],
      addressId: json['addressId'],
      productId: json['productId'],
      name: json['name'],
      quantity: json['quantity'],
      grandTotal: (json['grandTotal'] as num).toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      status: PaymentStatusExtension.fromString(json['status']),
      method: PaymentMethodExtension.fromString(json['method']),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'userId': userId,
        'addressId': addressId,
        'productId': productId,
        'name': name,
        'quantity': quantity,
        'grandTotal': grandTotal,
        'orderDate': orderDate.toIso8601String(),
        'status': status.toString().split('.').last,
        'method': method.toString().split('.').last,
      };
}

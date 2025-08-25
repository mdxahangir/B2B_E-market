// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/order_summary.dart';

// class OrderService {
//   static const String baseUrl = "http://localhost:8080/api/orders";

//   static Future<bool> saveOrder(OrderSummary order) async {
//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(order.toJson()),
//     );

//     return response.statusCode == 200 || response.statusCode == 201;
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/order_summary.dart';

class OrderService {
  static const String baseUrl = "http://localhost:8080/api/orders";

  static Future<bool> saveOrder(OrderSummary order) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }

  static Future<int> getTotalOrders() async {
    final response = await http.get(Uri.parse("$baseUrl/count"));

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception("Failed to fetch total orders");
    }
  }
}

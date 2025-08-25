// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/order_summary.dart';

// class OrderList {
//   static const String baseUrl = 'http://localhost:8080/api/orders';

//   // Fetch all orders from backend API
//   static Future<List<OrderSummary>> fetchOrders() async {
//     final response = await http.get(Uri.parse(baseUrl));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonList = json.decode(response.body);
//       return jsonList.map((json) => OrderSummary.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load orders');
//     }
//   }
// }
import 'dart:convert';

import 'package:e_market/models/order_summary.dart';
import 'package:http/http.dart' as http;

class OrderList {
  static const String baseUrl = 'http://localhost:8080/api/orders';

  static Future<List<OrderSummary>> fetchOrders() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => OrderSummary.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load orders');
    }
  }

  static Future<void> deleteOrder(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete order with id $id');
    }
  }
}

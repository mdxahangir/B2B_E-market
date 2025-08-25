import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_address.dart';
import '../models/order_summary.dart';

class AddressService {
  static const String baseUrl = 'http://localhost:8080/api'; // Change for real device

  static Future<int?> saveAddress(UserAddress address) async {
    final url = Uri.parse('$baseUrl/addresses');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(address.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['id'];
    }
    print("❌ Error saving address: ${response.body}");
    return null;
  }

  static Future<bool> submitOrder(OrderSummary order) async {
    final url = Uri.parse('$baseUrl/orders');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(order.toJson()),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
}

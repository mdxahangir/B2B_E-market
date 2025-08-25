// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/shipping_method.dart';

// class ShippingMethodService {
//   static const String baseUrl = 'http://localhost:8080/api/shipping-methods';

//   static Future<List<ShippingMethod>> fetchShippingMethods() async {
//     final response = await http.get(Uri.parse(baseUrl));

//     if (response.statusCode == 200) {
//       List data = json.decode(response.body);
//       return data.map((json) => ShippingMethod.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load shipping methods');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shipping_method.dart';

class ShippingMethodService {
  static const String baseUrl = 'http://localhost:8080/api/shipping-methods';

  // Create a new shipping method (POST)
  Future<ShippingMethod> createShippingMethod(ShippingMethod method) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(method.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return ShippingMethod.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create shipping method: ${response.body}');
    }
  }

  // Optional: fetch list of all shipping methods (GET)
  static Future<List<ShippingMethod>> fetchShippingMethods() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => ShippingMethod.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load shipping methods');
    }
  }
}

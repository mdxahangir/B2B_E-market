// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import '../models/payment.dart';

// class PaymentService {
//   static const String baseUrl = "http://localhost:8080/api/payments";

//   static Future<int?> savePayment(Payment payment) async {
//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(payment.toJson()),
//     );

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final data = jsonDecode(response.body);
//       return data['id']; // return paymentId
//     } else {
//       print("Failed to save payment: ${response.body}");
//       return null;
//     }
//   }
// }

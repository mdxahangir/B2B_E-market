import 'dart:convert';
import 'package:e_market/models/subcategory.dart';
import 'package:http/http.dart' as http;


class SubCategoryService {
  static const String baseUrl = 'http://localhost:8080/api/sub-categories';

  // Fetch subcategories filtered by categoryId
  static Future<List<SubCategory>> getSubCategoriesByCategoryId(int categoryId) async {
    final uri = Uri.parse('$baseUrl?categoryId=$categoryId');  // adjust param if needed
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => SubCategory.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  Future<List<SubCategory>> fetchAll() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => SubCategory.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load subcategories');
    }
  }

  Future<SubCategory> create(SubCategory subCategory) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subCategory.toJson()),
    );
    if (response.statusCode == 200) {
      return SubCategory.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create subcategory');
    }
  }

  Future<SubCategory> update(int id, SubCategory subCategory) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subCategory.toJson()),
    );
    if (response.statusCode == 200) {
      return SubCategory.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update subcategory');
    }
  }

  Future<void> delete(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete subcategory');
    }
  }
}

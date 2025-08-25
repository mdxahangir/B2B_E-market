import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _products = await ProductService.getAllProducts();
    notifyListeners();
  }

  Future<void> addProductMobile(Product product, XFile imageFile) async {
    final newProduct =
        await ProductService.createProductMobile(product, File(imageFile.path));
    _products.add(newProduct);
    notifyListeners();
  }

  Future<void> addProductWeb(
      Product product, String fileName, Uint8List imageBytes) async {
    final newProduct =
        await ProductService.createProductWeb(product, fileName, imageBytes);
    _products.add(newProduct);
    notifyListeners();
  }

  Future<void> deleteProduct(int id) async {
    await ProductService.deleteProduct(id);
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }
}

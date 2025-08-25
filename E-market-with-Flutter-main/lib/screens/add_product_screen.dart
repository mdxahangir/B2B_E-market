import 'dart:io';
import 'dart:typed_data';
import 'package:e_market/models/subcategory.dart';
import 'package:e_market/services/subcategory_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../models/category.dart';

import '../models/product.dart';
import '../providers/product_provider.dart';
import '../services/category_service.dart';   // We'll create this service to fetch categories // And this one for subcategories

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});
  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}
class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final picker = ImagePicker();
  String name = '';
  String description = '';
  double price = 0;
  int stock = 0;
  int discount = 0;
  XFile? pickedImage;
  Uint8List? webImageBytes;
  List<Category> categories = [];
  List<SubCategory> subCategories = [];
  Category? selectedCategory;
  SubCategory? selectedSubCategory;
  @override
  void initState() {
    super.initState();
    loadCategories();
  }
  Future<void> loadCategories() async {
    try {
      final fetchedCategories = await CategoryService.getAllCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      // Handle error, maybe show a snackbar
      print('Failed to load categories: $e');
    }
  }
  Future<void> loadSubCategories(int categoryId) async {
    try {
      final fetchedSubCategories =
          await SubCategoryService.getSubCategoriesByCategoryId(categoryId);
      setState(() {
        subCategories = fetchedSubCategories;
        selectedSubCategory = null; // Reset subcategory on new category select
      });
    } catch (e) {
      print('Failed to load subcategories: $e');
    }
  }
  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        pickedImage = picked;
      });
      if (kIsWeb) {
        final bytes = await picked.readAsBytes();
        setState(() {
          webImageBytes = bytes;
        });
      }
    }
  }
  Future<void> saveProduct() async {
    if (!_formKey.currentState!.validate()) return;
    if (pickedImage == null || (kIsWeb && webImageBytes == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return;
    }
    if (selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }
    if (selectedSubCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a subcategory')),
      );
      return;
    }
    _formKey.currentState!.save();
final product = Product(
  name: name,
  description: description,
  price: price,
  stock: stock,
  discount: discount,
  categoryId: selectedCategory!.id,
  subCategoryId: selectedSubCategory!.id,
);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    try {
      if (kIsWeb) {
        await productProvider.addProductWeb(
          product,
          pickedImage!.name,
          webImageBytes!,
        );
      } else {
        await productProvider.addProductMobile(product, pickedImage!);
      }
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val ?? '',
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
              ),
              // Description
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                onSaved: (val) => description = val ?? '',
              ),
              // Price
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                onSaved: (val) =>
                    price = double.tryParse(val ?? '0') ?? 0.0,
              ),
              // Stock
              TextFormField(
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                onSaved: (val) => stock = int.tryParse(val ?? '0') ?? 0,
              ),
              // Discount
              TextFormField(
                decoration: const InputDecoration(labelText: 'Discount'),
                keyboardType: TextInputType.number,
                onSaved: (val) => discount = int.tryParse(val ?? '0') ?? 0,
              ),
              const SizedBox(height: 20),
              // Category Dropdown
              DropdownButtonFormField<Category>(
                decoration: const InputDecoration(labelText: 'Category'),
                value: selectedCategory,
                items: categories
                    .map(
                      (cat) => DropdownMenuItem<Category>(
                        value: cat,
                        child: Text(cat.name),
                      ),
                    )
                    .toList(),
                onChanged: (Category? newCat) {
                  setState(() {
                    selectedCategory = newCat;
                    selectedSubCategory = null;
                    subCategories = [];
                  });
                  if (newCat != null) {
                    loadSubCategories(newCat.id!);
                  }
                },
                validator: (val) =>
                    val == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 10),
              // SubCategory Dropdown
              DropdownButtonFormField<SubCategory>(
                decoration: const InputDecoration(labelText: 'SubCategory'),
                value: selectedSubCategory,
                items: subCategories
                    .map(
                      (subCat) => DropdownMenuItem<SubCategory>(
                        value: subCat,
                        child: Text(subCat.name),
                      ),
                    )
                    .toList(),
                onChanged: (SubCategory? newSubCat) {
                  setState(() {
                    selectedSubCategory = newSubCat;
                  });
                },
                validator: (val) =>
                    val == null ? 'Please select a subcategory' : null,
              ),
              const SizedBox(height: 20),
              // Image Preview
              pickedImage != null
                  ? kIsWeb
                      ? Image.memory(webImageBytes!, height: 150)
                      : Image.file(File(pickedImage!.path), height: 150)
                  : const Text('No Image Selected'),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: pickImage,
                child: const Text('Choose Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveProduct,
                child: const Text('Save Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

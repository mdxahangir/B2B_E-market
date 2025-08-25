import 'package:e_market/providers/cart_provider.dart';
import 'package:e_market/screens/cart_summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/category.dart';
import '../models/subcategory.dart';
import '../models/rating.dart';
import '../services/category_service.dart';
import '../services/subcategory_service.dart';
import '../services/rating_service.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? categoryName;
  String? subCategoryName;
  List<Rating> ratings = [];
  final _reviewController = TextEditingController();
  int _selectedRating = 5;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _loadCategoryAndSubcategoryNames();
    _fetchRatings();
  }

  void _loadCategoryAndSubcategoryNames() async {
    try {
      if (widget.product.categoryId != null) {
        final categories = await CategoryService.fetchCategories();
        final category = categories.firstWhere(
          (c) => c.id == widget.product.categoryId,
          orElse: () => Category(id: 0, name: 'Unknown', description: ''),
        );
        setState(() => categoryName = category.name);
      }

      if (widget.product.subCategoryId != null) {
        final subCategories = await SubCategoryService().fetchAll();
        final sub = subCategories.firstWhere(
          (s) => s.id == widget.product.subCategoryId,
          orElse: () => SubCategory(id: 0, name: 'Unknown'),
        );
        setState(() => subCategoryName = sub.name);
      }
    } catch (e) {
      setState(() {
        categoryName ??= 'Error';
        subCategoryName ??= 'Error';
      });
    }
  }

  void _fetchRatings() async {
    try {
      final result = await RatingService.getByProduct(widget.product.id!);
      setState(() {
        ratings = result;
      });
    } catch (e) {
      // Handle error or show a message
    }
  }

  Future<void> _submitReview() async {
    if (_reviewController.text.trim().isEmpty) return;

    setState(() => isSubmitting = true);

    try {
      await RatingService.createRating(
        productId: widget.product.id!,
        rating: _selectedRating,
        review: _reviewController.text.trim(),
      );
      _reviewController.clear();
      _selectedRating = 5;
      _fetchRatings();
    } catch (e) {
      // Handle error
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  String _formatDateTime(DateTime? dt) {
    if (dt == null) return 'N/A';
    return DateFormat('yyyy-MM-dd HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: theme.colorScheme.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (product.imageUrl != null)
              Image.network(
                'http://localhost:8080${product.imageUrl}',
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            else
              const SizedBox(
                height: 250,
                child: Center(child: Icon(Icons.image_not_supported, size: 100)),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text("৳ ${product.price.toStringAsFixed(2)}",
                          style: theme.textTheme.headlineSmall?.copyWith(color: Colors.green.shade700)),
                      const SizedBox(width: 16),
                      if (product.discount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(6)),
                          child: Text("Discount: ${product.discount}%", style: const TextStyle(color: Colors.white)),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text("Stock: ${product.stock}", style: const TextStyle(color: Colors.black87)),
                  const SizedBox(height: 16),
                  Text(product.description ?? "No description available.", style: const TextStyle(fontSize: 16)),

                  const Divider(height: 32),

                  Row(
                    children: [
                      Text("Category: ", style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text(categoryName ?? "Loading..."),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text("SubCategory: ", style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
                      Text(subCategoryName ?? "Loading..."),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.add_shopping_cart),
                          label: const Text("Add to Cart"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addToCart(widget.product.id!, 1, product: widget.product);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Added to cart')),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.shopping_bag),
                          label: const Text("Buy Now"),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .addToCart(widget.product.id!, 1, product: widget.product);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CartSummaryScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 32),
                  Text("Created By: ${product.createdByName ?? "N/A"} (${product.createdByCode ?? "N/A"})"),
                  Text("Created At: ${_formatDateTime(product.createdAt)}"),
                  const SizedBox(height: 12),
                  Text("Updated By: ${product.updatedByName ?? "N/A"} (${product.updatedByCode ?? "N/A"})"),
                  Text("Updated At: ${_formatDateTime(product.updatedAt)}"),
                  const Divider(height: 32),
                  

                  /// ✅ Ratings & Reviews
                  Text("Ratings & Reviews", style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  if (ratings.isEmpty)
                    const Text("No reviews yet.")
                  else
                    ...ratings.map((r) => ListTile(
                          leading: CircleAvatar(child: Text(r.rating.toString())),
                          title: Text(r.review ?? ''),
                          subtitle: Text("By: ${r.user?.fullName ?? 'Anonymous'}\n${_formatDateTime(r.createdAt)}"),
                          isThreeLine: true,
                        )),
                  const SizedBox(height: 24),

                  /// ✅ Review Form
                  Text("Leave a Review", style: theme.textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      5,
                      (index) => IconButton(
                        icon: Icon(
                          Icons.star,
                          color: index < _selectedRating ? Colors.orange : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() => _selectedRating = index + 1);
                        },
                      ),
                    ),
                  ),
                  TextField(
                    controller: _reviewController,
                    decoration: const InputDecoration(
                      labelText: "Write a review",
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isSubmitting ? null : _submitReview,
                      child: isSubmitting ? const CircularProgressIndicator() : const Text("Submit Review"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

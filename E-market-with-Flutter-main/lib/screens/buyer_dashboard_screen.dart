import 'dart:io';
import 'package:e_market/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../models/user.dart';
import '../models/category.dart';
import '../models/product.dart';
import '../services/category_service.dart';
import '../services/product_service.dart';

class BuyerDashboardScreen extends StatefulWidget {
  final User user;

  const BuyerDashboardScreen({super.key, required this.user});

  @override
  State<BuyerDashboardScreen> createState() => _BuyerDashboardScreenState();
}

class _BuyerDashboardScreenState extends State<BuyerDashboardScreen> {
  List<Category> categories = [];
  List<Product> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final fetchedCategories = await CategoryService.getAllCategories();
      final fetchedProducts = await ProductService.getAllProducts();
      setState(() {
        categories = fetchedCategories;
        products = fetchedProducts;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text('Buyer Dashboard', style: TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: _buildMenuList(context),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, ${widget.user.fullName}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // 🔍 Search
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search products...',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Icon(Icons.search),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 🏷 Categories
                  const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) => _buildCategoryChip(categories[index].name),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 🛍 Products
                  const Text('Recommended for you', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (_, index) => _buildProductCard(products[index]),
                  ),
                ],
              ),
            ),
    );
  }

  // 🔹 Category Chip
  Widget _buildCategoryChip(String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(name),
        backgroundColor: Colors.blue.shade50,
        side: BorderSide(color: Colors.blue.shade300),
      ),
    );
  }

  // 🔹 Product Card with Wishlist, View Details, Discount
  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          // Image & Discount
          Stack(
            children: [
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  image: DecorationImage(
                    image: product.imageUrl != null
                        ? NetworkImage(product.imageUrl!)
                        : const AssetImage('assets/product.png') as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if (product.discount > 0)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '-${product.discount}%',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.green)),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.name} added to wishlist')),
                        );
                      },
                      icon: const Icon(Icons.favorite_border, size: 16),
                      label: const Text('Wishlist', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade50,
                        foregroundColor: Colors.pink,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(product: product),
                          ),
                        );
                      },
                      icon: const Icon(Icons.visibility, size: 16),
                      label: const Text('Details', style: TextStyle(fontSize: 12)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50,
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    return Column(
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(widget.user.fullName),
          accountEmail: Text(widget.user.email ?? 'No email'),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text(
              widget.user.fullName.isNotEmpty ? widget.user.fullName[0].toUpperCase() : '?',
              style: const TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ),
          decoration: const BoxDecoration(color: Colors.blue),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Browse Products'),
                onTap: () => Navigator.pushNamed(context, '/browse-products'),
              ),
              ListTile(
                leading: const Icon(Icons.assignment),
                title: const Text('My Orders'),
                onTap: () => Navigator.pushNamed(context, '/my-orders'),
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('My Wishlist'),
                onTap: () => Navigator.pushNamed(context, '/wishlist'),
              ),
               ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Cart Items'),
                onTap: () => Navigator.pushNamed(context, '/cart'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Profile Settings'),
                onTap: () => Navigator.pushNamed(context, '/buyer-profile'),
              ),
              ListTile(
                leading: const Icon(Icons.local_offer),
                title: const Text('Offers & Promotions'),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Offers & promotions coming soon...')),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text('Logout', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    setState(() {
      _isLoading = false;
    });
  }

  void _viewProduct(Product product) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(product.name),
        content: Text(product.description ?? 'No description'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
        ],
      ),
    );
  }

  void _editProduct(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Edit tapped for: ${product.name}")),
    );
  }

  void _deleteProduct(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Product'),
        content: const Text('Are you sure you want to delete this product?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      await Provider.of<ProductProvider>(context, listen: false).deleteProduct(id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final productList = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      appBar: AppBar(title: const Text('Product List (Excel Style)')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('ID')),
                  DataColumn(label: Text('Image')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Category')),
                  DataColumn(label: Text('SubCategory')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Discount')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: productList.map((product) {
                  return DataRow(cells: [
                    DataCell(Text(product.id?.toString() ?? '')),
                    DataCell(
                      product.imageUrl != null
                          ? Image.network(product.imageUrl!, width: 40, height: 40)
                          : const Icon(Icons.image_not_supported),
                    ),
                    DataCell(Text(product.name)),
                    DataCell(Text(product.categoryId?.toString() ?? 'N/A')),
                    DataCell(Text(product.subCategoryId?.toString() ?? 'N/A')),
                    DataCell(Text('\$${product.price.toStringAsFixed(2)}')),
                    DataCell(Text('${product.discount}%')),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.visibility),
                          tooltip: 'View',
                          onPressed: () => _viewProduct(product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          tooltip: 'Edit',
                          onPressed: () => _editProduct(product),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          tooltip: 'Delete',
                          onPressed: () => _deleteProduct(product.id!),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
    );
  }
}

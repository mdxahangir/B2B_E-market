import 'package:flutter/material.dart';

class ManageProductsScreen extends StatefulWidget {
  const ManageProductsScreen({super.key});

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> tabs = const [
    Tab(text: "Add Category"),
    Tab(text: "Add Subcategory"),
    Tab(text: "Add Product"),
    Tab(text: "Product List"),
  ];

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        backgroundColor: Colors.teal,
        bottom: TabBar(
          controller: _tabController,
          tabs: tabs,
          indicatorColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AddCategoryForm(),
          _AddSubCategoryForm(),
          _AddProductForm(),
          _ProductListView(),
        ],
      ),
    );
  }
}

// 🟢 Dummy category form
class _AddCategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Add Category Form (Coming Soon)"));
  }
}

// 🟢 Dummy subcategory form
class _AddSubCategoryForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Add Subcategory Form (Coming Soon)"));
  }
}

// 🟢 Dummy product form
class _AddProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Add Product Form (Coming Soon)"));
  }
}

//product list
class _ProductListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5, 
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.inventory),
          title: Text('Product #$index'),
          subtitle: const Text('Category: Demo\nSubcategory: Demo Sub'),
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
             
            },
          ),
        );
      },
    );
  }
}

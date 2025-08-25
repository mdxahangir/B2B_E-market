import 'package:flutter/material.dart';
import '../models/user.dart';

class SupplierDashboardScreen extends StatelessWidget {
  final User user;

  const SupplierDashboardScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<_DashboardItem> dashboardItems = [
      _DashboardItem("My Products", Icons.inventory, "58"),
      _DashboardItem("Pending Orders", Icons.assignment, "23"),
      _DashboardItem("Delivered", Icons.local_shipping, "174"),
      _DashboardItem("Revenue", Icons.attach_money, "\$9.2K"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Supplier Dashboard - ${user.fullName}"),
        backgroundColor: Colors.deepPurple,
      ),

      // ✅ Sidebar Navigation (Drawer)
      drawer: Drawer(
        backgroundColor: Colors.deepPurple.shade50,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.fullName),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(user.fullName[0], style: const TextStyle(fontSize: 24)),
              ),
              decoration: const BoxDecoration(color: Colors.deepPurple),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text("Add Product"),
              onTap: () => Navigator.pushNamed(context, '/add-product'),
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("My Products"),
              onTap: () => Navigator.pushNamed(context, '/product-list'),
            ),
            ListTile(
              leading: const Icon(Icons.local_shipping),
              title: const Text("Manage Orders"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order management coming soon...")),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Profile Settings"),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Profile settings coming soon...")),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      // ✅ Main Body - Dashboard Metrics Grid
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 3,
        ),
        itemCount: dashboardItems.length,
        itemBuilder: (context, index) {
          final item = dashboardItems[index];
          return Card(
            elevation: 3,
            color: Colors.deepPurple.shade50,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(item.icon, color: Colors.white),
              ),
              title: Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item.value),
            ),
          );
        },
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final IconData icon;
  final String value;

  _DashboardItem(this.title, this.icon, this.value);
}

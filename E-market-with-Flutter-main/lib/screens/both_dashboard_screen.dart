import 'package:flutter/material.dart';
import '../models/user.dart';
import 'buyer_dashboard_screen.dart';
import 'supplier_dashboard_screen.dart';

class BothDashboardScreen extends StatefulWidget {
  final User user;

  const BothDashboardScreen({super.key, required this.user});

  @override
  State<BothDashboardScreen> createState() => _BothDashboardScreenState();
}

class _BothDashboardScreenState extends State<BothDashboardScreen> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    // Define buyer and supplier dashboards
    _screens = [
      BuyerDashboardScreen(user: widget.user),
      SupplierDashboardScreen(user: widget.user),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text('Both Dashboard'),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabSelected,
        selectedItemColor: theme.colorScheme.primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Buyer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Supplier',
          ),
        ],
      ),
    );
  }
}

import 'package:e_market/providers/cart_provider.dart';
import 'package:e_market/screens/add_category_screen.dart';
import 'package:e_market/screens/add_product_screen.dart';
import 'package:e_market/screens/add_subcategory_screen.dart';
import 'package:e_market/screens/cart_summary_screen.dart';
import 'package:e_market/screens/order_list.dart';
import 'package:e_market/screens/product_detail_screen.dart';
import 'package:e_market/screens/product_list_screen.dart';
import 'package:e_market/screens/register_screen.dart';
import 'package:e_market/screens/shipping_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'screens/login_screen.dart';
import 'providers/product_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()), 
      ],
      child: MaterialApp(
        title: 'B2B E-Market',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 18),
          ),
        ),
        home: const LandingPage(),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/add-category': (context) => const AddCategoryScreen(),
          '/add-subcategory': (context) => const AddSubCategoryScreen(),
          '/add-product': (context) => const AddProductScreen(),
          '/product-list': (context) => const ProductListScreen(),
          '/cart': (context) => const CartSummaryScreen(),
          '/shippling-method': (context) => const ShippingFormPage(),
          '/order-list': (context) => const OrderListScreen(),

        },
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text('B2B E-Market', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_checkout, size: 80, color: theme.colorScheme.primary),
              const SizedBox(height: 20),
              Text(
                'Welcome to B2B E-Market',
                style: theme.textTheme.headlineLarge?.copyWith(color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: const Icon(Icons.login),
                label: const Text('Login'),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: BorderSide(color: theme.colorScheme.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                icon: const Icon(Icons.app_registration),
                label: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

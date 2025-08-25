import 'package:e_market/screens/admin_dashboard_screen.dart';
import 'package:e_market/screens/both_dashboard_screen.dart';
import 'package:e_market/screens/buyer_dashboard_screen.dart';
import 'package:e_market/screens/register_screen.dart';
import 'package:e_market/screens/supplier_dashboard_screen.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  void handleLogin() async {
  final user = await ApiService.login(emailController.text, passwordController.text);

  if (user != null) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Welcome ${user.fullName}')),
  );

  if (user.role == "ADMIN") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AdminDashboardScreen(user: user)),
    );
  } else if (user.role == "SUPPLIER") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SupplierDashboardScreen(user: user)),
    );
  } else if (user.role == "BUYER") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BuyerDashboardScreen(user: user)),
    );
  } else if (user.role == "BOTH") {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BothDashboardScreen(user: user)),
    );
  } else {
    // Unknown role
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Unauthorized'),
        content: Text('Access denied. Your role is not recognized.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
        ],
      ),
    );
  }
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Login failed')),
  );
}

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
            TextFormField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: handleLogin, child: Text('Login')),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()));
              },
              child: Text("Don't have an account? Register"),
            )
          ],
        ),
      ),
    );
  }
}

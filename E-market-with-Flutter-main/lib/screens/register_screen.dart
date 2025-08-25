import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  String role = 'BUYER';

  void handleRegister() async {
    final user = await ApiService.register(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      role: role,
    );

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration successful!')));
      Navigator.pop(context); 
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration failed!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(controller: fullNameController, decoration: InputDecoration(labelText: 'Full Name')),
              TextFormField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              TextFormField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone')),
              TextFormField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              DropdownButtonFormField(
                value: role,
                items: ['BUYER', 'SUPPLIER', 'BOTH', 'ADMIN'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => role = value!),
                decoration: InputDecoration(labelText: 'Role'),
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: handleRegister, child: Text('Register')),
            ],
          ),
        ),
      ),
    );
  }
}

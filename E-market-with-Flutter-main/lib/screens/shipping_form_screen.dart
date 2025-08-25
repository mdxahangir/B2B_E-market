import 'package:flutter/material.dart';
import '../models/shipping_method.dart';
import '../services/shipping_method_service.dart';

class ShippingFormPage extends StatefulWidget {
  const ShippingFormPage({super.key});

  @override
  _ShippingFormPageState createState() => _ShippingFormPageState();
}

class _ShippingFormPageState extends State<ShippingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _service = ShippingMethodService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();

  String _selectedProvider = 'DHL';
  bool _isActive = true; // New: for isActive field

  final List<String> providers = [
    'DHL',
    'FEDEX',
    'UPS',
    'LOCAL_COURIER',
    'POST_OFFICE',
    'IN_HOUSE',
    'OTHER'
  ];

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final method = ShippingMethod(
          name: _nameController.text.trim(),
          description: _descController.text.trim().isNotEmpty
              ? _descController.text.trim()
              : null,
          cost: double.tryParse(_costController.text.trim()) ?? 0.0,
          provider: _selectedProvider,
          estimatedDeliveryDays:
              int.tryParse(_daysController.text.trim()) ?? 0,
          isActive: _isActive, // Pass isActive
        );

        final created = await _service.createShippingMethod(method);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Shipping method created: ${created.name}'),
          backgroundColor: Colors.green,
        ));

        _formKey.currentState!.reset();
        _nameController.clear();
        _descController.clear();
        _costController.clear();
        _daysController.clear();
        setState(() {
          _selectedProvider = 'DHL';
          _isActive = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Shipping Method")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Shipping Name"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter name" : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Description (optional)"),
              ),
              TextFormField(
                controller: _costController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: "Cost"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter cost" : null,
              ),
              DropdownButtonFormField<String>(
                value: _selectedProvider,
                items: providers
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.replaceAll("_", " ")),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProvider = value!;
                  });
                },
                decoration: const InputDecoration(labelText: "Provider"),
              ),
              TextFormField(
                controller: _daysController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Estimated Delivery Days"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter days" : null,
              ),
              const SizedBox(height: 16),

              // ✅ New: isActive toggle
              SwitchListTile(
                title: const Text("Is Active"),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

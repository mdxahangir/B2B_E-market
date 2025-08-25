import 'package:e_market/screens/process_to_checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shipping_method.dart';
import '../services/shipping_method_service.dart';
import '../providers/cart_provider.dart';

class CartSummaryScreen extends StatefulWidget {
  const CartSummaryScreen({super.key});

  @override
  State<CartSummaryScreen> createState() => _CartSummaryScreenState();
}

class _CartSummaryScreenState extends State<CartSummaryScreen> {
  List<ShippingMethod> shippingOptions = [];
  ShippingMethod? selectedShipping;
  bool isLoadingShipping = true;

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costController = TextEditingController();
  final _providerController = TextEditingController();
  final _deliveryDaysController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadShippingMethods();
  }

  Future<void> _loadShippingMethods() async {
    try {
      final options = await ShippingMethodService.fetchShippingMethods();
      setState(() {
        shippingOptions = options;
        if (options.isNotEmpty) {
          selectedShipping = options.first;
          Provider.of<CartProvider>(context, listen: false)
              .setShippingCost(selectedShipping!.cost);
        }
        isLoadingShipping = false;
      });
    } catch (e) {
      print('Error loading shipping methods: $e');
      setState(() => isLoadingShipping = false);
    }
  }

  Future<void> _addShippingMethod() async {
    try {
      final newMethod = ShippingMethod(
        name: _nameController.text,
        description: _descriptionController.text,
        cost: double.tryParse(_costController.text) ?? 0.0,
        provider: _providerController.text,
        estimatedDeliveryDays: int.tryParse(_deliveryDaysController.text) ?? 3,
        isActive: true,
      );

      final created =
          await ShippingMethodService().createShippingMethod(newMethod);

      setState(() {
        shippingOptions.add(created);
        if (selectedShipping == null) {
          selectedShipping = created;
          Provider.of<CartProvider>(context, listen: false)
              .setShippingCost(created.cost);
        }
      });

      Navigator.pop(context);
    } catch (e) {
      print("Error adding shipping method: $e");
    }
  }

  void _showAddShippingDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Add Shipping Method"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: _costController,
                decoration: const InputDecoration(labelText: "Cost"),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _providerController,
                decoration: const InputDecoration(labelText: "Provider"),
              ),
              TextField(
                controller: _deliveryDaysController,
                decoration: const InputDecoration(labelText: "Estimated Delivery Days"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: _addShippingMethod,
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.items.values.toList();
    final cartKeys = cartProvider.items.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Summary"),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_shipping),
            onPressed: _showAddShippingDialog,
          )
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty."))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final productId = cartKeys[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ListTile(
                          leading: item.product.imageUrl != null
                              ? Image.network(
                                  'http://localhost:8080${item.product.imageUrl}',
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image),
                          title: Text(item.product.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price: ৳${item.product.price.toStringAsFixed(2)}"),
                              Text("Discount: ${item.product.discount}%"),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle_outline),
                                    onPressed: () {
                                      cartProvider.decrementQuantity(productId);
                                    },
                                  ),
                                  Text("${item.quantity}"),
                                  IconButton(
                                    icon: const Icon(Icons.add_circle_outline),
                                    onPressed: () {
                                      cartProvider.incrementQuantity(productId);
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                "Total: ৳${item.totalPrice.toStringAsFixed(2)}",
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartProvider.removeFromCart(productId);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Shipping Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      const Text("Shipping Method: "),
                      const SizedBox(width: 10),
                      Expanded(
                        child: isLoadingShipping
                            ? const Text("Loading shipping methods...")
                            : DropdownButton<ShippingMethod>(
                                value: selectedShipping,
                                isExpanded: true,
                                items: shippingOptions
                                    .map(
                                      (option) => DropdownMenuItem<ShippingMethod>(
                                        value: option,
                                        child: Text("${option.name} (৳${option.cost})"),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      selectedShipping = value;
                                    });
                                    cartProvider.setShippingCost(value.cost);
                                  }
                                },
                              ),
                      ),
                    ],
                  ),
                ),

                // Price summary
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    children: [
                      summaryRow("Subtotal:", cartProvider.subtotal),
                      summaryRow("VAT (15%):", cartProvider.vat),
                      summaryRow("Shipping Cost:", cartProvider.shippingCost),
                      const Divider(thickness: 1),
                      summaryRow("Grand Total:", cartProvider.grandTotal, isBold: true),
                    ],
                  ),
                ),

                // Checkout Button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (cartItems.isNotEmpty && selectedShipping != null) {
                          final firstProductId = cartKeys.first;
                          final firstItem = cartItems.first;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProcessToCheckoutScreen(
                                grandTotal: cartProvider.grandTotal,
                                productId: firstProductId,
                                productName: firstItem.product.name,
                                productQuantity: firstItem.quantity,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select a shipping method")),
                          );
                        }
                      },
                      icon: const Icon(Icons.shopping_cart_checkout),
                      label: const Text("Checkout"),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget summaryRow(String label, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text("৳ ${value.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}

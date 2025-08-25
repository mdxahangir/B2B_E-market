// import 'package:e_market/screens/success_page.dart';
// import 'package:flutter/material.dart';
// import '../models/user_address.dart';
// import '../models/order_summary.dart';
// import '../services/address_service.dart';
// import '../services/order_service.dart';

// class ProcessToCheckoutScreen extends StatefulWidget {
//   final double grandTotal;
//   final int productId;
//   final String productName;
//   final int productQuantity;

//   const ProcessToCheckoutScreen({
//     super.key,
//     required this.grandTotal,
//     required this.productId,
//     required this.productName,
//     required this.productQuantity,
//   });

//   @override
//   State<ProcessToCheckoutScreen> createState() => _ProcessToCheckoutScreenState();
// }

// class _ProcessToCheckoutScreenState extends State<ProcessToCheckoutScreen> {
//   final _formKey = GlobalKey<FormState>();

//   String fullName = '';
//   String phoneNumber = '';
//   String addressLine1 = '';
//   String addressLine2 = '';
//   String city = '';
//   String stateOrProvince = '';
//   String postalCode = '';
//   String country = '';
//   String addressType = 'SHIPPING';

//   void _submitOrder() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();

//       final address = UserAddress(
//         fullName: fullName,
//         phoneNumber: phoneNumber,
//         addressLine1: addressLine1,
//         addressLine2: addressLine2,
//         city: city,
//         stateOrProvince: stateOrProvince,
//         postalCode: postalCode,
//         country: country,
//         addressType: addressType,
//         userId: 1,
//       );

//       final addressId = await AddressService.saveAddress(address);

//       if (addressId != null) {
//         final order = OrderSummary(
//           userId: 1,
//           addressId: addressId,
//           productId: widget.productId,
//           name: widget.productName,
//           quantity: widget.productQuantity,
//           grandTotal: widget.grandTotal,
//         );

//         final success = await OrderService.saveOrder(order);

//         if (success) {
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//               builder: (context) => SuccessOrderScreen(
//                 grandTotal: widget.grandTotal,
//               ),
//             ),
//           );
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("❌ Failed to submit order.")),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("❌ Failed to save address.")),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Process to Checkout")),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Order Summary",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             Text("Product ID: ${widget.productId}"),
//             Text("Product Name: ${widget.productName}"),
//             Text("Quantity: ${widget.productQuantity}"),
//             const Divider(thickness: 1),
//             Text(
//               "Grand Total: ৳${widget.grandTotal.toStringAsFixed(2)}",
//               style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//             const SizedBox(height: 20),

//             const Text("Shipping Address",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),

//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     decoration:
//                         const InputDecoration(labelText: "Full Name"),
//                     onSaved: (value) => fullName = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration:
//                         const InputDecoration(labelText: "Phone Number"),
//                     onSaved: (value) => phoneNumber = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration:
//                         const InputDecoration(labelText: "Address Line 1"),
//                     onSaved: (value) => addressLine1 = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration:
//                         const InputDecoration(labelText: "Address Line 2"),
//                     onSaved: (value) => addressLine2 = value ?? '',
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: "City"),
//                     onSaved: (value) => city = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration:
//                         const InputDecoration(labelText: "State/Province"),
//                     onSaved: (value) => stateOrProvince = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration:
//                         const InputDecoration(labelText: "Postal Code"),
//                     onSaved: (value) => postalCode = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: "Country"),
//                     onSaved: (value) => country = value!,
//                     validator: (value) =>
//                         value!.isEmpty ? 'Required' : null,
//                   ),
//                   const SizedBox(height: 16),
//                   DropdownButtonFormField<String>(
//                     value: addressType,
//                     items: ['SHIPPING', 'BILLING']
//                         .map((type) => DropdownMenuItem(
//                               value: type,
//                               child: Text(type),
//                             ))
//                         .toList(),
//                     onChanged: (value) =>
//                         setState(() => addressType = value!),
//                     decoration: const InputDecoration(labelText: "Address Type"),
//                   ),
//                   const SizedBox(height: 30),
//                   ElevatedButton.icon(
//                     onPressed: _submitOrder,
//                     icon: const Icon(Icons.done_all),
//                     label: const Text("Submit Order"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:e_market/models/payment_method.dart';
import 'package:e_market/models/payment_status.dart';
import 'package:e_market/screens/success_page.dart';
import 'package:flutter/material.dart';
import '../models/user_address.dart';
import '../models/order_summary.dart';
import '../services/address_service.dart';
import '../services/order_service.dart';

class ProcessToCheckoutScreen extends StatefulWidget {
  final double grandTotal;
  final int productId;
  final String productName;
  final int productQuantity;

  const ProcessToCheckoutScreen({
    super.key,
    required this.grandTotal,
    required this.productId,
    required this.productName,
    required this.productQuantity,
  });

  @override
  State<ProcessToCheckoutScreen> createState() =>
      _ProcessToCheckoutScreenState();
}

class _ProcessToCheckoutScreenState extends State<ProcessToCheckoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String fullName = '';
  String phoneNumber = '';
  String addressLine1 = '';
  String addressLine2 = '';
  String city = '';
  String stateOrProvince = '';
  String postalCode = '';
  String country = '';
  String addressType = 'SHIPPING';

  final PaymentStatus selectedStatus = PaymentStatus.PENDING;
  PaymentMethod selectedMethod = PaymentMethod.CASH_ON_DELIVERY;

  Future<void> _submitOrder() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final address = UserAddress(
        fullName: fullName,
        phoneNumber: phoneNumber,
        addressLine1: addressLine1,
        addressLine2: addressLine2,
        city: city,
        stateOrProvince: stateOrProvince,
        postalCode: postalCode,
        country: country,
        addressType: addressType,
        userId: 1,
      );

      final addressId = await AddressService.saveAddress(address);

      if (addressId != null) {
        final order = OrderSummary(
          userId: 1,
          addressId: addressId,
          productId: widget.productId,
          name: widget.productName,
          quantity: widget.productQuantity,
          grandTotal: widget.grandTotal,
          orderDate: DateTime.now(),
          status: selectedStatus,
          method: selectedMethod,
        );

        final success = await OrderService.saveOrder(order);

        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  SuccessOrderScreen(grandTotal: widget.grandTotal),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("❌ Failed to submit order.")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Failed to save address.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Process to Checkout")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Order Summary",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Product ID: ${widget.productId}"),
            Text("Product Name: ${widget.productName}"),
            Text("Quantity: ${widget.productQuantity}"),
            const Divider(thickness: 1),
            Text(
              "Grand Total: ৳${widget.grandTotal.toStringAsFixed(2)}",
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),

            const Text("Shipping Address",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField("Full Name", (value) => fullName = value!),
                  _buildTextField("Phone Number", (value) => phoneNumber = value!),
                  _buildTextField("Address Line 1", (value) => addressLine1 = value!),
                  _buildTextField("Address Line 2", (value) => addressLine2 = value ?? ''),
                  _buildTextField("City", (value) => city = value!),
                  _buildTextField("State/Province", (value) => stateOrProvince = value!),
                  _buildTextField("Postal Code", (value) => postalCode = value!),
                  _buildTextField("Country", (value) => country = value!),

                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: addressType,
                    items: ['SHIPPING', 'BILLING']
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => addressType = value!),
                    decoration:
                        const InputDecoration(labelText: "Address Type"),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<PaymentMethod>(
                    value: selectedMethod,
                    items: PaymentMethod.values
                        .map((method) => DropdownMenuItem(
                              value: method,
                              child: Text(method.name),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedMethod = value!),
                    decoration:
                        const InputDecoration(labelText: "Payment Method"),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: _submitOrder,
                    icon: const Icon(Icons.done_all),
                    label: const Text("Submit Order"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSave) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onSaved: onSave,
      validator: (value) => value == null || value.isEmpty ? 'Required' : null,
    );
  }
}

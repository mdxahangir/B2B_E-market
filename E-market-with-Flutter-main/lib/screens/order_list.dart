// import 'package:e_market/models/payment_method.dart';
// import 'package:e_market/models/payment_status.dart';
// import 'package:e_market/services/order_list.dart';
// import 'package:flutter/material.dart';
// import '../models/order_summary.dart';

// class OrderListScreen extends StatefulWidget {
//   const OrderListScreen({Key? key}) : super(key: key);

//   @override
//   State<OrderListScreen> createState() => _OrderListScreenState();
// }

// class _OrderListScreenState extends State<OrderListScreen> {
//   List<OrderSummary> _orders = [];
//   List<OrderSummary> _acceptedOrders = [];
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _fetchOrders();
//   }

//   Future<void> _fetchOrders() async {
//     try {
//       final orders = await OrderList.fetchOrders();
//       setState(() {
//         _orders = orders;
//         _isLoading = false;
//         _errorMessage = null;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   void _acceptOrder(OrderSummary order) {
//     setState(() {
//       _acceptedOrders.add(order);
//       _orders.remove(order);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Order ${order.id} accepted')),
//     );
//     // TODO: এখানে চাইলে backend এ সেভ করাও করতে পারো
//   }

//   void _rejectOrder(OrderSummary order) {
//     setState(() {
//       _orders.remove(order);
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Order ${order.id} rejected')),
//     );
//   }

//   Widget _buildOrderItem(OrderSummary order) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: ListTile(
//         title: Text('${order.name} (Product ID: ${order.productId})'),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Grand Total: \$${order.grandTotal.toStringAsFixed(2)}'),
//             Text('Payment Status: ${order.status.displayName }'),
//             Text('Payment Method: ${order.method.displayName }'),
//           ],
//         ),
//         isThreeLine: true,
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: () => _acceptOrder(order),
//               child: const Text('Accept'),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
//             ),
//             const SizedBox(width: 8),
//             ElevatedButton(
//               onPressed: () => _rejectOrder(order),
//               child: const Text('Reject'),
//               style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     if (_errorMessage != null) {
//       return Center(child: Text('Error: $_errorMessage'));
//     }

//     if (_orders.isEmpty) {
//       return const Center(child: Text('No orders available'));
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Order List'),
//       ),
//       body: ListView.builder(
//         itemCount: _orders.length,
//         itemBuilder: (context, index) {
//           final order = _orders[index];
//           return _buildOrderItem(order);
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/order_summary.dart';
import '../models/payment_status.dart';
import '../models/payment_method.dart';
import '../services/order_list.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({Key? key}) : super(key: key);

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  List<OrderSummary> _orders = [];
  List<OrderSummary> _acceptedOrders = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    try {
      final orders = await OrderList.fetchOrders();
      setState(() {
        _orders = orders;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _updatePaymentStatus(OrderSummary order, PaymentStatus newStatus) async {
    // API কল করে সার্ভারে আপডেট করার জায়গা
    // উদাহরণস্বরূপ PUT /api/orders/{id} with updated status
    // এখন শুধু লোকালি আপডেট করছি
    setState(() {
      order.status = newStatus;
    });

    // TODO: এখানে API কল লিখো backend এ আপডেটের জন্য
  }

  Future<void> _acceptOrder(OrderSummary order) async {
    setState(() {
      _acceptedOrders.add(order);
      _orders.remove(order);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Order ${order.id} accepted')),
    );
    // TODO: এখানে চাইলে backend এ save/update কল করতে পারো
  }

  Future<void> _rejectOrder(OrderSummary order) async {
    // API কল করে সার্ভার থেকে ডিলিট
    try {
      await OrderList.deleteOrder(order.id!);
      setState(() {
        _orders.remove(order);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Order ${order.id} rejected and deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject order: $e')),
      );
    }
  }

  Widget _buildOrderItem(OrderSummary order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${order.name}'),
            Text('Product ID: ${order.productId}'),
            Text('Quantity: ${order.quantity}'),
            Text('Grand Total: \$${order.grandTotal.toStringAsFixed(2)}'),
            Row(
              children: [
                const Text('Payment Status: '),
                DropdownButton<PaymentStatus>(
                  value: order.status,
                  items: PaymentStatus.values
                      .map((status) => DropdownMenuItem(
                            value: status,
                            child: Text(status.displayName),
                          ))
                      .toList(),
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      _updatePaymentStatus(order, newStatus);
                    }
                  },
                ),
              ],
            ),
            Text('Payment Method: ${order.method.displayName}'),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ElevatedButton(
                //   onPressed: () => _acceptOrder(order),
                //   child: const Text('Accept'),
                //   style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                // ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => _rejectOrder(order),
                  child: const Text('Reject'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    if (_errorMessage != null) {
      return Scaffold(
          body: Center(child: Text('Error: $_errorMessage')));
    }

    if (_orders.isEmpty) {
      return const Scaffold(body: Center(child: Text('No orders available')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Order List')),
      body: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, index) {
          return _buildOrderItem(_orders[index]);
        },
      ),
    );
  }
}

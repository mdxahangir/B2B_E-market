import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  int get totalItems => _items.values.fold(0, (sum, item) => sum + item.quantity);

  double get subtotal {
    return _items.values.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double vatRate = 0.15; // 15% VAT, you can adjust dynamically

  double shippingCost = 0.0;

  double get vat => subtotal * vatRate;

  double get grandTotal => subtotal + vat + shippingCost;

  void addToCart(int productId, int quantity, {Product? product}) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity += quantity;
    } else {
      if (product != null) {
        _items[productId] = CartItem(product: product, quantity: quantity);
      }
    }
    notifyListeners();
  }

  void incrementQuantity(int productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(int productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items[productId]!.quantity--;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void removeFromCart(int productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void setShippingCost(double cost) {
    shippingCost = cost;
    notifyListeners();
  }
}

import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  double get discountedPrice {
    return product.price - (product.price * product.discount / 100);
  }

  double get totalPrice {
    return discountedPrice * quantity;
  }
}

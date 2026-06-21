// lib/controller/cart.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ewire_task/models/cart_item.dart';
import 'package:ewire_task/models/product.dart';

class CartProvider extends ChangeNotifier {
  final Box<CartItem> _cartBox = Hive.box<CartItem>('cartBox');

  List<CartItem> get cartItems => _cartBox.values.toList();

  int get totalItems => cartItems.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  void addToCart(ProductModel product) {
    final key = product.id.toString();
    final existing = _cartBox.get(key);

    if (existing != null) {
      existing.quantity += 1;
      existing.save();
    } else {
      _cartBox.put(
        key,
        CartItem(
          productId: product.id,
          title: product.title,
          thumbnail: product.thumbnail,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    _cartBox.delete(productId.toString());
    notifyListeners();
  }

  void updateQuantity(int productId, int quantity) {
    final item = _cartBox.get(productId.toString());
    if (item == null) return;

    if (quantity <= 0) {
      _cartBox.delete(productId.toString());
    } else {
      item.quantity = quantity;
      item.save();
    }
    notifyListeners();
  }

  void clearCart() {
    _cartBox.clear();
    notifyListeners();
  }
  // inside CartProvider

  bool isInCart(int productId) {
    return _cartBox.containsKey(productId.toString());
  }

  void toggleCart(ProductModel product) {
    final key = product.id.toString();

    if (_cartBox.containsKey(key)) {
      _cartBox.delete(key);
    } else {
      _cartBox.put(
        key,
        CartItem(
          productId: product.id,
          title: product.title,
          thumbnail: product.thumbnail,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }
}

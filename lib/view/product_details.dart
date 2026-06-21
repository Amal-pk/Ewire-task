import 'package:ewire_task/controller/cart_provider.dart';
import 'package:ewire_task/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    final inCart = cart.isInCart(product.id);

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.network(product.images[0], height: 200)),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "₹${(product.price * 86).toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(product.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: inCart ? Colors.white : Colors.deepPurple,
                foregroundColor: inCart ? Colors.deepPurple : Colors.white,
              ),
              onPressed: () {
                context.read<CartProvider>().toggleCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      inCart
                          ? "${product.title} removed from cart"
                          : "${product.title} added to cart",
                    ),
                  ),
                );
              },
              child: Text(inCart ? "Remove from Cart" : "Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:ewire_task/models/product.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
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
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Text("Add to Cart"),
            ),
          ],
        ),
      ),
    );
  }
}

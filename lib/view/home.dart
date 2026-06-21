import 'package:ewire_task/controller/cart_provider.dart';
import 'package:ewire_task/controller/product.dart';
import 'package:ewire_task/controller/theme_provider.dart';
import 'package:ewire_task/view/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    final cart = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: Icon(
              context.watch<ThemeProvider>().isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () => context.read<ThemeProvider>().toggleTheme(),
          ),
          // your cart icon stays here too
        ],
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              itemCount: provider.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = provider.products[index];
                final inCart = cart.isInCart(product.id);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(product: product),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.network(product.images[0], height: 85),
                          Text(
                            product.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("₹${(product.price * 86).toStringAsFixed(2)}"),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: inCart
                                  ? Colors.white
                                  : Colors.deepPurple,
                              foregroundColor: inCart
                                  ? Colors.deepPurple
                                  : Colors.white,
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
                            child: Text(
                              inCart ? "Remove from Cart" : "Add to Cart",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

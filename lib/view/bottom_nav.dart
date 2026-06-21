import 'package:ewire_task/controller/bottom_nav_controller.dart';
import 'package:ewire_task/view/cart.dart';
import 'package:ewire_task/view/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BottomNavProvider>();

    final pages = [HomeScreen(), CartScreen()];

    return Scaffold(
      body: pages[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          context.read<BottomNavProvider>().changeIndex(index);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

import 'package:hive/hive.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String thumbnail;

  @HiveField(3)
  final double price;

  @HiveField(4)
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.thumbnail,
    required this.price,
    this.quantity = 1,
  });
}

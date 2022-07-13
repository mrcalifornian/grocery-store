import 'package:hive/hive.dart';
part 'cart_item_model.g.dart';

@HiveType(typeId: 1)
class CartItem {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String measure;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final int quantity;

  @HiveField(5)
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.measure,
    required this.imageUrl,
    required this.quantity,
    required this.price,
  });
}

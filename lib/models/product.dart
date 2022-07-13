import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final String productID;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String nutritons;

  @HiveField(4)
  final String measure;

  @HiveField(5)
  final double price;

  @HiveField(6)
  final String imageUrl;

  @HiveField(7)
  bool isFavourite;

  Product({
    required this.productID,
    required this.title,
    required this.description,
    required this.nutritons,
    required this.measure,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });
}

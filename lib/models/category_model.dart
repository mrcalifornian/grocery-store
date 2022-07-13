import 'package:grocery_store/models/product.dart';

class CategoryModel {
  final String categoryID;
  final String imageUrl;
  final String title;
  final List<Product> products;

  CategoryModel({
    required this.categoryID,
    required this.imageUrl,
    required this.title,
    required this.products,
  });
}




class CategoryData {
  final int id;
  final String name;
  final List<SubCategory> subCategory;

  CategoryData({
    required this.id,
    required this.name,
    required this.subCategory,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      name: json['name'],
      subCategory: (json['subCategory'] as List)
          .map((subCat) => SubCategory.fromJson(subCat))
          .toList(),
    );
  }
}

class SubCategory {
  final int id;
  final String name;
  final String image;
  final List<Product> products;

  SubCategory({
    required this.id,
    required this.name,
    required this.image,
    required this.products,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      products: (json['products'] as List)
          .map((prod) => Product.fromJson(prod))
          .toList(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;
  final double price;
  final int quantity;
  final double? discountPercentage;
  final bool status;

  String discountedPrice() {

    if (discountPercentage == null && discountPercentage == 0) {
      return price.toString();
    }
    final num discountAmount = (price * discountPercentage!) / 100;
    final num discountedPrice = price - discountAmount;

    return discountedPrice.toStringAsFixed(2);
  }


  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.discountPercentage,
    required this.status,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      discountPercentage: json['discountPercentage'].toDouble(),
      status: json['status'],
    );
  }
}

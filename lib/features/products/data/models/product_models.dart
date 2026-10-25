class ProductModel {
  final String id;
  final String name;
  final String? arabicName;
  final String? description;
  final String? arabicDescription;
  final double price;
  final String? coverPictureUrl;
  final List<String> productPictures;
  final double rating;
  final int reviewsCount;
  final int stock;

  const ProductModel({
    required this.id,
    required this.name,
    this.arabicName,
    this.description,
    this.arabicDescription,
    required this.price,
    this.coverPictureUrl,
    this.productPictures = const [],
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.stock = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      arabicName: json['arabicName'],
      description: json['description'],
      arabicDescription: json['arabicDescription'],
      price: (json['price'] is num) ? (json['price'] as num).toDouble() : 0.0,
      coverPictureUrl: json['coverPictureUrl'],
      productPictures: (json['productPictures'] is List)
          ? List<String>.from(json['productPictures'].map((e) => e.toString()))
          : [],
      rating: (json['rating'] is num) ? (json['rating'] as num).toDouble() : 0.0,
      reviewsCount: json['reviewsCount'] ?? 0,
      stock: json['stock'] ?? 0,
    );
  }
}

class CategoryModel {
  final String id;
  final String name;
  final String? arabicName;
  final String? pictureUrl;

  const CategoryModel({
    required this.id,
    required this.name,
    this.arabicName,
    this.pictureUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      arabicName: json['arabicName'],
      pictureUrl: json['pictureUrl'] ?? json['coverPictureUrl'],
    );
  }
}

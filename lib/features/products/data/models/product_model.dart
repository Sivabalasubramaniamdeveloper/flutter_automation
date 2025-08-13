class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final ratingJson = json['rating'] ?? {};
    return Product(
      id: json['id'] as int,
      title: (json['title'] ?? '') as String,
      price: (json['price'] as num).toDouble(),
      description: (json['description'] ?? '') as String,
      category: (json['category'] ?? '') as String,
      image: (json['image'] ?? '') as String,
      rating: (ratingJson['rate'] ?? 0).toDouble(),
      ratingCount: (ratingJson['count'] ?? 0) as int,
    );
  }
  factory Product.fromMap(Map<String, dynamic> map) {
    final ratingMap = map['rating'] ?? {};
    return Product(
      id: map['id'] as int,
      title: (map['title'] ?? '') as String,
      price: (map['price'] as num).toDouble(),
      description: (map['description'] ?? '') as String,
      category: (map['category'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      rating: (ratingMap['rate'] ?? 0).toDouble(),
      ratingCount: (ratingMap['count'] ?? 0) as int,
    );
  }

}

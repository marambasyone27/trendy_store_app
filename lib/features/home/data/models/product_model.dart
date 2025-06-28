class ProductModel {
  final int id;
  final String imageUrl;
  final String description;
  final double price;
  final double rate;
  final String title;
  final String category;
  ProductModel({
    required this.category,
    required this.title,
required this.description,
required this .id, 
 required this.imageUrl, 
 required this.price,
 required this.rate,
  });

factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    category: json['category'] as String,
    description: json['description'] as String,
    id: json['id'] as int,
    imageUrl: json['image'] as String,
   price: (json['price'] as num?)!.toDouble(),
    rate: (json['rating']['rate'] as num?)!.toDouble(), 
    title: json['title'] as String,
  );
}
}
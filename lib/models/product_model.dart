class ProductModel {
  final String category;
  final String explain;
  final String name;
  final String url;
  final String id;

  ProductModel({
    required this.category,
    required this.explain,
    required this.name,
    required this.url,
    required this.id,
  });

  factory ProductModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductModel(
      category: json['category'],
      explain: json['explain'],
      name: json['name'],
      url: json['url'],
      id: json['id'],
    );
  }
}

class Product {
  final int? id;
  final String title;
  final String discription;
  final double price;
  final String category;
  final String image;

  Product(
      {this.id,
      required this.title,
      required this.discription,
      required this.price,
      required this.category,
      required this.image});

  //from json method
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      title: json["title"],
      discription: json["description"],
      price: json["price"].toDouble(),
      category: json["category"],
      image: json["image"],
    );
  }

  //to json method
  Map<String, dynamic> toJson(Product product) {
    return {
      "id": product.id,
      "title": product.title,
      "description": product.discription,
      "price": product.price,
      "category": product.category,
      "image": product.image
    };
  }
}

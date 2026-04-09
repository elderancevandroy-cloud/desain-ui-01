class ServiceModel {
  final int id;
  final String name;
  final String icon;
  final String route;
  final String description;
  final String price;

  ServiceModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.route,
    required this.description,
    required this.price,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      route: json['route'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
    );
  }
}

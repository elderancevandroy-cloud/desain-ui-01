class BannerModel {
  final int id;
  final String title;
  final String subtitle;
  final String cta;
  final String originalPrice;
  final String discountPrice;
  final String note;
  final String image;
  final String color;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.cta,
    required this.originalPrice,
    required this.discountPrice,
    required this.note,
    required this.image,
    required this.color,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      cta: json['cta'] ?? '',
      originalPrice: json['original_price'] ?? '',
      discountPrice: json['discount_price'] ?? '',
      note: json['note'] ?? '',
      image: json['image'] ?? '',
      color: json['color'] ?? '#0077B6',
    );
  }
}

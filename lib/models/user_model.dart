class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final String dateOfBirth;
  final String address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.dateOfBirth,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      address: json['address'] ?? '',
    );
  }
}

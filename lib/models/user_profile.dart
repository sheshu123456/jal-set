class UserProfile {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String address;
  final String ward;

  UserProfile({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.ward,
    this.email,
  });
}


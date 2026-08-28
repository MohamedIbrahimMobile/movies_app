class MyUser {
  static const String collectionName = 'Users';

  String id;
  String email;
  String name;
  String phone;
  int avatarIndex;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    this.phone = '',
    this.avatarIndex = 0,
  });

  MyUser.fromFirestore(Map<String, dynamic> data)
    : this(
        id: data['id'] ?? '',
        email: data['email'] ?? '',
        name: data['name'] ?? '',
        phone: data['phone'] ?? '',
        avatarIndex: data['avatarIndex'] ?? 0,
      );

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'avatarIndex': avatarIndex,
    };
  }
}

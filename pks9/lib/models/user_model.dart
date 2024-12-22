class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String image;

  User(
      {required this.id,
      required this.image,
      required this.name,
      required this.email,
      required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['ID'],
        image: json['Image'],
        name: json['Name'],
        email: json['Mail'],
        phoneNumber: json['Phone']);
  }
}

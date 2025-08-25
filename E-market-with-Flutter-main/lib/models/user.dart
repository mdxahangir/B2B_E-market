class User {
  final String fullName;
  final String email;
  final String role;

  User({
    required this.fullName,
    required this.email,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
    );
  }
}

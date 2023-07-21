class User {
  int id;
  String email;
  String role;
  String token;

  User(this.id, this.email, this.role, this.token);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['email'], json['role'], json['token']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'token': token,
    };
  }
}

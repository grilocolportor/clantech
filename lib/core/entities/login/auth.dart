class Auth {
  String email;
  String token;
  int id;

  Auth({required this.email, required this.token, required this.id});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      email: json['email'],
      token: json['token'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
      'id': id,
    };
  }
}
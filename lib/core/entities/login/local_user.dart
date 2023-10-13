class LocalUser {
  String email;
  String token;
  String? displayName;
  String? urlPhoto;


  LocalUser({required this.email, required this.token,   this.displayName,  this.urlPhoto});

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return LocalUser(
      email: json['email'],
      token: json['token'],
      displayName: json['displayName'],
      urlPhoto: json['urlPhoto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'token': token,
      'displayName' : displayName,
      'urlPhoto' : urlPhoto,
    };
  }
}
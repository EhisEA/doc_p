class User {
  String name;
  String id;
  String email;
  bool isDoctor;
  String token;

  User({this.id, this.name, this.isDoctor, this.email, this.token});
  fromJson(Map json, String token) {
    return User(
      name: json["name"],
      id: json["public_id"],
      email: json["email"],
      token: token,
      isDoctor: json["is_doctor"] ?? false,
    );
  }

  fromMap(Map json) {
    return User(
      name: json["name"],
      id: json["public_id"],
      email: json["email"],
      token: json["access_token"],
      isDoctor: json["is_doctor"] ?? false,
    );
  }

  Map toJson() {
    return {
      "name": this.name,
      "public_id": this.id,
      "email": this.email,
      "is_doctor": this.isDoctor,
      "access_token": this.token,
    };
  }
}

class UserModel {
  String? name;
  String? email;
  String? uid;
  String? password;

  UserModel({this.name, this.email, this.uid, this.password});

  Map<String, String?> tojson() {
    return {"name": name, "email": email};
  }
}

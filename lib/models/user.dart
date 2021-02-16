import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String username;
  String password;

  User({
    this.id,
    this.username,
    this.password,
  });

  User copyWith({
    String id,
    String username,
    String password,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "password": password,
  };
  @override
  String toString() {
    // TODO: implement toString
    return "Id:${id} \nUsername:${username} \nPassword:${password}";
  }
}


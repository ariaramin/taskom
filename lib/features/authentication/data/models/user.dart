import 'package:taskom/core/constants/constants.dart';

class User {
  final String? id;
  final String? avatar;
  final String? username;
  final String? name;
  final String? email;
  final bool? verified;
  String? token;

  User({
    this.id,
    this.avatar,
    this.username,
    this.name,
    this.email,
    this.verified,
    this.token,
  });

  factory User.fromMapJson(Map<String, dynamic> jsonObject) {
    return User(
      id: jsonObject['id'],
      avatar:
          '${Constants.BASE_URL}files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['avatar']}',
      username: jsonObject['username'],
      name: jsonObject['name'],
      email: jsonObject['email'],
      verified: jsonObject['verified'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'avatar': avatar,
        'username': username,
        'name': name,
        'email': email,
        'verified': verified,
        'token': token,
      };
}

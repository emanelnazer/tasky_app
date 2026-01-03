import 'package:tasky/feature/auth/domain/entities/auth_entity.dart';

class UserDto {
  static String collection = "users";
  UserDto({this.name, this.email, this.password, this.id});

  String? name;
  String? email;
  String? password;
  String? id;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        name: json['name'],
        email: json['email'],
        password: json['password'],
        id: json['id']);
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'id': id,
      };
  AuthEntity toEntity()=>AuthEntity(email: email, password: password, name: name);
}
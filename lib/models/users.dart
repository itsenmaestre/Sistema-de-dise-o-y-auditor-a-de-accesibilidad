import 'package:servicios_modelo_ui/models/hair.dart';

DateTime _parseBirthDate(String value) {
  final parts = value.trim().split('-');
  if (parts.length != 3) {
    throw FormatException('Fecha inválida: $value');
  }

  final year = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final day = int.parse(parts[2]);

  return DateTime(year, month, day);
}

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String maidenName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String username;
  final String password;
  final DateTime birthDate;
  final String image;
  final String bloodGroup;
  final double height;
  final double weight;
  final String eyeColor;
  final Hair hair;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.maidenName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.birthDate,
    required this.image,
    required this.bloodGroup,
    required this.height,
    required this.weight,
    required this.eyeColor,
    required this.hair,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      maidenName: json['maidenName'] as String,
      age: json['age'] as int,
      gender: json['gender'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      birthDate: _parseBirthDate(json['birthDate'] as String),
      image: json['image'] as String,
      bloodGroup: json['bloodGroup'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      eyeColor: json['eyeColor'] as String,
      hair: Hair.fromJson(json['hair'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'maidenName': maidenName,
      'age': age,
      'gender': gender,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'birthDate': "${birthDate.year}-${birthDate.month}-${birthDate.day}",
      'image': image,
      'bloodGroup': bloodGroup,
      'height': height,
      'weight': weight,
      'eyeColor': eyeColor,
      'hair': hair.toJson(),
    };
  }
}

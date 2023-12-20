import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  late final String? id;
  final String email;
  String password;
  String? username;

  User({
    String? id,
    required this.email,
    required this.password,
  }) {
    this.id = id ?? const Uuid().v4();
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

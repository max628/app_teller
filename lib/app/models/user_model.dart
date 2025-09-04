import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

// @Collection()
@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    this.name = "",
    this.email = "",
    this.password = "",
    this.role = "",
    this.createdAt = "",
    this.updatedAt = "",
  });

  final int id;

  // @Index(type: IndexType.value)
  final String name;
  final String email;
  final String password;
  final String role;
  final String createdAt;
  final String updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

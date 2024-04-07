import 'package:changepayer_app/app/models/venue_model.dart';
import 'package:json_annotation/json_annotation.dart';
// import 'package:isar/isar.dart';

part 'user_model.g.dart';

// @Collection()
@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    this.email = "",
    this.role,
    this.venue,
  });

  final String id;

  // @Index(type: IndexType.value)
  final String email;
  final int? role;
  final VenueModel? venue;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

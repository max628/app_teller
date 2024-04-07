import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VenueModel {
  VenueModel({
    required this.totalChangeTicketValue,
    required this.address,
    required this.phoneNumber,
    required this.contact,
    required this.confirmPassword,
    required this.password,
    required this.name,
    required this.logo,
    required this.user,
    required this.id,
  });

  final int totalChangeTicketValue;
  final String address;
  final String phoneNumber;
  final String contact;
  final String confirmPassword;
  final String password;
  final String name;
  final String logo;
  final String user;
  final String id;

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      totalChangeTicketValue: json['total_change_ticket_value'] as int,
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as String,
      contact: json['contact'] as String,
      confirmPassword: '',
      password: '',
      name: json['name'] as String,
      logo: json['logo'] as String,
      user: '',
      id: json['_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_change_ticket_value': totalChangeTicketValue,
      'address': address,
      'phone_number': phoneNumber,
      'contact': contact,
      'name': name,
      'logo': logo,
      '_id': id,
    };
  }
}

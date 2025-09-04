import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ShopModel {
  ShopModel({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.contact,
    required this.logo,
    required this.balance,
  });

  final int id;
  final String name;
  final String address;
  final String logo;
  final String contact;
  final String phoneNumber;
  final double balance;

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] as int,
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as String,
      contact: json['contact'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String,
      balance: json['balance'] != null ? double.parse(json['balance'].toString()) : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'address': address,
      'phone_number': phoneNumber,
      'contact': contact,
      'name': name,
      'logo': logo,
      'balance': balance,
    };
  }
}

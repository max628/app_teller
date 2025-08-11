import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ShopModel {
  ShopModel({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.contact,
    required this.balance,
    required this.logo,
    required this.id,
  });

  final String name;
  final String address;
  final String logo;
  final String contact;
  final String phoneNumber;
  final dynamic balance;
  final int id;

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      balance: json['balance'] as dynamic,
      address: json['address'] as String,
      phoneNumber: json['phone_number'] as String,
      contact: json['contact'] as String,
      name: json['name'] as String,
      logo: json['logo'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'address': address,
      'phone_number': phoneNumber,
      'contact': contact,
      'name': name,
      'logo': logo,
      'id': id,
    };
  }
}

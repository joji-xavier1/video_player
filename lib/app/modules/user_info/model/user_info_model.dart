// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  String? dob;
  String? imageUrl;
  String? name;
  String? email;

  UserInfoModel({
    this.dob,
    this.imageUrl,
    this.name,
    this.email,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        dob: json["dob"],
        imageUrl: json["imageUrl"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "dob": dob,
        "imageUrl": imageUrl,
        "name": name,
        "email": email,
      };
}

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.emailVerifiedAt,
    required this.alamat,
    required this.noHp,
    this.photoProfiles,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String username;
  String email;
  dynamic emailVerifiedAt;
  String alamat;
  String noHp;
  dynamic photoProfiles;
  DateTime createdAt;
  DateTime updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        photoProfiles: json["photo_profiles"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "alamat": alamat,
        "no_hp": noHp,
        "photo_profiles": photoProfiles,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class UserModel {
  int? id;
  int? companyId;
  String? name;
  String? nip;
  String? email;
  DateTime? emailVerifiedAt;
  String? avatar;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.companyId,
    this.name,
    this.nip,
    this.email,
    this.emailVerifiedAt,
    this.avatar,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        nip: json["nip"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        avatar: json["avatar"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "nip": nip,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "avatar": avatar,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

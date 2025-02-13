class PermitUser {
  int id;
  int companyId;
  String name;
  String nip;
  String email;
  DateTime emailVerifiedAt;
  String avatar;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  PermitUser({
    required this.id,
    required this.companyId,
    required this.name,
    required this.nip,
    required this.email,
    required this.emailVerifiedAt,
    required this.avatar,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PermitUser.fromJson(Map<String, dynamic> json) => PermitUser(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        nip: json["nip"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        avatar: json["avatar"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "nip": nip,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "avatar": avatar,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

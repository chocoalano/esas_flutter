class Approval {
  final int? id;
  final int? permitId;
  final int? userId;
  final String? userType;
  final String? userApprove;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Approval({
    this.id,
    this.permitId,
    this.userId,
    this.userType,
    this.userApprove,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Approval.fromJson(Map<String, dynamic> json) {
    return Approval(
      id: json["id"] as int?,
      permitId: json["permit_id"] as int?,
      userId: json["user_id"] as int?,
      userType: json["user_type"] as String?,
      userApprove: json["user_approve"] as String?,
      notes: json["notes"] as String?,
      createdAt: (json["created_at"] != null)
          ? DateTime.tryParse(json["created_at"])
          : null,
      updatedAt: (json["updated_at"] != null)
          ? DateTime.tryParse(json["updated_at"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "permit_id": permitId,
        "user_id": userId,
        "user_type": userType,
        "user_approve": userApprove,
        "notes": notes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

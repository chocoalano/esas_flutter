class Setting {
  int? id;
  int? companyId;
  bool attendanceImageGeolocation;
  bool attendanceQrcode;
  bool attendanceFingerprint;
  DateTime? createdAt;
  DateTime? updatedAt;

  Setting({
    this.id,
    this.companyId,
    required this.attendanceImageGeolocation,
    required this.attendanceQrcode,
    required this.attendanceFingerprint,
    this.createdAt,
    this.updatedAt,
  });

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        id: json["id"],
        companyId: json["company_id"],
        attendanceImageGeolocation: json["attendance_image_geolocation"],
        attendanceQrcode: json["attendance_qrcode"],
        attendanceFingerprint: json["attendance_fingerprint"],
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
        "attendance_image_geolocation": attendanceImageGeolocation,
        "attendance_qrcode": attendanceQrcode,
        "attendance_fingerprint": attendanceFingerprint,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

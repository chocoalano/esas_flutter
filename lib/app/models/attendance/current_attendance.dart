class CurrentAttendance {
  int? id;
  int? userId;
  dynamic userTimeworkScheduleId;
  String? timeIn;
  dynamic timeOut;
  String? latIn;
  dynamic latOut;
  String? longIn;
  dynamic longOut;
  String? imageIn;
  dynamic imageOut;
  String? statusIn;
  String? statusOut;
  DateTime? createdAt;
  DateTime? updatedAt;

  CurrentAttendance({
    this.id,
    this.userId,
    this.userTimeworkScheduleId,
    this.timeIn,
    this.timeOut,
    this.latIn,
    this.latOut,
    this.longIn,
    this.longOut,
    this.imageIn,
    this.imageOut,
    this.statusIn,
    this.statusOut,
    this.createdAt,
    this.updatedAt,
  });

  factory CurrentAttendance.fromJson(Map<String, dynamic> json) =>
      CurrentAttendance(
        id: json["id"],
        userId: json["user_id"],
        userTimeworkScheduleId: json["user_timework_schedule_id"],
        timeIn: json["time_in"],
        timeOut: json["time_out"],
        latIn: json["lat_in"],
        latOut: json["lat_out"],
        longIn: json["long_in"],
        longOut: json["long_out"],
        imageIn: json["image_in"],
        imageOut: json["image_out"],
        statusIn: json["status_in"],
        statusOut: json["status_out"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "user_timework_schedule_id": userTimeworkScheduleId,
        "time_in": timeIn,
        "time_out": timeOut,
        "lat_in": latIn,
        "lat_out": latOut,
        "long_in": longIn,
        "long_out": longOut,
        "image_in": imageIn,
        "image_out": imageOut,
        "status_in": statusIn,
        "status_out": statusOut,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

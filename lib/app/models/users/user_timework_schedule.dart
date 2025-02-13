class UserTimeworkSchedule {
  int? id;
  int? userId;
  int? timeWorkId;
  DateTime? workDay;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserTimeworkSchedule({
    this.id,
    this.userId,
    this.timeWorkId,
    this.workDay,
    this.createdAt,
    this.updatedAt,
  });

  factory UserTimeworkSchedule.fromJson(Map<String, dynamic> json) =>
      UserTimeworkSchedule(
        id: json["id"],
        userId: json["user_id"],
        timeWorkId: json["time_work_id"],
        workDay:
            json["work_day"] == null ? null : DateTime.parse(json["work_day"]),
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
        "time_work_id": timeWorkId,
        "work_day":
            "${workDay!.year.toString().padLeft(4, '0')}-${workDay!.month.toString().padLeft(2, '0')}-${workDay!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

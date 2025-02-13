class AttendanceAuth {
  int? id;
  int? userId;
  int? companyId;
  String? name;
  String? nip;
  String? avatar;
  int? departementId;
  int? jobPositionId;
  int? jobLevelId;
  int? approvalLineId;
  int? approvalManagerId;
  DateTime? joinDate;
  DateTime? signDate;
  String? departement;
  String? position;
  String? level;
  dynamic workDay;
  dynamic shiftname;
  dynamic attendanceAuthIn;
  dynamic out;
  dynamic userTimeworkScheduleId;
  String? timeIn;
  String? latIn;
  String? longIn;
  dynamic imageIn;
  String? statusIn;
  String? timeOut;
  String? latOut;
  String? longOut;
  dynamic imageOut;
  String? statusOut;
  DateTime? createdAt;
  DateTime? updatedAt;

  AttendanceAuth({
    this.id,
    this.userId,
    this.companyId,
    this.name,
    this.nip,
    this.avatar,
    this.departementId,
    this.jobPositionId,
    this.jobLevelId,
    this.approvalLineId,
    this.approvalManagerId,
    this.joinDate,
    this.signDate,
    this.departement,
    this.position,
    this.level,
    this.workDay,
    this.shiftname,
    this.attendanceAuthIn,
    this.out,
    this.userTimeworkScheduleId,
    this.timeIn,
    this.latIn,
    this.longIn,
    this.imageIn,
    this.statusIn,
    this.timeOut,
    this.latOut,
    this.longOut,
    this.imageOut,
    this.statusOut,
    this.createdAt,
    this.updatedAt,
  });

  factory AttendanceAuth.fromJson(Map<String, dynamic> json) => AttendanceAuth(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        name: json["name"],
        nip: json["nip"],
        avatar: json["avatar"],
        departementId: json["departement_id"],
        jobPositionId: json["job_position_id"],
        jobLevelId: json["job_level_id"],
        approvalLineId: json["approval_line_id"],
        approvalManagerId: json["approval_manager_id"],
        joinDate: json["join_date"] == null
            ? null
            : DateTime.parse(json["join_date"]),
        signDate: json["sign_date"] == null
            ? null
            : DateTime.parse(json["sign_date"]),
        departement: json["departement"],
        position: json["position"],
        level: json["level"],
        workDay: json["work_day"],
        shiftname: json["shiftname"],
        attendanceAuthIn: json["in"],
        out: json["out"],
        userTimeworkScheduleId: json["user_timework_schedule_id"],
        timeIn: json["time_in"],
        latIn: json["lat_in"],
        longIn: json["long_in"],
        imageIn: json["image_in"],
        statusIn: json["status_in"],
        timeOut: json["time_out"],
        latOut: json["lat_out"],
        longOut: json["long_out"],
        imageOut: json["image_out"],
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
        "company_id": companyId,
        "name": name,
        "nip": nip,
        "avatar": avatar,
        "departement_id": departementId,
        "job_position_id": jobPositionId,
        "job_level_id": jobLevelId,
        "approval_line_id": approvalLineId,
        "approval_manager_id": approvalManagerId,
        "join_date":
            "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "sign_date":
            "${signDate!.year.toString().padLeft(4, '0')}-${signDate!.month.toString().padLeft(2, '0')}-${signDate!.day.toString().padLeft(2, '0')}",
        "departement": departement,
        "position": position,
        "level": level,
        "work_day": workDay,
        "shiftname": shiftname,
        "in": attendanceAuthIn,
        "out": out,
        "user_timework_schedule_id": userTimeworkScheduleId,
        "time_in": timeIn,
        "lat_in": latIn,
        "long_in": longIn,
        "image_in": imageIn,
        "status_in": statusIn,
        "time_out": timeOut,
        "lat_out": latOut,
        "long_out": longOut,
        "image_out": imageOut,
        "status_out": statusOut,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

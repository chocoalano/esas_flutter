import '../users/user_timework_schedule.dart';
import 'approval.dart';
import 'permit_type.dart';
import 'permit_user.dart';

class PermitList {
  int id;
  String permitNumbers;
  int userId;
  int permitTypeId;
  int userTimeworkScheduleId;
  String? timeinAdjust;
  String? timeoutAdjust;
  int? currentShiftId;
  int? adjustShiftId;
  DateTime startDate;
  DateTime endDate;
  String startTime;
  String endTime;
  String? notes;
  String? file;
  DateTime createdAt;
  DateTime updatedAt;
  PermitUser user;
  PermitType permitType;
  List<Approval> approvals;
  UserTimeworkSchedule userTimeworkSchedule;

  PermitList({
    required this.id,
    required this.permitNumbers,
    required this.userId,
    required this.permitTypeId,
    required this.userTimeworkScheduleId,
    this.timeinAdjust,
    this.timeoutAdjust,
    this.currentShiftId,
    this.adjustShiftId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    this.notes,
    this.file,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.permitType,
    required this.approvals,
    required this.userTimeworkSchedule,
  });

  factory PermitList.fromJson(Map<String, dynamic> json) => PermitList(
        id: json["id"],
        permitNumbers: json["permit_numbers"],
        userId: json["user_id"],
        permitTypeId: json["permit_type_id"],
        userTimeworkScheduleId: json["user_timework_schedule_id"],
        timeinAdjust: json["timein_adjust"],
        timeoutAdjust: json["timeout_adjust"],
        currentShiftId: json["current_shift_id"],
        adjustShiftId: json["adjust_shift_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        notes: json["notes"],
        file: json["file"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: PermitUser.fromJson(json["user"]),
        permitType: PermitType.fromJson(json["permit_type"]),
        approvals: List<Approval>.from(
            json["approvals"].map((x) => Approval.fromJson(x))),
        userTimeworkSchedule:
            UserTimeworkSchedule.fromJson(json["user_timework_schedule"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "permit_numbers": permitNumbers,
        "user_id": userId,
        "permit_type_id": permitTypeId,
        "user_timework_schedule_id": userTimeworkScheduleId,
        "timein_adjust": timeinAdjust,
        "timeout_adjust": timeoutAdjust,
        "current_shift_id": currentShiftId,
        "adjust_shift_id": adjustShiftId,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "notes": notes,
        "file": file,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "permit_type": permitType.toJson(),
        "approvals": List<dynamic>.from(approvals.map((x) => x.toJson())),
        "user_timework_schedule": userTimeworkSchedule.toJson(),
      };
}

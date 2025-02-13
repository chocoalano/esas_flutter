import '../users/user_model.dart';
import '../users/user_timework_schedule.dart';
import 'approval.dart';
import 'permit_type.dart';

class PermitDetail {
  int? id;
  String? permitNumbers;
  int? userId;
  int? permitTypeId;
  int? userTimeworkScheduleId;
  dynamic timeinAdjust;
  dynamic timeoutAdjust;
  dynamic currentShiftId;
  dynamic adjustShiftId;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? endTime;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserModel? user;
  PermitType? permitType;
  List<Approval>? approvals;
  UserTimeworkSchedule? userTimeworkSchedule;

  PermitDetail({
    this.id,
    this.permitNumbers,
    this.userId,
    this.permitTypeId,
    this.userTimeworkScheduleId,
    this.timeinAdjust,
    this.timeoutAdjust,
    this.currentShiftId,
    this.adjustShiftId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.permitType,
    this.approvals,
    this.userTimeworkSchedule,
  });

  factory PermitDetail.fromJson(Map<String, dynamic> json) => PermitDetail(
        id: json["id"],
        permitNumbers: json["permit_numbers"],
        userId: json["user_id"],
        permitTypeId: json["permit_type_id"],
        userTimeworkScheduleId: json["user_timework_schedule_id"],
        timeinAdjust: json["timein_adjust"],
        timeoutAdjust: json["timeout_adjust"],
        currentShiftId: json["current_shift_id"],
        adjustShiftId: json["adjust_shift_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        startTime: json["start_time"],
        endTime: json["end_time"],
        notes: json["notes"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
        permitType: json["permit_type"] == null
            ? null
            : PermitType.fromJson(json["permit_type"]),
        approvals: json["approvals"] == null
            ? []
            : List<Approval>.from(
                json["approvals"]!.map((x) => Approval.fromJson(x))),
        userTimeworkSchedule: json["user_timework_schedule"] == null
            ? null
            : UserTimeworkSchedule.fromJson(json["user_timework_schedule"]),
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
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "start_time": startTime,
        "end_time": endTime,
        "notes": notes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
        "permit_type": permitType?.toJson(),
        "approvals": approvals == null
            ? []
            : List<dynamic>.from(approvals!.map((x) => x.toJson())),
        "user_timework_schedule": userTimeworkSchedule?.toJson(),
      };
}

import './timework.dart';

class WorkSchedule {
  final int? id;
  final int? userId;
  final int? timeWorkId;
  final String? workDay;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TimeWork? timeWork;

  WorkSchedule({
    this.id = 0,
    this.userId = 0,
    this.timeWorkId = 0,
    this.workDay = '',
    DateTime? createdAt,
    DateTime? updatedAt,
    TimeWork? timeWork,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now(),
        timeWork = timeWork ?? TimeWork();

  factory WorkSchedule.fromJson(Map<String, dynamic> json) {
    return WorkSchedule(
      id: json['id'],
      userId: json['user_id'],
      timeWorkId: json['time_work_id'],
      workDay: json['work_day'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      timeWork: TimeWork.fromJson(json['timework']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'time_work_id': timeWorkId,
      'work_day': workDay,
      'created_at': createdAt!.toIso8601String(),
      'updated_at': updatedAt!.toIso8601String(),
      'timework': timeWork!.toJson(),
    };
  }
}

class Employee {
  int? id;
  int? userId;
  int? departementId;
  int? jobPositionId;
  int? jobLevelId;
  int? approvalLineId;
  int? approvalManagerId;
  DateTime? joinDate;
  DateTime? signDate;
  dynamic resignDate;
  String? bankName;
  String? bankNumber;
  String? bankHolder;
  dynamic saldoCuti;

  Employee({
    this.id,
    this.userId,
    this.departementId,
    this.jobPositionId,
    this.jobLevelId,
    this.approvalLineId,
    this.approvalManagerId,
    this.joinDate,
    this.signDate,
    this.resignDate,
    this.bankName,
    this.bankNumber,
    this.bankHolder,
    this.saldoCuti,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json["id"],
        userId: json["user_id"],
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
        resignDate: json["resign_date"],
        bankName: json["bank_name"],
        bankNumber: json["bank_number"],
        bankHolder: json["bank_holder"],
        saldoCuti: json["saldo_cuti"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "departement_id": departementId,
        "job_position_id": jobPositionId,
        "job_level_id": jobLevelId,
        "approval_line_id": approvalLineId,
        "approval_manager_id": approvalManagerId,
        "join_date":
            "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "sign_date":
            "${signDate!.year.toString().padLeft(4, '0')}-${signDate!.month.toString().padLeft(2, '0')}-${signDate!.day.toString().padLeft(2, '0')}",
        "resign_date": resignDate,
        "bank_name": bankName,
        "bank_number": bankNumber,
        "bank_holder": bankHolder,
        "saldo_cuti": saldoCuti,
      };
}

class PermitType {
  int id;
  String type;
  bool isPayed;
  bool approveLine;
  bool approveManager;
  bool approveHr;
  bool withFile;
  bool showMobile;

  PermitType({
    required this.id,
    required this.type,
    required this.isPayed,
    required this.approveLine,
    required this.approveManager,
    required this.approveHr,
    required this.withFile,
    required this.showMobile,
  });

  factory PermitType.fromJson(Map<String, dynamic> json) => PermitType(
        id: json["id"],
        type: json["type"],
        isPayed: json["is_payed"],
        approveLine: json["approve_line"],
        approveManager: json["approve_manager"],
        approveHr: json["approve_hr"],
        withFile: json["with_file"],
        showMobile: json["show_mobile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "is_payed": isPayed,
        "approve_line": approveLine,
        "approve_manager": approveManager,
        "approve_hr": approveHr,
        "with_file": withFile,
        "show_mobile": showMobile,
      };
}

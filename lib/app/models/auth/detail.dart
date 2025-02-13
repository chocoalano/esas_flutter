class Details {
  int? id;
  int? userId;
  String? phone;
  String? placebirth;
  DateTime? datebirth;
  String? gender;
  String? blood;
  String? maritalStatus;
  String? religion;

  Details({
    this.id,
    this.userId,
    this.phone,
    this.placebirth,
    this.datebirth,
    this.gender,
    this.blood,
    this.maritalStatus,
    this.religion,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        userId: json["user_id"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"] == null
            ? null
            : DateTime.parse(json["datebirth"]),
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["marital_status"],
        religion: json["religion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth":
            "${datebirth!.year.toString().padLeft(4, '0')}-${datebirth!.month.toString().padLeft(2, '0')}-${datebirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "blood": blood,
        "marital_status": maritalStatus,
        "religion": religion,
      };
}

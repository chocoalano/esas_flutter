class WorkExperience {
  int? id;
  int? userId;
  String? companyName;
  String? position;
  String? start;
  String? finish;
  bool? certification;

  WorkExperience({
    this.id,
    this.userId,
    this.companyName,
    this.position,
    this.start,
    this.finish,
    this.certification,
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json) => WorkExperience(
        id: json["id"],
        userId: json["user_id"],
        companyName: json["company_name"],
        position: json["position"],
        start: json["start"],
        finish: json["finish"],
        certification: json["certification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_name": companyName,
        "position": position,
        "start": start,
        "finish": finish,
        "certification": certification,
      };
}

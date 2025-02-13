class InformalEducation {
  int? id;
  int? userId;
  String? institution;
  String? start;
  String? finish;
  String? type;
  int? duration;
  String? status;
  bool? certification;

  InformalEducation({
    this.id,
    this.userId,
    this.institution,
    this.start,
    this.finish,
    this.type,
    this.duration,
    this.status,
    this.certification,
  });

  factory InformalEducation.fromJson(Map<String, dynamic> json) =>
      InformalEducation(
        id: json["id"],
        userId: json["user_id"],
        institution: json["institution"],
        start: json["start"],
        finish: json["finish"],
        type: json["type"],
        duration: json["duration"],
        status: json["status"],
        certification: json["certification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "institution": institution,
        "start": start,
        "finish": finish,
        "type": type,
        "duration": duration,
        "status": status,
        "certification": certification,
      };
}

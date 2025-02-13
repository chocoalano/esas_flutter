class FormalEducation {
  int? id;
  int? userId;
  String? institution;
  String? majors;
  String? score;
  String? start;
  String? finish;
  String? status;
  bool? certification;

  FormalEducation({
    this.id,
    this.userId,
    this.institution,
    this.majors,
    this.score,
    this.start,
    this.finish,
    this.status,
    this.certification,
  });

  factory FormalEducation.fromJson(Map<String, dynamic> json) =>
      FormalEducation(
        id: json["id"],
        userId: json["user_id"],
        institution: json["institution"],
        majors: json["majors"],
        score: json["score"],
        start: json["start"],
        finish: json["finish"],
        status: json["status"],
        certification: json["certification"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "institution": institution,
        "majors": majors,
        "score": score,
        "start": start,
        "finish": finish,
        "status": status,
        "certification": certification,
      };
}

class BugReports {
  int? id;
  int? companyId;
  int? userId;
  String? title;
  bool? status;
  String? message;
  String? platform;
  String? image;

  BugReports({
    this.id,
    this.companyId,
    this.userId,
    this.title,
    this.status,
    this.message,
    this.platform,
    this.image,
  });

  factory BugReports.fromJson(Map<String, dynamic> json) => BugReports(
        id: json["id"],
        companyId: json["company_id"],
        userId: json["user_id"],
        title: json["title"],
        status: json["status"],
        message: json["message"],
        platform: json["platform"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "user_id": userId,
        "title": title,
        "status": status,
        "message": message,
        "platform": platform,
        "image": image,
      };
}

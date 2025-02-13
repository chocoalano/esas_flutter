class Salaries {
  int? id;
  int? userId;
  String? basicSalary;
  String? paymentType;

  Salaries({
    this.id,
    this.userId,
    this.basicSalary,
    this.paymentType,
  });

  factory Salaries.fromJson(Map<String, dynamic> json) => Salaries(
        id: json["id"],
        userId: json["user_id"],
        basicSalary: json["basic_salary"],
        paymentType: json["payment_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "basic_salary": basicSalary,
        "payment_type": paymentType,
      };
}

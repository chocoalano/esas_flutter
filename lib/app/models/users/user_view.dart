class UserView {
  int? companyId;
  String? name;
  String? nip;
  String? email;
  DateTime? emailVerifiedAt;
  String? password;
  String? avatar;
  String? status;
  dynamic rememberToken;
  String? company;
  double? companyLat;
  double? companyLong;
  int? companyRadius;
  String? companyAddress;
  String? basicSalary;
  String? paymentType;
  String? bankName;
  String? bankNumber;
  String? bankHolder;
  String? phone;
  String? placebirth;
  DateTime? datebirth;
  String? gender;
  String? blood;
  String? maritalStatus;
  String? religion;
  String? identityType;
  String? identityNumbers;
  String? province;
  String? city;
  String? citizenAddress;
  String? residentialAddress;
  int? departementId;
  int? jobPositionId;
  int? jobLevelId;
  int? approvalLineId;
  int? approvalManagerId;
  DateTime? joinDate;
  DateTime? signDate;
  dynamic resignDate;
  String? departement;
  String? position;

  UserView({
    this.companyId,
    this.name,
    this.nip,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.avatar,
    this.status,
    this.rememberToken,
    this.company,
    this.companyLat,
    this.companyLong,
    this.companyRadius,
    this.companyAddress,
    this.basicSalary,
    this.paymentType,
    this.bankName,
    this.bankNumber,
    this.bankHolder,
    this.phone,
    this.placebirth,
    this.datebirth,
    this.gender,
    this.blood,
    this.maritalStatus,
    this.religion,
    this.identityType,
    this.identityNumbers,
    this.province,
    this.city,
    this.citizenAddress,
    this.residentialAddress,
    this.departementId,
    this.jobPositionId,
    this.jobLevelId,
    this.approvalLineId,
    this.approvalManagerId,
    this.joinDate,
    this.signDate,
    this.resignDate,
    this.departement,
    this.position,
  });

  factory UserView.fromJson(Map<String, dynamic> json) => UserView(
        companyId: json["company_id"],
        name: json["name"],
        nip: json["nip"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        password: json["password"],
        avatar: json["avatar"],
        status: json["status"],
        rememberToken: json["remember_token"],
        company: json["company"],
        companyLat: json["company_lat"]?.toDouble(),
        companyLong: json["company_long"]?.toDouble(),
        companyRadius: json["company_radius"],
        companyAddress: json["company_address"],
        basicSalary: json["basic_salary"],
        paymentType: json["payment_type"],
        bankName: json["bank_name"],
        bankNumber: json["bank_number"],
        bankHolder: json["bank_holder"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"] == null
            ? null
            : DateTime.parse(json["datebirth"]),
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["marital_status"],
        religion: json["religion"],
        identityType: json["identity_type"],
        identityNumbers: json["identity_numbers"],
        province: json["province"],
        city: json["city"],
        citizenAddress: json["citizen_address"],
        residentialAddress: json["residential_address"],
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
        departement: json["departement"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "name": name,
        "nip": nip,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "password": password,
        "avatar": avatar,
        "status": status,
        "remember_token": rememberToken,
        "company": company,
        "company_lat": companyLat,
        "company_long": companyLong,
        "company_radius": companyRadius,
        "company_address": companyAddress,
        "basic_salary": basicSalary,
        "payment_type": paymentType,
        "bank_name": bankName,
        "bank_number": bankNumber,
        "bank_holder": bankHolder,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth": datebirth?.toIso8601String(),
        "gender": gender,
        "blood": blood,
        "marital_status": maritalStatus,
        "religion": religion,
        "identity_type": identityType,
        "identity_numbers": identityNumbers,
        "province": province,
        "city": city,
        "citizen_address": citizenAddress,
        "residential_address": residentialAddress,
        "departement_id": departementId,
        "job_position_id": jobPositionId,
        "job_level_id": jobLevelId,
        "approval_line_id": approvalLineId,
        "approval_manager_id": approvalManagerId,
        "join_date": joinDate?.toIso8601String(),
        "sign_date": signDate?.toIso8601String(),
        "resign_date": resignDate,
        "departement": departement,
        "position": position,
      };
}

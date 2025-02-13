import 'address.dart';
import 'detail.dart';
import 'employe.dart';
import 'salaries.dart';

class UserDetail {
  int? id;
  int? companyId;
  String? name;
  String? nip;
  String? email;
  DateTime? emailVerifiedAt;
  String? avatar;
  String? status;
  String? deviceId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Details? details;
  Address? address;
  Salaries? salaries;
  List<dynamic>? families;
  List<dynamic>? formalEducations;
  List<dynamic>? informalEducations;
  List<dynamic>? workExperiences;
  Employee? employee;

  UserDetail({
    this.id,
    this.companyId,
    this.name,
    this.nip,
    this.email,
    this.emailVerifiedAt,
    this.avatar,
    this.status,
    this.deviceId,
    this.createdAt,
    this.updatedAt,
    this.details,
    this.address,
    this.salaries,
    this.families,
    this.formalEducations,
    this.informalEducations,
    this.workExperiences,
    this.employee,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        nip: json["nip"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        avatar: json["avatar"],
        status: json["status"],
        deviceId: json["device_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        salaries: json["salaries"] == null
            ? null
            : Salaries.fromJson(json["salaries"]),
        families: json["families"] == null
            ? []
            : List<dynamic>.from(json["families"]!.map((x) => x)),
        formalEducations: json["formal_educations"] == null
            ? []
            : List<dynamic>.from(json["formal_educations"]!.map((x) => x)),
        informalEducations: json["informal_educations"] == null
            ? []
            : List<dynamic>.from(json["informal_educations"]!.map((x) => x)),
        workExperiences: json["work_experiences"] == null
            ? []
            : List<dynamic>.from(json["work_experiences"]!.map((x) => x)),
        employee: json["employee"] == null
            ? null
            : Employee.fromJson(json["employee"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "nip": nip,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "avatar": avatar,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "details": details?.toJson(),
        "address": address?.toJson(),
        "salaries": salaries?.toJson(),
        "families":
            families == null ? [] : List<dynamic>.from(families!.map((x) => x)),
        "formal_educations": formalEducations == null
            ? []
            : List<dynamic>.from(formalEducations!.map((x) => x)),
        "informal_educations": informalEducations == null
            ? []
            : List<dynamic>.from(informalEducations!.map((x) => x)),
        "work_experiences": workExperiences == null
            ? []
            : List<dynamic>.from(workExperiences!.map((x) => x)),
        "employee": employee?.toJson(),
      };
}

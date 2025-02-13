// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  Account? account;
  List<String>? role;
  List<String>? permission;

  AccountModel({
    this.account,
    this.role,
    this.permission,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        account:
            json["account"] == null ? null : Account.fromJson(json["account"]),
        role: json["role"] == null
            ? []
            : List<String>.from(json["role"]!.map((x) => x)),
        permission: json["permission"] == null
            ? []
            : List<String>.from(json["permission"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "account": account?.toJson(),
        "role": role == null ? [] : List<dynamic>.from(role!.map((x) => x)),
        "permission": permission == null
            ? []
            : List<dynamic>.from(permission!.map((x) => x)),
      };
}

class Account {
  int? id;
  String? name;
  String? nik;
  String? email;
  String? phone;
  String? placebirth;
  DateTime? datebirth;
  String? gender;
  String? blood;
  String? maritalStatus;
  String? religion;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Address? address;
  Bank? bank;
  Bpjs? bpjs;
  List<dynamic>? emergencyContact;
  List<dynamic>? formalEducation;
  List<dynamic>? family;
  List<dynamic>? workExperience;
  Salary? salary;
  List<dynamic>? informalEducation;
  List<dynamic>? groupUsers;
  TaxConfig? taxConfig;
  Employe? employe;

  Account({
    this.id,
    this.name,
    this.nik,
    this.email,
    this.phone,
    this.placebirth,
    this.datebirth,
    this.gender,
    this.blood,
    this.maritalStatus,
    this.religion,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.address,
    this.bank,
    this.bpjs,
    this.emergencyContact,
    this.formalEducation,
    this.family,
    this.workExperience,
    this.salary,
    this.informalEducation,
    this.groupUsers,
    this.taxConfig,
    this.employe,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"] == null
            ? null
            : DateTime.parse(json["datebirth"]),
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        bank: json["bank"] == null ? null : Bank.fromJson(json["bank"]),
        bpjs: json["bpjs"] == null ? null : Bpjs.fromJson(json["bpjs"]),
        emergencyContact: json["emergencyContact"] == null
            ? []
            : List<dynamic>.from(json["emergencyContact"]!.map((x) => x)),
        formalEducation: json["formalEducation"] == null
            ? []
            : List<dynamic>.from(json["formalEducation"]!.map((x) => x)),
        family: json["family"] == null
            ? []
            : List<dynamic>.from(json["family"]!.map((x) => x)),
        workExperience: json["workExperience"] == null
            ? []
            : List<dynamic>.from(json["workExperience"]!.map((x) => x)),
        salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
        informalEducation: json["informalEducation"] == null
            ? []
            : List<dynamic>.from(json["informalEducation"]!.map((x) => x)),
        groupUsers: json["group_users"] == null
            ? []
            : List<dynamic>.from(json["group_users"]!.map((x) => x)),
        taxConfig: json["taxConfig"] == null
            ? null
            : TaxConfig.fromJson(json["taxConfig"]),
        employe:
            json["employe"] == null ? null : Employe.fromJson(json["employe"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth":
            "${datebirth!.year.toString().padLeft(4, '0')}-${datebirth!.month.toString().padLeft(2, '0')}-${datebirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
        "address": address?.toJson(),
        "bank": bank?.toJson(),
        "bpjs": bpjs?.toJson(),
        "emergencyContact": emergencyContact == null
            ? []
            : List<dynamic>.from(emergencyContact!.map((x) => x)),
        "formalEducation": formalEducation == null
            ? []
            : List<dynamic>.from(formalEducation!.map((x) => x)),
        "family":
            family == null ? [] : List<dynamic>.from(family!.map((x) => x)),
        "workExperience": workExperience == null
            ? []
            : List<dynamic>.from(workExperience!.map((x) => x)),
        "salary": salary?.toJson(),
        "informalEducation": informalEducation == null
            ? []
            : List<dynamic>.from(informalEducation!.map((x) => x)),
        "group_users": groupUsers == null
            ? []
            : List<dynamic>.from(groupUsers!.map((x) => x)),
        "taxConfig": taxConfig?.toJson(),
        "employe": employe?.toJson(),
      };
}

class Address {
  int? id;
  int? userId;
  String? idtype;
  dynamic idnumber;
  dynamic idexpired;
  dynamic ispermanent;
  dynamic postalcode;
  dynamic citizenIdAddress;
  dynamic useAsResidential;
  dynamic residentialAddress;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.userId,
    this.idtype,
    this.idnumber,
    this.idexpired,
    this.ispermanent,
    this.postalcode,
    this.citizenIdAddress,
    this.useAsResidential,
    this.residentialAddress,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["userId"],
        idtype: json["idtype"],
        idnumber: json["idnumber"],
        idexpired: json["idexpired"],
        ispermanent: json["ispermanent"],
        postalcode: json["postalcode"],
        citizenIdAddress: json["citizenIdAddress"],
        useAsResidential: json["useAsResidential"],
        residentialAddress: json["residentialAddress"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "idtype": idtype,
        "idnumber": idnumber,
        "idexpired": idexpired,
        "ispermanent": ispermanent,
        "postalcode": postalcode,
        "citizenIdAddress": citizenIdAddress,
        "useAsResidential": useAsResidential,
        "residentialAddress": residentialAddress,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Bank {
  int? id;
  int? userId;
  dynamic bankName;
  dynamic bankAccount;
  dynamic bankAccountHolder;
  DateTime? createdAt;
  DateTime? updatedAt;

  Bank({
    this.id,
    this.userId,
    this.bankName,
    this.bankAccount,
    this.bankAccountHolder,
    this.createdAt,
    this.updatedAt,
  });

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        id: json["id"],
        userId: json["userId"],
        bankName: json["bankName"],
        bankAccount: json["bankAccount"],
        bankAccountHolder: json["bankAccountHolder"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bankName": bankName,
        "bankAccount": bankAccount,
        "bankAccountHolder": bankAccountHolder,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Bpjs {
  int? id;
  int? userId;
  dynamic bpjsKetenagakerjaan;
  dynamic nppBpjsKetenagakerjaan;
  dynamic bpjsKetenagakerjaanDate;
  dynamic bpjsKesehatan;
  dynamic bpjsKesehatanFamily;
  dynamic bpjsKesehatanDate;
  int? bpjsKesehatanCost;
  dynamic jhtCost;
  dynamic jaminanPensiunCost;
  dynamic jaminanPensiunDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Bpjs({
    this.id,
    this.userId,
    this.bpjsKetenagakerjaan,
    this.nppBpjsKetenagakerjaan,
    this.bpjsKetenagakerjaanDate,
    this.bpjsKesehatan,
    this.bpjsKesehatanFamily,
    this.bpjsKesehatanDate,
    this.bpjsKesehatanCost,
    this.jhtCost,
    this.jaminanPensiunCost,
    this.jaminanPensiunDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Bpjs.fromJson(Map<String, dynamic> json) => Bpjs(
        id: json["id"],
        userId: json["userId"],
        bpjsKetenagakerjaan: json["bpjsKetenagakerjaan"],
        nppBpjsKetenagakerjaan: json["nppBpjsKetenagakerjaan"],
        bpjsKetenagakerjaanDate: json["bpjsKetenagakerjaanDate"],
        bpjsKesehatan: json["bpjsKesehatan"],
        bpjsKesehatanFamily: json["bpjsKesehatanFamily"],
        bpjsKesehatanDate: json["bpjsKesehatanDate"],
        bpjsKesehatanCost: json["bpjsKesehatanCost"],
        jhtCost: json["jhtCost"],
        jaminanPensiunCost: json["jaminanPensiunCost"],
        jaminanPensiunDate: json["jaminanPensiunDate"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "bpjsKetenagakerjaan": bpjsKetenagakerjaan,
        "nppBpjsKetenagakerjaan": nppBpjsKetenagakerjaan,
        "bpjsKetenagakerjaanDate": bpjsKetenagakerjaanDate,
        "bpjsKesehatan": bpjsKesehatan,
        "bpjsKesehatanFamily": bpjsKesehatanFamily,
        "bpjsKesehatanDate": bpjsKesehatanDate,
        "bpjsKesehatanCost": bpjsKesehatanCost,
        "jhtCost": jhtCost,
        "jaminanPensiunCost": jaminanPensiunCost,
        "jaminanPensiunDate": jaminanPensiunDate,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Employe {
  int? id;
  int? userId;
  int? organizationId;
  int? jobPositionId;
  int? jobLevelId;
  int? approvalLine;
  int? approvalManager;
  int? companyId;
  int? branchId;
  String? status;
  DateTime? joinDate;
  DateTime? signDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  Job? job;
  App? appline;
  App? appmngr;
  Branch? branch;
  Job? org;
  Branch? company;
  Job? lvl;

  Employe({
    this.id,
    this.userId,
    this.organizationId,
    this.jobPositionId,
    this.jobLevelId,
    this.approvalLine,
    this.approvalManager,
    this.companyId,
    this.branchId,
    this.status,
    this.joinDate,
    this.signDate,
    this.createdAt,
    this.updatedAt,
    this.job,
    this.appline,
    this.appmngr,
    this.branch,
    this.org,
    this.company,
    this.lvl,
  });

  factory Employe.fromJson(Map<String, dynamic> json) => Employe(
        id: json["id"],
        userId: json["userId"],
        organizationId: json["organizationId"],
        jobPositionId: json["jobPositionId"],
        jobLevelId: json["jobLevelId"],
        approvalLine: json["approvalLine"],
        approvalManager: json["approvalManager"],
        companyId: json["companyId"],
        branchId: json["branchId"],
        status: json["status"],
        joinDate:
            json["joinDate"] == null ? null : DateTime.parse(json["joinDate"]),
        signDate:
            json["signDate"] == null ? null : DateTime.parse(json["signDate"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        appline: json["appline"] == null ? null : App.fromJson(json["appline"]),
        appmngr: json["appmngr"] == null ? null : App.fromJson(json["appmngr"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        org: json["org"] == null ? null : Job.fromJson(json["org"]),
        company:
            json["company"] == null ? null : Branch.fromJson(json["company"]),
        lvl: json["lvl"] == null ? null : Job.fromJson(json["lvl"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "organizationId": organizationId,
        "jobPositionId": jobPositionId,
        "jobLevelId": jobLevelId,
        "approvalLine": approvalLine,
        "approvalManager": approvalManager,
        "companyId": companyId,
        "branchId": branchId,
        "status": status,
        "joinDate":
            "${joinDate!.year.toString().padLeft(4, '0')}-${joinDate!.month.toString().padLeft(2, '0')}-${joinDate!.day.toString().padLeft(2, '0')}",
        "signDate":
            "${signDate!.year.toString().padLeft(4, '0')}-${signDate!.month.toString().padLeft(2, '0')}-${signDate!.day.toString().padLeft(2, '0')}",
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "job": job?.toJson(),
        "appline": appline?.toJson(),
        "appmngr": appmngr?.toJson(),
        "branch": branch?.toJson(),
        "org": org?.toJson(),
        "company": company?.toJson(),
        "lvl": lvl?.toJson(),
      };
}

class App {
  int? id;
  String? name;
  dynamic nik;
  String? email;
  dynamic phone;
  dynamic placebirth;
  dynamic datebirth;
  dynamic gender;
  dynamic blood;
  dynamic maritalStatus;
  dynamic religion;
  dynamic image;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  App({
    this.id,
    this.name,
    this.nik,
    this.email,
    this.phone,
    this.placebirth,
    this.datebirth,
    this.gender,
    this.blood,
    this.maritalStatus,
    this.religion,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory App.fromJson(Map<String, dynamic> json) => App(
        id: json["id"],
        name: json["name"],
        nik: json["nik"],
        email: json["email"],
        phone: json["phone"],
        placebirth: json["placebirth"],
        datebirth: json["datebirth"],
        gender: json["gender"],
        blood: json["blood"],
        maritalStatus: json["maritalStatus"],
        religion: json["religion"],
        image: json["image"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "nik": nik,
        "email": email,
        "phone": phone,
        "placebirth": placebirth,
        "datebirth": datebirth,
        "gender": gender,
        "blood": blood,
        "maritalStatus": maritalStatus,
        "religion": religion,
        "image": image,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Branch {
  int? id;
  String? name;
  String? latitude;
  String? longitude;
  String? fullAddress;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Branch({
    this.id,
    this.name,
    this.latitude,
    this.longitude,
    this.fullAddress,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        name: json["name"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        fullAddress: json["fullAddress"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "latitude": latitude,
        "longitude": longitude,
        "fullAddress": fullAddress,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Job {
  int? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  Job({
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "deletedAt": deletedAt,
      };
}

class Salary {
  int? id;
  int? userId;
  dynamic basicSalary;
  dynamic salaryType;
  dynamic paymentSchedule;
  dynamic prorateSettings;
  dynamic overtimeSettings;
  dynamic costCenter;
  dynamic costCenterCategory;
  dynamic currency;
  DateTime? createdAt;
  DateTime? updatedAt;

  Salary({
    this.id,
    this.userId,
    this.basicSalary,
    this.salaryType,
    this.paymentSchedule,
    this.prorateSettings,
    this.overtimeSettings,
    this.costCenter,
    this.costCenterCategory,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
        id: json["id"],
        userId: json["userId"],
        basicSalary: json["basicSalary"],
        salaryType: json["salaryType"],
        paymentSchedule: json["paymentSchedule"],
        prorateSettings: json["prorateSettings"],
        overtimeSettings: json["overtimeSettings"],
        costCenter: json["costCenter"],
        costCenterCategory: json["costCenterCategory"],
        currency: json["currency"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "basicSalary": basicSalary,
        "salaryType": salaryType,
        "paymentSchedule": paymentSchedule,
        "prorateSettings": prorateSettings,
        "overtimeSettings": overtimeSettings,
        "costCenter": costCenter,
        "costCenterCategory": costCenterCategory,
        "currency": currency,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class TaxConfig {
  int? id;
  int? userId;
  dynamic npwp15DigitOld;
  dynamic npwp16DigitNew;
  dynamic ptkpStatus;
  dynamic taxMethod;
  dynamic taxSalary;
  dynamic empTaxStatus;
  dynamic beginningNetto;
  DateTime? createdAt;
  DateTime? updatedAt;

  TaxConfig({
    this.id,
    this.userId,
    this.npwp15DigitOld,
    this.npwp16DigitNew,
    this.ptkpStatus,
    this.taxMethod,
    this.taxSalary,
    this.empTaxStatus,
    this.beginningNetto,
    this.createdAt,
    this.updatedAt,
  });

  factory TaxConfig.fromJson(Map<String, dynamic> json) => TaxConfig(
        id: json["id"],
        userId: json["userId"],
        npwp15DigitOld: json["npwp15DigitOld"],
        npwp16DigitNew: json["npwp16DigitNew"],
        ptkpStatus: json["ptkpStatus"],
        taxMethod: json["taxMethod"],
        taxSalary: json["taxSalary"],
        empTaxStatus: json["empTaxStatus"],
        beginningNetto: json["beginningNetto"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "npwp15DigitOld": npwp15DigitOld,
        "npwp16DigitNew": npwp16DigitNew,
        "ptkpStatus": ptkpStatus,
        "taxMethod": taxMethod,
        "taxSalary": taxSalary,
        "empTaxStatus": empTaxStatus,
        "beginningNetto": beginningNetto,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

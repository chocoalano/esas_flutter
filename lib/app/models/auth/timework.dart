class TimeWork {
  final int id;
  final int companyId;
  final int departemenId;
  final String name;
  final String inTime;
  final String outTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  TimeWork({
    this.id = 0,
    this.companyId = 0,
    this.departemenId = 0,
    this.name = '',
    this.inTime = '',
    this.outTime = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  factory TimeWork.fromJson(Map<String, dynamic> json) {
    return TimeWork(
      id: json['id'],
      companyId: json['company_id'],
      departemenId: json['departemen_id'],
      name: json['name'],
      inTime: json['in'],
      outTime: json['out'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'departemen_id': departemenId,
      'name': name,
      'in': inTime,
      'out': outTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

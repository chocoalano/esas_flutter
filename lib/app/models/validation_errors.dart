class ValidationErrors {
  final Map<String, List<String>> errors;

  ValidationErrors({required this.errors});

  factory ValidationErrors.fromJson(Map<String, dynamic> json) {
    final errors = json['errors'] as Map<String, dynamic>;
    return ValidationErrors(
      errors:
          errors.map((key, value) => MapEntry(key, List<String>.from(value))),
    );
  }

  String? getError(String key) {
    if (errors.containsKey(key) && errors[key]!.isNotEmpty) {
      return errors[key]![0]; // Ambil pesan error pertama untuk key tertentu
    }
    return null;
  }
}

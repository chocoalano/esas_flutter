import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DropdownFieldComponent extends StatelessWidget {
  final String label;
  final List<DropdownMenuItem<int>> items;
  final Function(int?) onChanged;
  final int value;
  final Color primaryColor;

  const DropdownFieldComponent({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.value,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDropdown<int>(
      name: label,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor.withOpacity(0.1),
        filled: true,
      ),
      items: items,
      validator:
          FormBuilderValidators.required(errorText: '$label harus dipilih'),
      valueTransformer: (value) => value ?? 0,
      onChanged: onChanged,
      initialValue: value, // Set initial value
    );
  }
}

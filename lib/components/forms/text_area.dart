import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../constant.dart';

class TextAreaComponent extends StatelessWidget {
  final TextEditingController controller;
  final RxString notes;
  final String labelText;
  final String name;
  final void Function(String?)? onChanged;

  const TextAreaComponent({
    super.key,
    required this.controller,
    required this.notes,
    required this.labelText,
    required this.name,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: 'notes',
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor.withOpacity(0.1),
        filled: true,
        labelText: labelText,
      ),
      maxLines: 3,
      validator:
          FormBuilderValidators.required(errorText: '$labelText harus diisi'),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
        notes.value = value ?? '';
      },
    );
  }
}

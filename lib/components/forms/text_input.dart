import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constant.dart';

class TextFieldComponent extends StatelessWidget {
  final String name;
  final String label;
  final IconData icon;
  final Function(String?)? onChanged;

  const TextFieldComponent({
    super.key,
    required this.name,
    required this.label,
    required this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor
            .withOpacity(0.1), // Anda dapat mengganti warna sesuai kebutuhan
        filled: true,
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      onChanged: onChanged,
    );
  }
}

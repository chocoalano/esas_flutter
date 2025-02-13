import 'package:flutter/material.dart';

class DropdownFieldWidget extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;
  final Color fillColor;
  final double borderRadius;

  const DropdownFieldWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label = "Pilih tipe",
    this.icon = Icons.merge_type,
    this.validator,
    this.fillColor = const Color(0xFFEEEEEE), // default fill color
    this.borderRadius = 10.0,
  });

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none,
      ),
      fillColor: fillColor,
      filled: true,
      prefixIcon: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: _inputDecoration(),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Field ini tidak boleh kosong';
            }
            return null;
          },
    );
  }
}

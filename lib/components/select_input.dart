import '../constant.dart';
import 'package:flutter/material.dart';

class SelectInput<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String hintText;
  final IconData icon;
  final ValueChanged<T?> onChanged;

  const SelectInput({
    super.key,
    required this.value,
    required this.items,
    required this.hintText,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor.withOpacity(0.1),
        filled: true,
        hintText: hintText,
        prefixIcon: Icon(icon),
      ),
    );
  }
}

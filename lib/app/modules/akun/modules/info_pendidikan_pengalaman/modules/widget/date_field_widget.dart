import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Pastikan menggunakan paket intl untuk DateFormat

class DateFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final BuildContext context;
  final Color fillColor;
  final double borderRadius;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onDateSelected;

  const DateFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.context,
    this.fillColor = const Color(0xFFEEEEEE), // Default fill color
    this.borderRadius = 10.0,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.validator,
    this.onDateSelected,
  });

  InputDecoration _inputDecoration() {
    return InputDecoration(
      labelText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none,
      ),
      fillColor: fillColor,
      filled: true,
      prefixIcon: Icon(icon),
    );
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      controller.text = formattedDate;
      if (onDateSelected != null) {
        onDateSelected!(formattedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: _inputDecoration(),
          validator: validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Tanggal $hintText tidak boleh kosong';
                }
                return null;
              },
        ),
      ),
    );
  }
}

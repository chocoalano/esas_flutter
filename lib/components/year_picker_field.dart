import '../constant.dart';
import 'package:flutter/material.dart';

class YearPickerField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;

  const YearPickerField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true, // Prevents manual input
      onTap: () async {
        final selectedYear = await _showYearPicker(context);
        if (selectedYear != null) {
          controller.text = selectedYear
              .toString(); // Update the text field with the selected year
        }
      },
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

  Future<int?> _showYearPicker(BuildContext context) async {
    final DateTime? selectedYear = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 300,
            child: YearPicker(
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              selectedDate: DateTime.now(),
              onChanged: (DateTime date) {
                Navigator.of(context)
                    .pop(date); // Close the dialog and return the selected date
              },
            ),
          ),
        );
      },
    );
    return selectedYear?.year; // Return only the year
  }
}

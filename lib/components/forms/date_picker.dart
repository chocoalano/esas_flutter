import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class DatePickerComponent extends StatelessWidget {
  final String label;
  final String name;
  final RxString selectedDate;
  final Color primaryColor;
  final void Function(DateTime?)? onChanged;

  const DatePickerComponent({
    super.key,
    required this.name,
    required this.selectedDate,
    required this.primaryColor,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      name: name,
      inputType: InputType.date,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: primaryColor.withOpacity(0.1),
        filled: true,
        labelText: label,
        prefixIcon: const Icon(Icons.calendar_month_outlined),
      ),
      format: DateFormat('yyyy-MM-dd'),
      validator: FormBuilderValidators.required(
        errorText: 'Tanggal harus diisi',
      ),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
        selectedDate.value = DateFormat('yyyy-MM-dd').format(value!);
      },
    );
  }
}

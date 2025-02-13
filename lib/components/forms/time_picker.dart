import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class TimePickerComponent extends StatelessWidget {
  final String name;
  final String labelText;
  final Rx<TimeOfDay> selectedTime;
  final TextEditingController controller;
  final Color primaryColor;
  final bool isTimeIn;

  const TimePickerComponent({
    super.key,
    required this.name,
    required this.labelText,
    required this.selectedTime,
    required this.controller,
    required this.primaryColor,
    required this.isTimeIn,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<TimeOfDay>(
      name: name,
      validator: FormBuilderValidators.required(errorText: 'Waktu harus diisi'),
      builder: (FormFieldState<TimeOfDay?> field) {
        return InkWell(
          onTap: () async {
            final pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              selectedTime.value = pickedTime;
              controller.text = _formatTime(pickedTime);
              field.didChange(pickedTime);
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              fillColor: primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.access_time),
            ),
            child: Text(
                controller.text.isNotEmpty ? controller.text : 'Pilih Waktu'),
          ),
        );
      },
    );
  }

  // Format the selected time into a readable string (HH:mm format)
  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

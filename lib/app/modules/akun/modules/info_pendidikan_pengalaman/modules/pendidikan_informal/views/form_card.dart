import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../components/year_picker_field.dart';
import '../../../../../../../../constant.dart';
import '../../widget/action_button_widget.dart';
import '../../widget/checked_field_widget.dart';
import '../../widget/dropdown_field_widget.dart';
import '../../widget/text_field_widget.dart';
import '../controllers/pendidikan_informal_controller.dart';

class FormCard extends StatefulWidget {
  final int index;
  final VoidCallback onRemove;

  const FormCard({
    super.key,
    required this.index,
    required this.onRemove,
  });

  @override
  FormCardState createState() => FormCardState();
}

class FormCardState extends State<FormCard> {
  late final TextEditingController _institutionController;
  late final TextEditingController _startController;
  late final TextEditingController _finishController;
  late final TextEditingController _durationController;

  final _formKey = GlobalKey<FormState>();
  final PendidikanInformalController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from formData
    _institutionController = TextEditingController(
      text: _controller.formData[widget.index]['institution'] ?? '',
    );
    _startController = TextEditingController(
      text: _controller.formData[widget.index]['start'] ?? '',
    );
    _finishController = TextEditingController(
      text: _controller.formData[widget.index]['finish'] ?? '',
    );
    _durationController = TextEditingController(
      text: _controller.formData[widget.index]['duration']?.toString() ?? '0',
    );

    // Attach listeners to controllers for automatic form updates
    _institutionController.addListener(
        () => _updateForm('institution', _institutionController.text));
    _startController
        .addListener(() => _updateForm('start', _startController.text));
    _finishController
        .addListener(() => _updateForm('finish', _finishController.text));
    _durationController
        .addListener(() => _updateForm('duration', _durationController.text));
  }

  void _updateForm(String key, String value) {
    _controller.updateForm(widget.index, key, value);
  }

  void _handleRemove() {
    _controller.removeForm(widget.index);
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _startController.dispose();
    _finishController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusValue =
        _getValidStatusValue(_controller.formData[widget.index]['status']);
    return Form(
      key: _formKey,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ActionButtonWidget(
                formKey: _formKey,
                onRemove: _handleRemove,
                removeIconColor: dangerColor,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _institutionController,
                label: "Institusi",
                icon: Icons.account_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Institusi tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              DropdownFieldWidget(
                value: _controller.formData[widget.index]['type'] ?? 'day',
                items: const [
                  DropdownMenuItem(value: 'day', child: Text('Harian')),
                  DropdownMenuItem(value: 'month', child: Text('Bulanan')),
                  DropdownMenuItem(value: 'year', child: Text('Tahunan')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    _updateForm('type', value);
                  }
                },
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 10.0,
              ),
              const SizedBox(height: 10),
              YearPickerField(
                controller: _startController,
                hintText: 'Tahun Mulai',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 10),
              YearPickerField(
                controller: _finishController,
                hintText: 'Tahun Selesai',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _durationController,
                label: "Durasi",
                icon: Icons.account_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Durasi tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              DropdownFieldWidget(
                label: 'Pilih status',
                value: statusValue,
                items: const [
                  DropdownMenuItem(value: 'passed', child: Text('Lulus')),
                  DropdownMenuItem(
                      value: 'not-passed', child: Text('Tidak lulus')),
                  DropdownMenuItem(
                      value: 'in-progress', child: Text('Dalam proses')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    _updateForm('status', value);
                  }
                },
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 10.0,
              ),
              const SizedBox(height: 10),
              CheckedFieldWidget(
                isChecked: _controller.formData[widget.index]
                            ['certification'] ==
                        'true'
                    ? true
                    : false,
                label: 'Apakah pendidikan ini tersertifikasi?',
                icon: Icons.verified_user,
                onChanged: (bool? value) {
                  _updateForm('certification', value.toString());
                },
                activeColor: primaryColor,
                checkColor: Colors.white,
                iconColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 0.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _getValidStatusValue(String? value) {
    const validValues = [
      'passed',
      'not-passed',
      'in-progress',
    ];
    return (value != null && validValues.contains(value)) ? value : null;
  }
}

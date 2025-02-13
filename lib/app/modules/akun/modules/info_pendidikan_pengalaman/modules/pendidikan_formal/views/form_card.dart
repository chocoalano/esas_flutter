import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../components/year_picker_field.dart';
import '../../../../../../../../constant.dart';
import '../../widget/action_button_widget.dart';
import '../../widget/checked_field_widget.dart';
import '../../widget/dropdown_field_widget.dart';
import '../../widget/text_field_widget.dart';
import '../controllers/pendidikan_formal_controller.dart';

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
  late final TextEditingController _scoreController;
  late final TextEditingController _startController;
  late final TextEditingController _finishController;

  final _formKey = GlobalKey<FormState>();

  final AkunPendidikanFormalController _controller = Get.find();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from formData
    _institutionController = TextEditingController(
      text: _controller.formData[widget.index]['institution'] ?? '',
    );
    _scoreController = TextEditingController(
      text: _controller.formData[widget.index]['score'] ?? '',
    );
    _startController = TextEditingController(
      text: _controller.formData[widget.index]['start'] ?? '',
    );
    _finishController = TextEditingController(
      text: _controller.formData[widget.index]['finish'] ?? '',
    );

    // Attach listeners to controllers for automatic form updates
    _institutionController.addListener(
        () => _updateForm('institution', _institutionController.text));
    _scoreController
        .addListener(() => _updateForm('score', _scoreController.text));
    _startController
        .addListener(() => _updateForm('start', _startController.text));
    _finishController
        .addListener(() => _updateForm('finish', _finishController.text));
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
    _scoreController.dispose();
    _startController.dispose();
    _finishController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current majors value
    final majorsValue =
        _getValidMajorsValue(_controller.formData[widget.index]['majors']);
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
                label: "Nama",
                icon: Icons.account_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              DropdownFieldWidget(
                value: majorsValue,
                items: const [
                  DropdownMenuItem(value: 'SD', child: Text('SD')),
                  DropdownMenuItem(value: 'SMP', child: Text('SMP')),
                  DropdownMenuItem(value: 'SMA/SLTA', child: Text('SMA/SLTA')),
                  DropdownMenuItem(value: 'D1', child: Text('D1')),
                  DropdownMenuItem(value: 'D2', child: Text('D2')),
                  DropdownMenuItem(value: 'D3', child: Text('D3')),
                  DropdownMenuItem(value: 'D4', child: Text('D4')),
                  DropdownMenuItem(value: 'S1', child: Text('S1')),
                  DropdownMenuItem(value: 'S2', child: Text('S2')),
                  DropdownMenuItem(value: 'S3', child: Text('S3')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    _updateForm('majors', value);
                  }
                },
                fillColor: primaryColor.withOpacity(0.1),
                borderRadius: 10.0,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _scoreController,
                label: "Skor/IPK",
                icon: Icons.phone_android_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Skor/IPK tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Ensure value exists in the dropdown options
  String? _getValidMajorsValue(String? value) {
    const validValues = [
      'SD',
      'SMP',
      'SMA/SLTA',
      'D1',
      'D2',
      'D3',
      'D4',
      'S1',
      'S2',
      'S3',
    ];
    return (value != null && validValues.contains(value)) ? value : null;
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

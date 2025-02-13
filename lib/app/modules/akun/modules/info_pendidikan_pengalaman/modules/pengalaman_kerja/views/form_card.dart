// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../../../components/year_picker_field.dart';
import '../../../../../../../../constant.dart';
import '../../widget/action_button_widget.dart';
import '../../widget/checked_field_widget.dart';
import '../../widget/text_field_widget.dart';
import '../controllers/pengalaman_kerja_controller.dart';

class FormCard extends StatefulWidget {
  final int index;
  final VoidCallback onRemove;

  const FormCard({super.key, required this.index, required this.onRemove});

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  late final TextEditingController _company_name;
  late final TextEditingController _position;
  late final TextEditingController _start;
  late final TextEditingController _finish;

  final _formKey = GlobalKey<FormState>();
  final PengalamanKerjaController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _company_name = TextEditingController(
        text: controller.formData[widget.index]['company_name'] ?? '');
    _position = TextEditingController(
        text: controller.formData[widget.index]['position'] ?? '');
    _start = TextEditingController(
        text: controller.formData[widget.index]['start'] ?? '');
    _finish = TextEditingController(
        text: controller.formData[widget.index]['finish'] ?? '');
    // Attach listeners to controllers for automatic form updates
    _company_name
        .addListener(() => _updateForm('company_name', _company_name.text));
    _position.addListener(() => _updateForm('position', _position.text));
    _start.addListener(() => _updateForm('start', _start.text));
    _finish.addListener(() => _updateForm('finish', _finish.text));
  }

  void _updateForm(String key, String value) {
    controller.updateForm(widget.index, key, value);
  }

  void _handleRemove() {
    controller.removeForm(widget.index);
  }

  @override
  void dispose() {
    _company_name.dispose();
    _position.dispose();
    _start.dispose();
    _finish.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _company_name,
                label: "Nama perusahaan",
                icon: Icons.business_center_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama perusahaan tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0, // Optional customization
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                controller: _position,
                label: 'Posisi',
                icon: Icons.account_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Posisi tidak boleh kosong';
                  }
                  return null;
                },
                fillColor:
                    primaryColor.withOpacity(0.1), // Optional customization
                borderRadius: 10.0,
              ),
              const SizedBox(height: 10),
              YearPickerField(
                controller: _start,
                hintText: 'Tahun Mulai',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 10),
              YearPickerField(
                controller: _finish,
                hintText: 'Tahun Selesai',
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 10),
              CheckedFieldWidget(
                isChecked:
                    controller.formData[widget.index]['certification'] == 'true'
                        ? true
                        : false,
                label: 'Apakah pekerjaan ini tersertifikasi?',
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
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../constant.dart';
import '../controllers/info_keluarga_controller.dart';

class FormCard extends StatefulWidget {
  final int index;
  final VoidCallback onRemove;

  const FormCard({super.key, required this.index, required this.onRemove});

  @override
  FormCardState createState() => FormCardState();
}

class FormCardState extends State<FormCard> {
  late final TextEditingController _nameController;
  late final TextEditingController _birthdateController;
  late final TextEditingController _jobController;

  final _formKey = GlobalKey<FormState>();
  final InfoKeluargaController _controller = Get.find();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: _controller.formData[widget.index]['fullname'] ?? '',
    );
    _birthdateController = TextEditingController(
      text: _controller.formData[widget.index]['birthdate'] ?? '',
    );
    _jobController = TextEditingController(
      text: _controller.formData[widget.index]['job'] ?? '',
    );

    _nameController
        .addListener(() => _updateForm('fullname', _nameController.text));
    _birthdateController
        .addListener(() => _updateForm('birthdate', _birthdateController.text));
    _jobController.addListener(() => _updateForm('job', _jobController.text));
  }

  void _updateForm(String key, String value) {
    _controller.updateForm(widget.index, key, value);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdateController.dispose();
    _jobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? relationshipValue = _getValidRelationshipValue(
      _controller.formData[widget.index]['relationship'],
    );
    final String? maritalStatusValue = _getValidMaritalStatusValue(
      _controller.formData[widget.index]['marital_status'],
    );

    return Form(
      key: _formKey,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              _buildActionButton(),
              const SizedBox(height: 10),
              _buildTextField(
                _nameController,
                'Nama',
                Icons.account_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              _buildDropdownField(
                value: relationshipValue,
                items: const [
                  DropdownMenuItem(value: 'wife', child: Text('Istri')),
                  DropdownMenuItem(value: 'husband', child: Text('Suami')),
                  DropdownMenuItem(value: 'mother', child: Text('Ibu')),
                  DropdownMenuItem(value: 'father', child: Text('Ayah')),
                  DropdownMenuItem(
                      value: 'brother', child: Text('Saudara Laki-laki')),
                  DropdownMenuItem(
                      value: 'sister', child: Text('Saudara Perempuan')),
                  DropdownMenuItem(value: 'child', child: Text('Anak')),
                ],
                onChanged: (value) => _updateDropdown('relationship', value),
                icon: Icons.family_restroom_outlined,
              ),
              const SizedBox(height: 10),
              _buildDatePicker(
                controller: _birthdateController,
                hintText: 'Pilih tanggal lahir',
                icon: Icons.calendar_today,
                context: context,
              ),
              const SizedBox(height: 10),
              _buildDropdownField(
                value: maritalStatusValue,
                items: const [
                  DropdownMenuItem(value: 'single', child: Text('Lajang')),
                  DropdownMenuItem(value: 'married', child: Text('Menikah')),
                  DropdownMenuItem(value: 'widow', child: Text('Janda')),
                  DropdownMenuItem(value: 'widower', child: Text('Duda')),
                ],
                onChanged: (value) => _updateDropdown('marital_status', value),
                icon: Icons.female_outlined,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                _jobController,
                'Profesi',
                Icons.work_history_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Profesi tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _updateDropdown(String key, String? value) {
    if (value != null) {
      _controller.updateForm(widget.index, key, value);
    }
  }

  Widget _buildActionButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: widget.onRemove,
          icon: const Icon(Icons.remove_circle_outline, color: dangerColor),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(label, icon),
      validator: validator,
    );
  }

  Widget _buildDatePicker({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
          _controller.updateForm(widget.index, 'birthdate', formattedDate);
        }
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          decoration: _inputDecoration(hintText, icon),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Tanggal lahir tidak boleh kosong';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required IconData icon,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items,
      onChanged: onChanged,
      decoration: _inputDecoration('Pilih', icon),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini tidak boleh kosong';
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      fillColor: primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: Icon(icon),
    );
  }

  String? _getValidRelationshipValue(String? value) {
    const validValues = [
      'wife',
      'husband',
      'mother',
      'father',
      'brother',
      'sister',
      'child'
    ];
    return (value != null && validValues.contains(value)) ? value : null;
  }

  String? _getValidMaritalStatusValue(String? value) {
    const validValues = ['single', 'married', 'widow', 'widower'];
    return (value != null && validValues.contains(value)) ? value : null;
  }
}

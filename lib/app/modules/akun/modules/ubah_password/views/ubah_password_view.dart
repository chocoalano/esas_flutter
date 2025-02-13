import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../../../components/btn_action.dart';
import '../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../constant.dart';
import '../controllers/ubah_password_controller.dart';

class UbahPasswordView extends GetView<UbahPasswordController> {
  const UbahPasswordView({super.key});

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      fillColor: primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: const Icon(Icons.lock_outline),
    );
  }

  Widget _buildPasswordField({
    required String name,
    required String label,
  }) {
    return FormBuilderTextField(
      name: name,
      decoration: _inputDecoration(label),
      obscureText: true,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(6),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/akun');
      },
      child: Scaffold(
        appBar: GlobatAppbar(
          title: 'Ubah password',
          act: () => Get.offAllNamed('/akun'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: controller.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                _buildPasswordField(
                  name: 'old_password',
                  label: 'Password Lama',
                ),
                const SizedBox(height: 16),
                _buildPasswordField(
                  name: 'new_password',
                  label: 'Password Baru',
                ),
                const SizedBox(height: 16),
                _buildPasswordField(
                  name: 'confirm_password',
                  label: 'Konfirmasi Password Baru',
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: BtnAction(
              act: controller.submitForm,
              color: primaryColor,
              icon: Icons.save_as_outlined,
              isLoading: controller.isLoading,
              title: 'Simpan data',
            ),
          ),
        ),
      ),
    );
  }
}

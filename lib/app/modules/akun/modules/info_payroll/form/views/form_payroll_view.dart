import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import '../../../../../../../components/btn_action.dart';
import '../../../../../../../components/forms/text_input.dart';
import '../../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../../constant.dart';
import '../controllers/form_payroll_controller.dart';

class FormPayrollView extends GetView<FormPayrollController> {
  const FormPayrollView({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Get.offAllNamed('/akun/info-payroll');
        }
      },
      child: Scaffold(
          appBar: GlobatAppbar(
            title: 'Perbaharui bank',
            act: () => Get.offAllNamed('/akun'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: controller.formKey,
              child: Column(
                children: [
                  TextFieldComponent(
                      icon: Icons.business_outlined,
                      label: 'Nama Bank',
                      name: 'bank_name',
                      onChanged: (input) => controller.bank_name(input)),
                  const SizedBox(height: 16),
                  TextFieldComponent(
                      icon: Icons.credit_card,
                      label: 'Nomor Rekening',
                      name: 'bank_number',
                      onChanged: (input) => controller.bank_number(input)),
                  const SizedBox(height: 16),
                  TextFieldComponent(
                      icon: Icons.account_balance,
                      label: 'Atas nama pemilik akun',
                      name: 'bank_holder',
                      onChanged: (input) => controller.bank_holder(input)),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: BtnAction(
                act: controller.onSubmit,
                color: primaryColor,
                icon: Icons.save_as_outlined,
                isLoading: controller.isLoading,
                title: 'Simpan data',
              ),
            ),
          )),
    );
  }
}

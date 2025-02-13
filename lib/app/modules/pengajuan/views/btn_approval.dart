import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../../constant.dart';
import '../../../../support/style.dart';
import '../../../models/Permit/permit_list.dart';
import '../../../models/Permit/permit_type.dart';
import '../controllers/pengajuan_list_controller.dart';

Widget btnApproval(PermitList data) {
  final PengajuanListController controller =
      Get.find<PengajuanListController>();
  final formKey = GlobalKey<FormBuilderState>();

  return FormBuilder(
    key: formKey,
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        FormBuilderTextField(
          name: 'notes',
          maxLines: 3,
          decoration: formTextAreaInput(label: 'Pesan permohonan'),
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(10),
          ]),
        ),
        const SizedBox(
          height: 10,
        ),
        _buildActionButtons(formKey, data, controller),
      ],
    ),
  );
}

// Helper function to build approval action buttons
Widget _buildActionButtons(GlobalKey<FormBuilderState> formKey, PermitList data,
    PengajuanListController controller) {
  return OverflowBar(
    alignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildApprovalButton(
        label: controller.isLoadingAct.isTrue ? 'Proses' : 'Tolak permintaan',
        backgroundColor: dangerColor,
        approvalStatus: 'n',
        formKey: formKey,
        data: data,
        controller: controller,
      ),
      _buildApprovalButton(
        label: controller.isLoadingAct.isTrue ? 'Proses' : 'Terima permintaan',
        backgroundColor: primaryColor,
        approvalStatus: 'y',
        formKey: formKey,
        data: data,
        controller: controller,
      ),
    ],
  );
}

// Helper function to create a single approval button
Widget _buildApprovalButton({
  required String label,
  required Color backgroundColor,
  required String approvalStatus,
  required GlobalKey<FormBuilderState> formKey,
  required PermitList data,
  required PengajuanListController controller,
}) {
  return ElevatedButton(
    onPressed: () {
      _handleApproval(
          formKey, approvalStatus, data.id, controller, data.permitType);
    },
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: backgroundColor,
    ),
    child: Text(
      label,
      style: const TextStyle(color: bgColor, fontSize: 14),
    ),
  );
}

// Helper function to handle approval logic
void _handleApproval(GlobalKey<FormBuilderState> formKey, String approvalStatus,
    int id, PengajuanListController controller, PermitType permitType) {
  if (formKey.currentState?.saveAndValidate() ?? false) {
    final formData = formKey.currentState!.value;
    controller.approved(
        id, approvalStatus, formData['notes'] ?? '', permitType);
  } else {
    _showValidationError();
  }
}

// Helper function to show validation error message
void _showValidationError() {
  showErrorSnackbar('Please fill in all required fields.');
}

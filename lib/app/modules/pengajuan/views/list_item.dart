import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/widgets/subtitle_row_text.dart';
import '../../../../constant.dart';
import '../../../../support/support.dart';
import '../../../../support/typography.dart';
import '../../../models/Permit/permit_list.dart';
import 'btn_approval.dart';

Widget listItem(PermitList data) {
  return Card(
    color: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
      side: BorderSide(color: Colors.grey.shade300),
    ),
    elevation: 0,
    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                limitString(data.permitType.type, 25),
                style: listile,
              ),
              TextButton.icon(
                onPressed: () =>
                    Get.offAllNamed('pengajuan/cuti/show', arguments: data),
                label: const Text('Detail'),
                icon: const Icon(Icons.info_outline),
              )
            ],
          ),
          const SizedBox(height: 8.0),

          // Subtitle Section
          buildSubtitleRow('Nama', limitString(data.user.name, 25)),
          buildSubtitleRow('NIP', limitString(data.user.nip, 25)),
          buildSubtitleRow('Tgl. Mulai', formatDate(data.startDate)),
          buildSubtitleRow('Tgl. Selesai', formatDate(data.endDate)),

          // Approvals Section
          if (data.approvals.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: data.approvals
                  .map(
                    (approval) => buildSubtitleRow(
                      'Status ${approval.userType}', // Assuming `userType` is a property in approval
                      approvalString(approval
                          .userApprove!), // Assuming `status` is a property in approval
                    ),
                  )
                  .toList(),
            ),

          // Notes Section
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              limitString(data.notes ?? 'Unknown notes!', 100),
              style: TextStyle(color: Colors.grey.shade500),
            ),
          ),

          const SizedBox(height: 12.0),

          // Approval Buttons Section
          if (validateApproval(data.approvals)) btnApproval(data),
        ],
      ),
    ),
  );
}

import 'package:esas_flutter/support/typography.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../components/widgets/globat_appbar.dart';
import '../../../../../../constant.dart';
import '../../../../../../support/support.dart';
import '../../../../../models/Tools/bug_reports.dart';
import '../controllers/bugs_report_controller.dart';

class ShowBugsReportView extends GetView<BugsReportController> {
  const ShowBugsReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments as BugReports;
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          }
          Get.offAllNamed('/akun/info-report-bugs');
        },
        child: Scaffold(
            appBar: GlobatAppbar(
              title: 'Laporan Bugs',
              act: () => Get.offAllNamed('/akun'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      limitString(data.title ?? '...', 50),
                      style: title,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.message ?? '...',
                      textAlign: TextAlign.justify,
                      style: paragraph,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height / 3.5,
                      decoration: BoxDecoration(
                        color: Colors
                            .grey.shade200, // Background color for image box
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: data.image!.isNotEmpty
                            ? Image.network(
                                "$baseUrlApi/assets/${data.image}", // Full image URL
                                fit: BoxFit
                                    .cover, // Ensures the image fits properly within the box
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey
                                        .shade300, // Background color for the placeholder
                                    child: const Icon(
                                      Icons
                                          .image, // Icon to indicate missing image
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ); // Placeholder when image fails to load
                                },
                              )
                            : Container(
                                color: Colors.grey
                                    .shade300, // Background color for the placeholder
                                child: const Icon(
                                  Icons.image, // Icon to indicate missing image
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ), // Placeholder when URL is empty
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

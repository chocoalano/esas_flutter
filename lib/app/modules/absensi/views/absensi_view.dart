import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../components/widgets/photo_box.dart';
import '../../../../constant.dart';
import '../../../../support/support.dart';
import '../../../models/attendance/attendance_auth.dart';
import '../controllers/list_controller.dart';

class AbsensiView extends StatelessWidget {
  const AbsensiView({super.key});

  @override
  Widget build(BuildContext context) {
    final ListController controller = Get.put(ListController());
    final ScrollController scrollController = ScrollController();

    // Load data saat widget diinisialisasi
    controller.loadMoreList(controller.filter.value.toString());

    // Mengatur penanganan refresh
    Future<void> onRefresh() async {
      await controller.refreshData();
    }

    // Listener untuk pagination
    void onScroll() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadMoreList(controller.filter.value.toString());
      }
    }

    // Menambahkan listener scroll
    scrollController.addListener(onScroll);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        Get.offAllNamed('/beranda');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: bgColor.withOpacity(0.1), // Latar belakang dropdown
                  borderRadius: BorderRadius.circular(10), // Sudut melengkung
                  border: Border.all(color: primaryColor, width: 1), // Border
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month,
                        color: bgColor), // Ikon di sebelah kiri
                    const SizedBox(width: 8), // Jarak antara ikon dan dropdown
                    Expanded(
                      child: DropdownButton<String>(
                        value: controller.filter.value
                            .toString(), // Nilai saat ini
                        icon: const Icon(Icons.arrow_drop_down,
                            color: bgColor), // Ikon dropdown
                        dropdownColor:
                            primaryColor, // Warna dropdown saat dibuka
                        style: const TextStyle(
                          color: bgColor,
                          fontSize: 16, // Gaya teks opsi
                        ),
                        isExpanded: true, // Dropdown memenuhi lebar container
                        underline:
                            const SizedBox(), // Menghilangkan garis bawah bawaan
                        items: controller.months.map<DropdownMenuItem<String>>(
                          (Map<String, String> month) {
                            return DropdownMenuItem<String>(
                              value: month['value'],
                              child: Text(
                                month['nama']!,
                                style: const TextStyle(
                                    fontSize: 16), // Gaya teks opsi
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String? newValue) => controller
                            .calendarSelected(int.tryParse(newValue!) ?? 0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: bgColor,
            ),
            onPressed: () {
              Get.offAllNamed('/beranda');
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: bgColor,
              ),
              onPressed: () => controller.refreshData(),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: onRefresh,
          child: Obx(() {
            return ListView.builder(
              controller: scrollController,
              itemCount: controller.list.length,
              itemBuilder: (context, index) {
                if (index < controller.list.length) {
                  final item = controller.list[index];
                  return _buildListTile(item);
                } else {
                  return _buildLoadingIndicator();
                }
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildListTile(AttendanceAuth item) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 209, 209, 209)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: _buildSubtitle(item),
          onTap: () => _showDetails(item),
        ),
      ),
    );
  }

  Widget _buildSubtitle(AttendanceAuth item) {
    return Column(
      children: [
        _buildInfoRow(
            item.createdAt != null ? formatDate(item.createdAt) : '',
            item.timeIn != null ? formatTimeSting(item.timeIn) : '00:00',
            item.statusIn ?? '',
            item.timeOut != null ? formatTimeSting(item.timeOut) : '00:00',
            item.statusOut ?? ''),
      ],
    );
  }

  Widget _buildInfoRow(String label, String valueIn, String statusIn,
      String valueOut, String statusOut) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          valueIn,
          style:
              TextStyle(color: statusIn == 'late' ? dangerColor : Colors.black),
        ),
        Text(
          valueOut,
          style: TextStyle(
              color: statusOut == 'late' ? Colors.black : dangerColor),
        ),
      ],
    );
  }

  Widget _buildInfoDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget _buildInfoStatusRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(
          value,
          style: TextStyle(color: value == 'late' ? dangerColor : primaryColor),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Center(
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );
  }

  void _showDetails(AttendanceAuth item) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: Get.height / 1.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailHeader(),
              const Divider(),
              const SizedBox(height: 10),
              _buildInfoDetailRow('NIP', item.nip ?? ''),
              _buildInfoDetailRow('Tanggal', formatDate(item.createdAt)),
              _buildInfoDetailRow('Jam masuk', formatTimeSting(item.timeIn)),
              _buildInfoStatusRow('Status Jam masuk', item.statusIn ?? ''),
              _buildInfoDetailRow(
                  'Jam pulang',
                  item.timeOut != null
                      ? formatTimeSting(item.timeOut)
                      : '--:--:--'),
              _buildInfoStatusRow('Status Jam pulang',
                  item.timeOut != null ? item.statusOut ?? '' : '---'),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              _buildPhotoSection(item)
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Detail Absen',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close_outlined),
        ),
      ],
    );
  }

  Widget _buildPhotoSection(AttendanceAuth item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Column(
            children: [
              const Text(
                'In',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              PhotoBox(
                photoUrl: "$baseUrlApi/assets/${item.imageIn}",
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            children: [
              const Text(
                'Out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              PhotoBox(
                photoUrl: "$baseUrlApi/assets/${item.imageOut}",
              ),
            ],
          ),
        ),
      ],
    );
  }
}

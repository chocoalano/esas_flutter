import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../components/widgets/snackbar.dart';
import '../../../models/attendance/attendance_auth.dart';
import '../../../networks/api/beranda/api_absen.dart';

class ListController extends GetxController {
  final ApiAbsen provider = ApiAbsen();
  final int page = 1;
  final int limit = 31;

  // Reactive variables
  var isLoading = false.obs;
  var filter = DateTime.now().month.obs;
  var list = <AttendanceAuth>[].obs;

  // Month names for the calendar
  final List<Map<String, String>> months = List.generate(12, (index) {
    final monthName = DateFormat.MMMM().format(DateTime(0, index + 1));
    return {'nama': monthName, 'value': '${index + 1}'};
  });

  @override
  void onInit() {
    super.onInit();
    loadMoreList(filter.value.toString()); // Load initial data
  }

  void calendarSelected(int date) {
    if (date >= 1 && date <= 12 && filter.value != date) {
      filter(date); // Update the filter only if it's valid and changes
      refreshData(); // Refresh the list with the new filter
    }
  }

  Future<void> loadMoreList(String filter) async {
    try {
      isLoading(true); // Show loading indicator
      List<AttendanceAuth> response =
          await provider.fetchPaginate(page, limit, filter);

      list.clear();
      list.addAll(response);
      list.refresh(); // Force UI update

      // Cek apakah list memiliki cukup data sebelum mengakses index 1
      if (list.length > 1) {
        if (kDebugMode) {
          print("===================>>>>>>>>${list[0].timeOut}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error in loadMoreList: ${e.toString()}");
      }
      showErrorSnackbar(
          "Terjadi kesalahan pada controller list absen: ${e.toString()}");
    } finally {
      isLoading(false); // Hide loading indicator
    }
  }

  Future<void> refreshData() async {
    try {
      isLoading(true);
      list.clear();
      await loadMoreList(filter.value.toString());
    } catch (e) {
      if (kDebugMode) {
        print("Error in refreshData: ${e.toString()}");
      }
      showErrorSnackbar("Gagal memuat ulang data: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }
}

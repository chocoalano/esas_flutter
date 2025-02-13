import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../app/models/Permit/approval.dart';

bool validateApproval(List<Approval> approvals) {
  // Inisialisasi GetStorage untuk membaca local storage
  final GetStorage getLocalStorage = GetStorage();
  // Membaca userId dari local storage
  final int? authId = getLocalStorage.read<int>('userId');
  // Validasi jika userId tidak ditemukan
  if (authId == null) {
    throw Exception('User ID not found in local storage');
  }
  // Cek apakah ada approval yang sesuai dengan userId
  final bool hasApproval = approvals.any(
      (approval) => approval.userId == authId && approval.userApprove == 'w');

  return hasApproval;
}

String capitalizedString(String text, {int maxLength = 70}) {
  if (text.isEmpty) return text;

  // Batasi panjang teks sesuai dengan maxLength
  String limitedText =
      text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';

  // Ubah huruf pertama menjadi kapital dan sisanya huruf kecil
  return limitedText[0].toUpperCase() + limitedText.substring(1);
}

String limitString(String text, int maxLength) {
  if (text.isEmpty) return text;
  String limitedText =
      text.length <= maxLength ? text : '${text.substring(0, maxLength)}...';
  return limitedText[0].toUpperCase() + limitedText.substring(1).toLowerCase();
}

String jenisKelamin(String text) {
  if (text == 'm') {
    return 'Pria';
  } else {
    return 'Wanita';
  }
}

String statusPernikahan(String text) {
  if (text == 'widow') {
    return 'Janda';
  } else if (text == 'widower') {
    return 'Duda';
  } else if (text == 'single') {
    return 'Lajang';
  } else {
    return 'Menikah';
  }
}

String approvalString(String type) {
  switch (type) {
    case 'w':
      return 'Menunggu';
    case 'y':
      return 'Disetujui';
    case 'n':
      return 'Ditolak';
    default:
      return '';
  }
}

double safeToDouble(dynamic value) {
  if (value == null) {
    return 0.0;
  }
  if (value is double) {
    return value;
  }
  if (value is int) {
    return value.toDouble();
  }
  try {
    return double.parse(value.toString());
  } catch (e) {
    return 0.0;
  }
}

String formatDate(DateTime? date) {
  if (date == null) return ''; // Handle null date case
  return DateFormat('yyyy-MM-dd').format(date);
}

// Format TimeOfDay to HH:mm:ss string
String formatTime(TimeOfDay time) {
  final now = DateTime.now();
  final formattedTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  return DateFormat('HH:mm:ss').format(formattedTime);
}

String formatTimeSting(String? time) {
  if (time == null || time.isEmpty) {
    return '00:00'; // Mengembalikan nilai default jika null atau kosong
  }
  final parts = time.split(':');
  if (parts.length >= 2) {
    final hour =
        parts[0].padLeft(2, '0'); // Menambahkan '0' jika jam kurang dari 10
    final minute =
        parts[1].padLeft(2, '0'); // Menambahkan '0' jika menit kurang dari 10
    return '$hour:$minute'; // Mengembalikan waktu dalam format HH:mm
  }
  return '00:00';
}

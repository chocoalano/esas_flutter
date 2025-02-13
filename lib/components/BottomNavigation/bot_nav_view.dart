import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import 'bot_nav_controller.dart';

class BotNavView extends StatelessWidget {
  BotNavView({super.key});

  // Inisialisasi controller
  final BotNavController controller = Get.put(BotNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Tim',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_open),
              label: 'Pengajuan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Akun',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.black54,
          selectedFontSize: 15,
          unselectedLabelStyle: _unselectedLabelStyle,
          selectedLabelStyle: _selectedLabelStyle,
          showUnselectedLabels: true,
          currentIndex: controller.pageIndex.value,
          onTap: controller.changePage,
        ));
  }

  // Gaya label yang terpilih
  static const TextStyle _selectedLabelStyle = TextStyle(
    color: primaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );

  // Gaya label yang tidak terpilih
  static const TextStyle _unselectedLabelStyle = TextStyle(
    color: Colors.black54,
    fontWeight: FontWeight.normal,
    fontSize: 13,
  );
}

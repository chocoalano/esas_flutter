import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../components/BottomNavigation/bot_nav_view.dart';
import '../../../../../constant.dart';
import '../../../../../support/typography.dart';
import '../controllers/akun_controller.dart';

class AkunView extends GetView<AkunController> {
  const AkunView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getProfile();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (context.mounted) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileSection(),
              const SizedBox(height: 20),
              _buildSection('Info saya', _infoSayaOptions()),
              _buildSection('Support', _supportOptions()),
              _buildSection('Pengaturan', _settingsOptions()),
            ],
          ),
        ),
        bottomNavigationBar: BotNavView(),
      ),
    );
  }

  // Build AppBar
  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primaryColor,
      title: const Text(
        'Profil',
        style: TextStyle(color: bgColor),
      ),
      centerTitle: true,
    );
  }

  // Build profile section with avatar, name, and position
  Widget _buildProfileSection() {
    return Row(
      children: [
        Stack(
          children: [
            _buildProfileImage(),
            Positioned(
              bottom: 0,
              right: 0,
              child: _buildEditButton(),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    controller.profile.value.name ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
              Obx(() => Text(
                    controller.profile.value.departement ?? 'Departement ?',
                    style: caption,
                  )),
              Obx(() => Text(
                    controller.profile.value.position ?? 'Position ?',
                    style: caption,
                  )),
            ],
          ),
        ),
      ],
    );
  }

  // Build profile image
  Widget _buildProfileImage() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: primaryColor, width: 4),
      ),
      child: Obx(() {
        final imageUrl = controller.profile.value.avatar ?? '';
        return CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey.shade200,
          child: ClipOval(
            child: Image.network(
              "$baseUrlApi/assets/$imageUrl",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.grey);
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        );
      }),
    );
  }

  // Build edit button for profile image
  Widget _buildEditButton() {
    return CircleAvatar(
      radius: 15,
      backgroundColor: Colors.white,
      child: IconButton(
        icon: const Icon(Icons.camera, size: 18, color: primaryColor),
        onPressed: _pickFile,
      ),
    );
  }

  // Pick image from camera
  Future<void> _pickFile() async {
    File? selectedFile;
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedFile = File(pickedFile.path);
      controller.submitAvatar(selectedFile);
    }
  }

  // Build a section with title and list of options
  Widget _buildSection(String title, List<Widget> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(title),
        ...options,
        const SizedBox(height: 20),
      ],
    );
  }

  // Build section title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: profileTitle,
      ),
    );
  }

  // Build list of options for 'Info Saya'
  List<Widget> _infoSayaOptions() {
    return [
      _buildOption(Icons.person, 'Info personal',
          () => controller.movePage('/info-personal')),
      _buildOption(Icons.work, 'Info pekerjaan',
          () => controller.movePage('/info-pekerjaan')),
      _buildOption(Icons.groups_2_outlined, 'Info keluarga',
          () => controller.movePage('/info-keluarga')),
      _buildOption(
          Icons.cast_for_education_outlined,
          'Info pendidikan & pengalaman',
          () => controller.movePage('/pendidikan-pengalaman')),
      _buildOption(Icons.payment, 'Info payroll',
          () => controller.movePage('/info-payroll')),
      _buildOption(Icons.more, 'Info tambahan',
          () => controller.movePage('/info-tambahan')),
    ];
  }

  // Build list of options for 'Support'
  List<Widget> _supportOptions() {
    return [
      _buildOption(Icons.bug_report_outlined, 'Laporan Bugs',
          () => controller.movePage('/info-report-bugs')),
    ];
  }

  // Build list of options for 'Pengaturan'
  List<Widget> _settingsOptions() {
    return [
      _buildOption(Icons.lock, 'Ubah kata sandi',
          () => controller.movePage('/ubah-password')),
      _buildOption(Icons.logout, 'Keluar', controller.logout),
    ];
  }

  // Build an option card with icon, text, and tap callback
  Widget _buildOption(IconData icon, String text, VoidCallback? onTap) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(text, style: listile),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

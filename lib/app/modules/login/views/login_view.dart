import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../../components/btn_action.dart';
import '../../../../components/widgets/snackbar.dart';
import '../../../../constant.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: bgColor, // Ubah background status bar
      statusBarIconBrightness: Brightness.dark, // Ubah warna icon status bar
    ));

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                SvgPicture.asset('assets/svg/logo.svg', height: 60, width: 60),
                const SizedBox(height: 50),
                const Text(
                  "Input akun anda untuk memulai.",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 15),

                // FormBuilder untuk menangani form
                FormBuilder(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      // Email/NIK Field
                      FormBuilderTextField(
                        name: 'emailOrNik',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: primaryColor.withOpacity(0.1),
                          filled: true,
                          labelText: 'Email/NIK',
                          prefixIcon: const Icon(Icons.person),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Email/NIK wajib diisi'),
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email/NIK tidak boleh kosong';
                            }
                            final isNik = RegExp(r'^\d+$').hasMatch(value);
                            final isEmail = FormBuilderValidators.email(
                              errorText: 'Format email tidak valid',
                            )(value);
                            if (!isNik && isEmail != null) {
                              return 'Masukkan NIK yang valid (hanya angka) atau email yang valid';
                            }
                            return null;
                          }
                        ]),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 15),
                      // Password Field
                      FormBuilderTextField(
                        name: 'password',
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: primaryColor.withOpacity(0.1),
                          filled: true,
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.password),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                              errorText: 'Password wajib diisi'),
                          FormBuilderValidators.minLength(6,
                              errorText: 'Password minimal 6 karakter'),
                        ]),
                      ),
                      const SizedBox(height: 15),

                      // Tombol Masuk
                      BtnAction(
                        act: () {
                          // Cek validasi form
                          if (controller.formKey.currentState
                                  ?.saveAndValidate() ??
                              false) {
                            final emailOrNik = controller.formKey.currentState
                                ?.fields['emailOrNik']?.value;
                            final password = controller.formKey.currentState
                                ?.fields['password']?.value;

                            if (emailOrNik != null && password != null) {
                              // Lakukan tindakan login dengan input yang valid
                              controller.login(emailOrNik, password);
                            }
                          } else {
                            // Tampilkan pesan error jika validasi gagal
                            showErrorSnackbar(
                                "Harap isi semua data dengan benar.");
                          }
                        },
                        color: primaryColor,
                        icon: Icons.login,
                        title: 'Masuk',
                        isLoading: controller.loading,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

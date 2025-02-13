import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.checkAuth();
    return Scaffold(
      backgroundColor: primaryColor, // Warna latar belakang
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            // Logo dalam lingkaran dengan radius fleksibel
            Image.asset(
              "assets/Logo1.png", // Path ke logo Anda
              fit: BoxFit.cover, // Mengisi lingkaran tanpa distorsi
              width: MediaQuery.of(context).size.width *
                  0.5, // Lebar gambar sesuai diameter lingkaran
              height: MediaQuery.of(context).size.width *
                  0.5, // Tinggi gambar sesuai diameter lingkaran
            ),
            const Spacer(),
            const Center(
                child: CircularProgressIndicator(
              color: bgColor,
            )), // Spasi antar elemen
            const Text(
              'Esas Application', // Teks judul aplikasi
              style: TextStyle(
                fontSize: 26, // Ukuran font lebih besar
                color: Colors.white, // Warna teks
                fontWeight: FontWeight.bold, // Gaya teks
                letterSpacing: 1.2, // Jarak antar huruf
              ),
              textAlign: TextAlign.center, // Pusatkan teks
            ),
            const Text(
              'Powered by PT. SINERGI ABADI SENTOSA', // Teks judul aplikasi
              style: TextStyle(
                fontSize: 12, // Ukuran font lebih besar
                color: Colors.white, // Warna teks
                fontWeight: FontWeight.bold, // Gaya teks
                letterSpacing: 1.2, // Jarak antar huruf
              ),
              textAlign: TextAlign.center, // Pusatkan teks
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

const baseUrlApi = 'https://esas.sinergiabadisentosa.com/api';
// const baseUrlApi = 'http://192.168.51.186:8000/api';
// const baseUrlApi = 'http://172.16.1.16:8000/api';

const primaryColor = Color(0xFF079246);
const secondaryColor = Color(0xFF92C13F);
const warningColor = Color(0xFFF6E005);
const dangerColor = Color(0xFFA02334);
const infoColor = Color(0xff073891);
const bgColor = Colors.white;

const defaultPadding = 16.0;

Future<bool?> showBackDialog() {
  return Get.dialog<bool>(
    AlertDialog(
      title: const Text('Apakah kamu yakin?'),
      content: const Text(
        'Apakah Anda yakin ingin meninggalkan halaman ini?',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: const Text(
            'Tidak, tetap disini.',
            style: TextStyle(color: dangerColor),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: const Text('Ya, Tinggalkan',
              style: TextStyle(color: primaryColor)),
        ),
      ],
    ),
  );
}

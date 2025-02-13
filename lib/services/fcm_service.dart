import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../app/networks/api/akun/api_auth.dart';
import '../constant.dart';

class FcmService extends GetxService {
  final String baseUrl = baseUrlApi;

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }

      // Get the device token
      String? token = await messaging.getToken();
      if (kDebugMode) {
        print("Device Token: $token");
      }

      if (token != null) {
        sendTokenToServer(token);
      }
    } else {
      if (kDebugMode) {
        print('User declined permission');
      }
    }
  }

  void sendTokenToServer(String token) async {
    final datapost = {"device_token": token};
    if (kDebugMode) {
      print("===================ini data post token fcm : $datapost");
    }
    final response = await ApiAuth().setDeviceToken(datapost);
    if (kDebugMode) {
      print("=========================set token: ${response.body}");
    }
  }
}

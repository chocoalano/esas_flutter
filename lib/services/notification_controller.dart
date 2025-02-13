// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import '../components/widgets/snackbar.dart';
import 'notif_service.dart';

class NotificationController extends GetxController {
  final NotifService notifService = Get.put(NotifService());
  late PusherChannelsFlutter pusher;
  final storage = GetStorage();
  final isConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    pusher = PusherChannelsFlutter.getInstance();
    connect();
  }

  Future<void> connect() async {
    try {
      await pusher.init(
        apiKey: '368533d9bcc67e881fff',
        cluster: 'ap1',
        onConnectionStateChange: (currentState, previousState) {
          if (kDebugMode) {
            print("Connection State: $currentState");
          }
          isConnected.value = currentState == 'CONNECTED';
        },
        onEvent: (event) {
          // print("Event Received: ${event.eventName} - ${event.data}");
          final fetch = jsonDecode(event.data);
          if (kDebugMode) {
            final userId = storage.read('userId');
            if (userId == fetch['to']) {
              notifService.showNotification('Pemberitahuan', fetch['message']);
            }
          }
        },
        onSubscriptionSucceeded: (channel, data) {
          if (kDebugMode) {
            print("Subscription Succeeded: $channel");
          }
        },
        onError: (message, code, e) {
          if (kDebugMode) {
            print("Error: $message (Code: $code)");
          }
        },
      );

      // Pastikan langganan berhasil
      final subscription =
          await pusher.subscribe(channelName: 'notification-channel');
      if (subscription == null) {
        throw Exception("Subscription failed. Channel not found.");
      }

      await pusher.connect();
    } catch (e) {
      if (kDebugMode) {
        print("Connection Error: $e");
      }

      // Tampilkan pesan error ke pengguna
      showErrorSnackbar(
          "Connection to Pusher failed. Please check your configuration.");
    }
  }
}

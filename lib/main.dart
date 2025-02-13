import 'package:firebase_core/firebase_core.dart'; // Import firebase_core
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'components/BottomNavigation/bot_nav_controller.dart';
import 'firebase_options.dart';
import 'services/notif_service.dart';
import 'services/notification_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _initializeServices();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    ),
  );
}

Future<void> _initializeServices() async {
  try {
    await GetStorage.init();
    Get.put(BotNavController(),
        permanent: true); // Initialize before NotifService

    final NotifService notificationService = Get.put(NotifService());
    await notificationService
        .initialize(); // Initialize after Firebase.initializeApp()

    Get.put(
        NotificationController()); // Initialize after Firebase.initializeApp() and NotifService

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
        print('User granted permission!');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission!');
      }
    } else {
      if (kDebugMode) {
        print('User declined or has not yet asked for permission.');
      }
    }

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      if (kDebugMode) {
        print("================token refreshed :: $fcmToken");
      }
    }).onError((err) {
      if (kDebugMode) {
        print("================err :: $err");
      }
    });

    // Background message handler (important!)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("================onMessage: ${message.data}");
        print("================onMessage: ${message.notification?.body}");
      }
      notificationService.showNotification(
          message.notification?.title ?? "New Notification",
          message.notification?.body ?? "You have a new message");

      // Handle the message here, e.g., show a notification, update UI, etc.
    });

    // Message opened app handler
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
        print("================onMessageOpenedApp: ${message.data}");
      }
      // Navigate to the appropriate screen based on the message data
    });
  } catch (e) {
    if (kDebugMode) {
      print("Error during initialization: $e");
    }
  }
}

// Top-level function for background message handling (must be outside any class)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase if not already initialized (important for background messages)
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print("================Background Message: ${message.data}");
    print("================Background Message: ${message.notification?.body}");
  }

  // You can show a notification here if needed, but be mindful of platform limitations for background processes.
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

bool isPermissionRequestInProgress = false;

Future<void> requestPermissionNotification() async {
  if (isPermissionRequestInProgress) return;
  try {
    isPermissionRequestInProgress = true;
    NotificationSettings settings =
        await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print("Notification permission: $settings");
  } catch (e) {
    print("Error requesting notification permission: $e");
  } finally {
    isPermissionRequestInProgress = false;
  }
}

void setupFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received message: ${message.notification?.title}");
    if (message.notification != null) {
      Get.snackbar(
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
      );
    }
  });

  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
}

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  print("Background message: ${message.notification?.title}");
}

Future<void> checkNotificationOnLaunch() async {
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
  if (initialMessage != null) {
    print(
        "App launched from notification: ${initialMessage.notification?.title}");
  }
}

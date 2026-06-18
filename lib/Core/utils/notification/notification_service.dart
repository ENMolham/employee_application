import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static const String _vapidKey =
      "BG_cDc2-CHPpUMRmSJIKx__uvjvrT3a8sPxv_sai0B1nE1JjL67WQlmTsS83uq-SWtc4yejqf8kfBPVIQzkSDGg";

  static Future<void> initialize() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('Permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      await _messaging.setForegroundNotificationPresentationOptions(
        alert: false,
        badge: false,
        sound: false,
      );

      await _getToken();
      _listenToForegroundMessages();
    }
  }

  static Future<String?> _getToken() async {
    try {
      final token = await _messaging.getToken(vapidKey: _vapidKey);
      debugPrint('FCM Token: $token');
      return token;
    } catch (e) {
      debugPrint('Error getting token: $e');
      return null;
    }
  }

  static void _listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground message: ${message.notification?.title}');
    });
  }

  static Future<String?> getToken() => _getToken();
}

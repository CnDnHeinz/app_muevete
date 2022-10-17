import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class NotificationsApi {
  static final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'muevete-channel',
        'comidas',
        channelDescription: 'Descripcion del canal',
        importance: Importance.max,
      ),
    );
  }

  static Future init({bool initSchedule = false}) async {
    const androidSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const settings = InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        onNotifications.add(details.payload);
      },
    );

    if (initSchedule) {
      tzData.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _localNotificationsPlugin.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required Time scheduleDate,
  }) async =>
      _localNotificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          _scheduleDaily(
              scheduleDate), //tz.TZDateTime.from(scheduleDate, tz.local),
          await _notificationDetails(),
          payload: payload,
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.time);

  static tz.TZDateTime _scheduleDaily(Time time) {
    tzData.initializeTimeZones();
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }
}

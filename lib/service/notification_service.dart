// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;

// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//   factory NotificationService() => _instance;
//   NotificationService._internal();

//   final FlutterLocalNotificationsPlugin _fln = FlutterLocalNotificationsPlugin();

//   Future<void> init() async {
//     tz.initializeTimeZones();
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     await _fln.initialize(const InitializationSettings(android: android));
//   }

//   Future<void> scheduleReminder({
//     required int id,
//     required String title,
//     required String body,
//     required DateTime appointmentDate,
//   }) async {
//     final tz.TZDateTime alertTime = tz.TZDateTime.from(appointmentDate, tz.local)
//         .subtract(const Duration(hours: 8));

//     await _fln.zonedSchedule(
//       id,
//       title,
//       body,
//       alertTime,
//       const NotificationDetails(
//         android: AndroidNotificationDetails('apt_channel', 'Appointments',
//             channelDescription: 'Appointment reminders',
//             importance: Importance.max,
//             priority: Priority.high),
//       ),
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
// }

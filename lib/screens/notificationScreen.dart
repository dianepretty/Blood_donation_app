import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import '../theme/theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Use a non-const list for flexibility (can later update or fetch from backend)
  final List<NotificationModel> reminders = [
    NotificationModel(
      title: 'Appointment reminder',
      time: '10:30 AM',
      details: 'Location: Community Center\nVolunteer: John Doe\nReminder: Bring ID.',
      date: DateTime.now(),
    ),
    NotificationModel(
      title: 'Appointment reminder',
      time: '2:00 PM',
      details: 'Location: Library\nVolunteer: Jane Smith\nNote: Bring documents.',
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final today = reminders.where((r) => _isToday(r.date)).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.red,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 100,
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Today',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          ...today.map((n) => _buildReminderTile(context, n)).toList(),
        ],
      ),
    );
  }

  Widget _buildReminderTile(BuildContext context, NotificationModel n) {
    return Column(
      children: [
        ListTile(
          title: Text(n.title),
          subtitle: Text(n.time),
          trailing: IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined),
            onPressed: () => _showDetailsDialog(context, n),
          ),
        ),
        const Divider(color: Colors.grey, height: 1),
      ],
    );
  }

  void _showDetailsDialog(BuildContext context, NotificationModel n) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.38, // more trimmed height
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: const Icon(Icons.close, size: 22),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  n.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      n.details,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

  );
  }



  bool _isToday(DateTime dt) {
    final now = DateTime.now();
    return dt.year == now.year && dt.month == now.month && dt.day == now.day;
  }
}

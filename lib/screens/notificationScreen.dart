import 'package:blood_system/widgets/main_navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/notification_model.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationModel> reminders = [];

  @override
  void initState() {
    super.initState();
    fetchReminders();
  }

  Future<void> fetchReminders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('userId', isEqualTo: user.uid)
        .get();

    setState(() {
      reminders = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return NotificationModel.fromFirestore(data);
      }).toList();

      // Add a sample card for demo purposes
      reminders.insert(
        0,
        NotificationModel(
          title: 'Sample Appointment Reminder',
          time: '10:00 AM',
          details: 'Location: Kigali Hospital\nReminder: Bring your ID and arrive 15 minutes early.',
          date: DateTime.now().add(Duration(days: 1)), // Tomorrow
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      backgroundColor: Colors.white,
      currentPage: '/notifications',
      pageTitle: 'Notifications',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'All Reminders',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          if (reminders.isEmpty)
            Center(child: Text('No reminders available.')),
          ...reminders.map((n) => _buildReminderTile(context, n)).toList(),
        ],
      ),
    );
  }

  Widget _buildReminderTile(BuildContext context, NotificationModel n) {
    final formattedDate = DateFormat.yMMMd().format(n.date);
    final formattedTime = n.time;

    return Column(
      children: [
        ListTile(
          title: Text(
            n.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(formattedDate, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(formattedTime, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.remove_red_eye_outlined, color: Colors.black),
            onPressed: () => _showDetailsDialog(context, n),
          ),
        ),
        const Divider(color: Colors.grey, height: 1),
      ],
    );
  }

  void _showDetailsDialog(BuildContext context, NotificationModel n) {
    final formattedDate = DateFormat.yMMMMEEEEd().format(n.date);
    final formattedTime = DateFormat.jm().format(n.date);

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.5,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8)),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => Navigator.of(ctx).pop(),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.red.shade100, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.close, size: 22, color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  n.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.redAccent),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            formattedDate,
                            style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.access_time, size: 18, color: Colors.grey),
                        const SizedBox(width: 6),
                        Text(
                          formattedTime,
                          style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        n.details,
                        style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('OK', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

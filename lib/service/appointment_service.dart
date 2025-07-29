// services/appointment_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment_model.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'appointments';

  // Book a new appointment
  Future<String> bookAppointment(Appointment appointment) async {
    try {
   

      final docRef = await _firestore
          .collection(_collectionName)
          .add(appointment.toJson());
      
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to book appointment: $e');
    }
  }

  // Get appointments by user ID
  Stream<List<Appointment>> getAppointmentByUser(String userId) {
    return _firestore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .orderBy('appointmentDate', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Appointment.fromJson({
                    ...(doc.data() != null && doc.data() is Map<String, dynamic> ? doc.data() as Map<String, dynamic> : {}),
                    'id': doc.id,
                  }))
              .toList(),
        );
  }
  // Get all appointments by hospital name with optional date filtering
  Stream<List<Appointment>> getAppointmentsByHospitalName(
    String hospitalName, {
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    Query query = _firestore
        .collection(_collectionName)
        .where('hospitalName', isEqualTo: hospitalName);

    // Add date filtering if provided
    if (fromDate != null) {
      // Set time to start of day
      final startOfDay = DateTime(fromDate.year, fromDate.month, fromDate.day);
      query = query.where('appointmentDate', 
          isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay));
    }

    if (toDate != null) {
      // Set time to end of day
      final endOfDay = DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59);
      query = query.where('appointmentDate', 
          isLessThanOrEqualTo: Timestamp.fromDate(endOfDay));
    }

    return query
        .orderBy('appointmentDate', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Appointment.fromJson({
                    ...(doc.data() != null && doc.data() is Map<String, dynamic> ? doc.data() as Map<String, dynamic> : {}),
                    'id': doc.id,
                  }))
              .toList(),
        );
  }


  // Get upcoming appointments for a user
  Stream<List<Appointment>> getUpcomingAppointments(String userId) {
    final now = DateTime.now();
    return _firestore
        .collection(_collectionName)
        .where('userId', isEqualTo: userId)
        .where('appointmentDate', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .orderBy('appointmentDate')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Appointment.fromJson({
                    ...doc.data(),
                    'id': doc.id,
                  }))
              .toList(),
        );
  }




  // Get appointment by ID
  Future<Appointment?> getAppointmentById(String appointmentId) async {
    try {
      final doc = await _firestore
          .collection(_collectionName)
          .doc(appointmentId)
          .get();
      
      if (doc.exists) {
        return Appointment.fromJson({
          ...doc.data()!,
          'id': doc.id,
        });
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch appointment: $e');
    }
  }

  // Update appointment status
  Future<void> updateAppointmentStatus(String appointmentId) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(appointmentId)
          .update({
      });
    } catch (e) {
      throw Exception('Failed to update appointment status: $e');
    }
  }



  // Check if user has existing appointment on the same date and time
  Future<bool> hasExistingAppointment({
    required String userId,
    required DateTime appointmentDate,
    required String appointmentTime,
  }) async {
    try {
      final startOfDay = DateTime(
        appointmentDate.year,
        appointmentDate.month,
        appointmentDate.day,
      );
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          .where('appointmentDate', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
          .where('appointmentDate', isLessThan: Timestamp.fromDate(endOfDay))
          .where('appointmentTime', isEqualTo: appointmentTime)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Failed to check existing appointment: $e');
    }
  }

  // Get available time slots for a specific date and hospital

Future<List<String>> getAvailableTimeSlots({
  required String hospitalName,
  required DateTime date,
}) async {
  try {
    // Convert date to timestamp for exact matching
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    // Query without ordering to avoid index requirement
    final querySnapshot = await _firestore
        .collection('appointments')
        .where('hospitalName', isEqualTo: hospitalName)
        .where('appointmentDate', isEqualTo: Timestamp.fromDate(dateOnly))
        .get();

    // Extract booked time slots
    final bookedSlots = querySnapshot.docs
        .map((doc) => doc.data()['appointmentTime'] as String)
        .toSet();

    // Define all possible time slots
    final allTimeSlots = [
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
      '11:00 AM',
      '11:30 AM',
      '02:00 PM',
      '02:30 PM',
      '03:00 PM',
      '03:30 PM',
      '04:00 PM',
      '04:30 PM',
    ];

    // Return available slots
    return allTimeSlots
        .where((slot) => !bookedSlots.contains(slot))
        .toList();
  } catch (e) {
    print('Error getting available time slots: $e');
    return [];
  }
}
  // Get all possible time slots
  List<String> _getAllTimeSlots() {
    return [
      '09:00 AM',
      '08:30 AM',
      '09:00 AM',
      '09:30 AM',
      '10:00 AM',
      '10:30 AM',
      '11:00 AM',
      '11:30 AM',
      '02:00 PM',
      '02:30 PM',
      '03:00 PM',
      '03:30 PM',
      '04:00 PM',
      '04:30 PM',
      '05:00 PM',
    ];
  }

  // Get appointment history for analytics
  Future<List<Appointment>> getAppointmentHistory(String userId) async {
    try {
      final snapshot = await _firestore
          .collection(_collectionName)
          .where('userId', isEqualTo: userId)
          // .orderBy('appointmentDate', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => Appointment.fromJson({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch appointment history: $e');
    }
  }
}
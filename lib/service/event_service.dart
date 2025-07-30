import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_model.dart';

class EventService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'events';

  // Get all events
  Stream<List<Event>> getAllEvents() {
    return _firestore
        .collection(_collection)
        .orderBy('date')
        .snapshots()
        .map((snapshot) => _mapSnapshotToEvents(snapshot));
  }

  // Get events by hospital ID (for hospital admins)
  Stream<List<Event>> getEventsByHospital(String hospitalId) {
    return _firestore
        .collection(_collection)
        .where('hospitalId', isEqualTo: hospitalId)
        .orderBy('date')
        .snapshots()
        .map((snapshot) => _mapSnapshotToEvents(snapshot));
  }

  // Get events within date range
  Stream<List<Event>> getEventsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _firestore
        .collection(_collection)
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .orderBy('date')
        .snapshots()
        .map((snapshot) => _mapSnapshotToEvents(snapshot));
  }

  // Get events by hospital and date range
  Stream<List<Event>> getEventsByHospitalAndDateRange(
    String hospitalId,
    DateTime startDate,
    DateTime endDate,
  ) {
    return _firestore
        .collection(_collection)
        .where('hospitalId', isEqualTo: hospitalId)
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThanOrEqualTo: endDate)
        .orderBy('date')
        .snapshots()
        .map((snapshot) => _mapSnapshotToEvents(snapshot));
  }

  // Create a new event
  Future<String> createEvent(Event event) async {
    try {
      final eventData = _eventToMap(event);
      final docRef = await _firestore.collection(_collection).add(eventData);
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  // Update an existing event
  Future<void> updateEvent(Event event) async {
    try {
      if (event.id.isEmpty) {
        throw Exception('Event ID is required for update');
      }
      final eventData = _eventToMap(event);
      await _firestore.collection(_collection).doc(event.id).update(eventData);
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  // Delete an event
  Future<void> deleteEvent(String eventId) async {
    try {
      if (eventId.isEmpty) {
        throw Exception('Event ID is required for deletion');
      }
      await _firestore.collection(_collection).doc(eventId).delete();
    } catch (e) {
      throw Exception('Failed to delete event: $e');
    }
  }

  // Get a single event by ID
  Future<Event?> getEventById(String eventId) async {
    try {
      if (eventId.isEmpty) {
        throw Exception('Event ID is required');
      }
      final doc = await _firestore.collection(_collection).doc(eventId).get();
      if (doc.exists) {
        return _mapDocumentToEvent(doc as QueryDocumentSnapshot<Object?>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get event: $e');
    }
  }

  // Helper method to map Firestore snapshot to list of events
  List<Event> _mapSnapshotToEvents(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => _mapDocumentToEvent(doc)).toList();
  }

  // Helper method to map Firestore document to Event model
  Event _mapDocumentToEvent(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Handle both Timestamp and DateTime formats for backward compatibility
    DateTime eventDate;
    if (data['date'] is Timestamp) {
      eventDate = (data['date'] as Timestamp).toDate();
    } else if (data['date'] is DateTime) {
      eventDate = data['date'] as DateTime;
    } else {
      // Fallback to current date if date is missing or invalid
      eventDate = DateTime.now();
    }

    return Event(
      id: doc.id,
      name: data['name'] ?? '',
      date: eventDate,
      timeFrom: data['timeFrom'] ?? '',
      timeTo: data['timeTo'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? 'upcoming',
      hospitalId: data['hospitalId'] ?? '',
      adminId: data['adminId'] ?? '',
    );
  }

  // Helper method to convert Event model to Firestore map
  Map<String, dynamic> _eventToMap(Event event) {
    return {
      'name': event.name,
      'date': Timestamp.fromDate(event.date),
      'timeFrom': event.timeFrom,
      'timeTo': event.timeTo,
      'location': event.location,
      'description': event.description,
      'status': event.status,
      'hospitalId': event.hospitalId,
      'adminId': event.adminId,
    };
  }
}

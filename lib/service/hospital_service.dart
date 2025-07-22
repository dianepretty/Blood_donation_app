import 'package:blood_system/models/hospital_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HospitalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'hospitals';

  // Get all hospitals
  Future<List<Hospital>> getAllHospitals() async {
    print('WE ARE HERE now ${_firestore.collection('hospitals').get()}');
    final snapshot = await _firestore.collection(_collectionName).get();
    return snapshot.docs
        .map((doc) => Hospital.fromJson({...doc.data()}))
        .toList();
  }

  // Get hospitals by district
  Future<List<Hospital>> getHospitalsByDistrict(String district) async {
    final snapshot =
        await _firestore
            .collection(_collectionName)
            .where('district', isEqualTo: district)
            .orderBy('name')
            .get();
    return snapshot.docs
        .map((doc) => Hospital.fromJson({...doc.data()}))
        .toList();
  }

  // Get single hospital by ID
  Future<Hospital?> getHospitalById(String id) async {
    final doc = await _firestore.collection(_collectionName).doc(id).get();
    if (doc.exists) {
      return Hospital.fromJson({...doc.data()!});
    }
    return null;
  }

  // Get single hospital by ID (Future version)
  Future<Hospital?> getHospitalByIdOnce(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (doc.exists) {
        return Hospital.fromJson({...doc.data()!, 'id': doc.id});
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch hospital: $e');
    }
  }

  // Add a hospital
  Future<String> addHospital(Hospital hospital) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add(hospital.toJson());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to add hospital: $e');
    }
  }

  // Update a hospital
  Future<void> updateHospital(String id, Hospital hospital) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(id)
          .update(hospital.toJson());
    } catch (e) {
      throw Exception('Failed to update hospital: $e');
    }
  }

  // Delete a hospital
  Future<void> deleteHospital(String id) async {
    try {
      await _firestore.collection(_collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete hospital: $e');
    }
  }

  // Get all unique districts
  Future<List<String>> getAllDistricts() async {
    try {
      final snapshot = await _firestore.collection(_collectionName).get();
      final districts =
          snapshot.docs
              .map((doc) => doc.data()['district'] as String)
              .toSet()
              .toList();
      districts.sort();
      return districts;
    } catch (e) {
      throw Exception('Failed to fetch districts: $e');
    }
  }

  // Batch add hospitals (for initial data setup)
  Future<void> batchAddHospitals(List<Hospital> hospitals) async {
    try {
      final batch = _firestore.batch();

      for (final hospital in hospitals) {
        final docRef = _firestore.collection(_collectionName).doc();
        batch.set(docRef, hospital.toJson());
      }

      await batch.commit();
    } catch (e) {
      throw Exception('Failed to batch add hospitals: $e');
    }
  }
}

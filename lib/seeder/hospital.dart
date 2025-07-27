import 'package:blood_system/models/hospital_model.dart';
import 'package:blood_system/service/hospital_service.dart';

class HospitalDataSeeder {
  static final HospitalService _hospitalService = HospitalService();

  static Future<void> addInitialHospitals() async {
    final hospitals = [
      Hospital(
        name: "CHUK",
        district: "Nyarugenge",
        imageUrl:
            "https://lh3.googleusercontent.com/gps-cs-s/AC9h4nqEPCM9TTJ_kPI7HdGccW7ClUVBLtBf-JdlzVT6gH9IW_-uHYmzswh762eighT-dfuzFN6htf5mt1e0u2bm0jjATlaaeoOQbPwwWoBt2MEc6Nbuf0iXthSGBfM1KBmpUYrC2ENK=s1360-w1360-h1020-rw",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Hospital(
        name: "KACYIRU HOSPITAL",
        district: "Gasabo",
        imageUrl:
            "https://police.gov.rw/fileadmin/_processed_/f/b/csm__DSC0927_30226c8876.jpg",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Hospital(
        name: "MUHIMA HOSPITAL",
        district: "Nyarugenge",
        imageUrl:
            "https://pbs.twimg.com/media/GtJuHwSWoAACDC4?format=jpg&name=4096x4096",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Hospital(
        name: "KIBAGABAGA HOSPITAL",
        district: "Gasabo",
        imageUrl:
            "https://mercy4ubuzima.wordpress.com/wp-content/uploads/2013/07/kibaga-waiting.jpg",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Hospital(
        name: "KING FAISAL HOSPITAL",
        district: "Gasabo",
        imageUrl:
            "https://www.africaceovoices.com/wp-content/uploads/2021/05/p4_1600x900.jpg",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Hospital(
        name: "NDERA HOSPITAL",
        district: "Gasabo",
        imageUrl:
            "https://www.nderahospital.rw/index.php?eID=dumpFile&t=f&f=34166&token=2bd53fdc33385df69091814bcfc635c2b84e10d3",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      Hospital(
        name: "MASAKA HOSPITAL",
        district: "Kicukiro",
        imageUrl:
            "https://www.newtimes.co.rw/uploads/imported_images/files/main/articles/2018/07/23/masaka_0.jpg",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    try {
      await _hospitalService.batchAddHospitals(hospitals);
      print('Successfully added ${hospitals.length} hospitals to Firestore!');
    } catch (e) {
      print('Error adding hospitals: $e');
    }
  }

  // Alternative method: Add hospitals one by one
  static Future<void> addHospitalsOneByOne() async {
    final hospitalData = [
      {
        'name': 'CHUK',
        'district': 'Nyarugenge',
        'imageUrl':
            'https://lh3.googleusercontent.com/gps-cs-s/AC9h4nqEPCM9TTJ_kPI7HdGccW7ClUVBLtBf-JdlzVT6gH9IW_-uHYmzswh762eighT-dfuzFN6htf5mt1e0u2bm0jjATlaaeoOQbPwwWoBt2MEc6Nbuf0iXthSGBfM1KBmpUYrC2ENK=s1360-w1360-h1020-rw',
      },
      {
        'name': 'KACYIRU HOSPITAL',
        'district': 'Gasabo',
        'imageUrl':
            'https://police.gov.rw/fileadmin/_processed_/f/b/csm__DSC0927_30226c8876.jpg',
      },
      {
        'name': 'MUHIMA HOSPITAL',
        'district': 'Nyarugenge',
        'imageUrl':
            'https://pbs.twimg.com/media/GtJuHwSWoAACDC4?format=jpg&name=4096x4096',
      },
      {
        'name': 'KIBAGABAGA HOSPITAL',
        'district': 'Gasabo',
        'imageUrl':
            'https://mercy4ubuzima.wordpress.com/wp-content/uploads/2013/07/kibaga-waiting.jpg',
      },
      {
        'name': 'KING FAISAL HOSPITAL',
        'district': 'Gasabo',
        'imageUrl':
            'https://www.africaceovoices.com/wp-content/uploads/2021/05/p4_1600x900.jpg',
      },
      {
        'name': 'NDERA HOSPITAL',
        'district': 'Gasabo',
        'imageUrl':
            'https://www.nderahospital.rw/index.php?eID=dumpFile&t=f&f=34166&token=2bd53fdc33385df69091814bcfc635c2b84e10d3',
      },
      {
        'name': 'MASAKA HOSPITAL',
        'district': 'Kicukiro',
        'imageUrl':
            'https://www.newtimes.co.rw/uploads/imported_images/files/main/articles/2018/07/23/masaka_0.jpg',
      },
    ];

    try {
      for (final data in hospitalData) {
        final hospital = Hospital(
          name: data['name']!,
          district: data['district']!,
          imageUrl: data['imageUrl']!,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final id = await _hospitalService.addHospital(hospital);
        print('Added ${data['name']} with ID: $id');
      }
      print('All hospitals added successfully!');
    } catch (e) {
      print('Error adding hospitals: $e');
    }
  }
}

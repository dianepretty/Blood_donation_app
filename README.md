# Blood Donation System

A comprehensive Flutter mobile application designed to facilitate blood donation management, connecting donors, recipients, and healthcare facilities. The app streamlines the blood donation process by providing appointment booking, event management, and real-time communication between all stakeholders.

## 🌟 Features

### For Donors & Recipients
- **User Registration & Authentication**: Secure sign-up and login with email verification
- **Profile Management**: Complete user profiles with blood type, contact information, and medical details
- **Appointment Booking**: Schedule blood donation appointments at nearby hospitals
- **Appointment Management**: View, reschedule, and cancel appointments
- **Event Participation**: Discover and join blood donation events
- **Real-time Notifications**: Stay updated with appointment reminders and event notifications
- **Multi-language Support**: Available in English, French, and Kinyarwanda

### For Hospital Administrators
- **Hospital Registration**: Register healthcare facilities in the system
- **Appointment Management**: View and manage all appointments for their facility
- **Event Creation**: Organize blood donation drives and events
- **Donor Database**: Access donor information and blood type records
- **Status Updates**: Update appointment and event statuses

### Core Functionality
- **Role-based Access**: Different interfaces for donors, recipients, and hospital administrators
- **Real-time Data**: Firebase-powered real-time updates and synchronization
- **Push Notifications**: Firebase Cloud Messaging for instant notifications
- **Offline Support**: Local data caching for better user experience
- **Responsive Design**: Optimized for various screen sizes and orientations

## 🛠️ Technology Stack

- **Framework**: Flutter 3.7.2+
- **State Management**: Flutter Bloc (BLoC pattern)
- **Backend**: Firebase
  - Authentication
  - Cloud Firestore (Database)
  - Cloud Storage
  - Cloud Messaging
- **Localization**: Flutter Localizations
- **UI Components**: Material Design 3
- **Date/Time**: Syncfusion DatePicker, Intl
- **Authentication**: Google Sign-In integration

## 📱 Screenshots

The app features a modern, intuitive interface with:
- Clean landing page with blood donation illustration
- Role-based registration and login screens
- Dashboard with quick access to main features
- Appointment booking with date/time selection
- Event discovery and management
- Profile management with user details
- Multi-language support interface

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup
- Google Services configuration

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Blood_donation_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Enable Authentication, Firestore, Storage, and Cloud Messaging
   - Download `google-services.json` for Android
   - Configure iOS Firebase settings
   - Update `firebase_options.dart` with your project configuration

4. **Run the application**
   ```bash
   flutter run
   ```

### Build Configuration

#### Android
- Minimum SDK: API 21 (Android 5.0)
- Target SDK: API 33+
- Supports both debug and release builds

#### iOS
- Minimum iOS version: 12.0
- Supports iPhone and iPad
- Requires Apple Developer account for distribution

## 📁 Project Structure

```
lib/
├── blocs/                 # State management (BLoC pattern)
│   ├── appointment/       # Appointment-related state management
│   ├── auth/             # Authentication state management
│   ├── event/            # Event management state
│   ├── hospital/         # Hospital-related state
│   └── language/         # Language selection state
├── models/               # Data models
│   ├── appointment_model.dart
│   ├── event_model.dart
│   ├── hospital_model.dart
│   ├── notification_model.dart
│   └── user_model.dart
├── screens/              # UI screens
│   ├── appointments/     # Appointment-related screens
│   ├── events/          # Event management screens
│   └── ...              # Other screens
├── service/              # Business logic and API calls
├── theme/                # App theming and colors
├── utils/                # Utility functions and helpers
├── widgets/              # Reusable UI components
└── l10n/                 # Localization files
```

## 🔧 Configuration

### Environment Variables
- Firebase configuration is handled through `firebase_options.dart`
- No additional environment variables required

### Localization
The app supports three languages:
- English (en)
- French (fr)
- Kinyarwanda (rw)

Localization files are located in `lib/l10n/` directory.

## 🧪 Testing

Run tests using:
```bash
flutter test
```

The project includes unit tests for:
- Widget testing
- BLoC testing
- Service layer testing

## 📦 Building for Production

### Android APK
```bash
flutter build apk --release
```

### Android App Bundle
```bash
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- The blood donation community for inspiration
- All contributors and testers

## 📞 Support

For support and questions:
- Create an issue in the repository
- Contact the development team
- Check the FAQ section in the app

---

**Give the Gift of Life** - Your blood donation can save lives. Join us in making a difference.

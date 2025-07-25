import 'package:blood_system/screens/hospitalAdminRegister.dart';
import 'package:blood_system/screens/login.dart';
import 'package:blood_system/screens/volunteerRegister.dart';
import 'package:blood_system/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Prefix dart:ui with 'ui'

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

String? selectedRole;

Widget buildDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Select Your Role'),
    backgroundColor: Colors.white,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Please choose your role:'),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          hint: const Text('Select a role'),
          isExpanded: true,
          decoration: const InputDecoration(
            // remove the border
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            fillColor: Color(0xFFF8F9FA),
            filled: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items:
              ["Hospital admin", "Volunteer"].map((String role) {
                return DropdownMenuItem<String>(value: role, child: Text(role));
              }).toList(),
          onChanged: (String? newValue) {
            selectedRole = newValue;
          },
        ),
      ],
    ),
    actions: [
      Center(
        child: ElevatedButton(
          onPressed:
              selectedRole == "Hospital admin"
                  ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HospitalAdminRegister(),
                      ),
                    );
                  }
                  : selectedRole == "Volunteer"
                  ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VolunteerRegister(),
                      ),
                    );
                  }
                  : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.red,
            foregroundColor: Colors.white,
          ),
          child: const Text('Continue'),
        ),
      ),
    ],
  );
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Image.asset("assets/images/Blood_illustration.png"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Give the Gift of Life",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                    child: Text(
                      "Your blood donation can save lives. Join us in making a difference.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),

                  SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => buildDialog(context),
                      );
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      elevation: 0.2,
                      minimumSize: ui.Size(358, 60),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      // print("Register button pressed!");
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF8F9FA),
                      minimumSize: ui.Size(358, 60),
                      foregroundColor: AppColors.black,
                      elevation: 0.2,
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

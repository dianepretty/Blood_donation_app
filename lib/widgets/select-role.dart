import 'package:blood_system/theme/theme.dart';
import 'package:flutter/material.dart';

class RoleSelectionDialog extends StatefulWidget {
  const RoleSelectionDialog({super.key});

  @override
  State<RoleSelectionDialog> createState() => _RoleSelectionDialogState();
}

class _RoleSelectionDialogState extends State<RoleSelectionDialog> {
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
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
            value: selectedRole,
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
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedRole = newValue;
              });
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
                      Navigator.pushNamed(context, '/hospitalAdminRegister');
                    }
                    : selectedRole == "Volunteer"
                    ? () {
                      Navigator.pushNamed(context, '/volunteerRegister');
                    }
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  selectedRole != null
                      ? AppColors.red
                      : Colors.grey, // Visual feedback for disabled state
              foregroundColor: Colors.white,
            ),
            child: const Text('Continue'),
          ),
        ),
      ],
    );
  }
}

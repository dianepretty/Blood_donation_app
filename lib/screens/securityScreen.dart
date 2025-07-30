import 'package:blood_system/widgets/main_navigation.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  bool isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      backgroundColor: Colors.white,
      currentPage: '/security',
      pageTitle: 'Settings',
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          const SectionTitle(title: 'Security'),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Change password'),
            subtitle: const Text(
              'Last changed 3 days ago',
              style: TextStyle(color: Colors.blueGrey),
            ),
            // trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            // onTap: () {
            //   Navigator.pushNamed(context, '/changePassword');
            // },
          ),
          const SizedBox(height: 24),
          // const SectionTitle(title: 'Two‑factor authentication'),
          // ListTile(
          //   contentPadding: EdgeInsets.zero,
          //   title: const Text('Two‑factor authentication'),
          //   subtitle: const Text(
          //     'Recommended',
          //     style: TextStyle(color: Colors.blueGrey),
          //   ),
          //   trailing: Switch(
          //     value: isTwoFactorEnabled,
          //     onChanged: (value) {
          //       setState(() {
          //         isTwoFactorEnabled = value;
          //       });
          //     },
          //   ),
          // ),
          _buildSection('App Information', [
            _buildInfoTile('App Version', '1.0.0'),
            _buildInfoTile('Last Updated', '2025'),
          ]),
          const SizedBox(height: 24),
          const SectionTitle(title: 'Other'),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Privacy policy'),
            subtitle: const Text(
              'Learn how we handle your data.',
              style: TextStyle(color: Colors.blueGrey),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: const Text('Terms of service'),
            subtitle: const Text(
              'Review our service agreement.',
              style: TextStyle(color: Colors.blueGrey),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

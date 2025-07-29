import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/bloc.dart';
import '../blocs/auth/state.dart';
import '../widgets/main_navigation.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainNavigationWrapper(
      currentPage: 'profile',
      pageTitle: 'Profile',
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            final user = state.userData;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: const Color(0xFFB83A3A),
                          child: Text(
                            user?.fullName?.substring(0, 1).toUpperCase() ??
                                'U',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user?.fullName ?? 'User Name',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user?.email ?? 'user@example.com',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFB83A3A).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            user?.role ?? 'Volunteer',
                            style: const TextStyle(
                              color: Color(0xFFB83A3A),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Profile Information
                  _buildSection('Personal Information', [
                    _buildInfoTile(
                      'Full Name',
                      user?.fullName ?? 'Not provided',
                    ),
                    _buildInfoTile('Email', user?.email ?? 'Not provided'),
                    _buildInfoTile(
                      'Phone Number',
                      user?.phoneNumber ?? 'Not provided',
                    ),
                    _buildInfoTile('Gender', user?.gender ?? 'Not provided'),
                    _buildInfoTile(
                      'Blood Type',
                      user?.bloodType ?? 'Not provided',
                    ),
                    _buildInfoTile(
                      'District',
                      user?.districtName ?? 'Not provided',
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // Quick Actions
                  _buildSection('Quick Actions', [
                    _buildActionTile('Edit Profile', Icons.edit, () {
                      // Navigate to edit profile
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Edit profile feature coming soon!'),
                          backgroundColor: Color(0xFFB83A3A),
                        ),
                      );
                    }),
                    _buildActionTile('Change Password', Icons.lock, () {
                      // Navigate to change password
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Change password feature coming soon!'),
                          backgroundColor: Color(0xFFB83A3A),
                        ),
                      );
                    }),
                    _buildActionTile('Privacy Settings', Icons.privacy_tip, () {
                      // Navigate to privacy settings
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Privacy settings feature coming soon!',
                          ),
                          backgroundColor: Color(0xFFB83A3A),
                        ),
                      );
                    }),
                  ]),

                  const SizedBox(height: 24),

                  // App Information
                  _buildSection('App Information', [
                    _buildInfoTile('App Version', '1.0.0'),
                    _buildInfoTile('Last Updated', '2024'),
                    _buildInfoTile('Terms of Service', 'View'),
                    _buildInfoTile('Privacy Policy', 'View'),
                  ]),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFB83A3A)),
            );
          }
        },
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

  Widget _buildActionTile(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
        leading: Icon(icon, color: const Color(0xFFB83A3A), size: 24),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF333333),
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFFB83A3A),
          size: 16,
        ),
        onTap: onTap,
        );
    }
}
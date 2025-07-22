import 'package:blood_system/blocs/auth/bloc.dart';
import 'package:blood_system/blocs/auth/event.dart';
import 'package:blood_system/blocs/auth/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsPage extends StatelessWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood System Home'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  Navigator.pushNamed(context, '/profile');
                  break;
                case 'logout':
                  _showLogoutDialog(context);
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => [
                  const PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 8),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AuthAuthenticated) {
            final user = state.firebaseUser;
            final userData = state.userData;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    userData?.imageUrl.isNotEmpty == true
                                        ? NetworkImage(userData!.imageUrl)
                                        : null,
                                backgroundColor: Colors.red.withOpacity(0.1),
                                child:
                                    userData?.imageUrl.isEmpty == true ||
                                            userData?.imageUrl == null
                                        ? const Icon(
                                          Icons.person,
                                          size: 30,
                                          color: Colors.red,
                                        )
                                        : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome back!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.grey[600]),
                                    ),
                                    Text(
                                      userData?.fullName ??
                                          user.displayName ??
                                          'User',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // User Information Card
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User Information',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),

                          // User ID (Document ID)
                          _buildInfoRow(
                            icon: Icons.fingerprint,
                            label: 'User ID',
                            value: user.uid,
                          ),
                          const SizedBox(height: 12),

                          // Full Name
                          if (userData?.fullName != null)
                            _buildInfoRow(
                              icon: Icons.person,
                              label: 'Full Name',
                              value: userData!.fullName,
                            ),
                          const SizedBox(height: 12),

                          // Email
                          _buildInfoRow(
                            icon: Icons.email,
                            label: 'Email',
                            value: user.email ?? 'No email',
                          ),
                          const SizedBox(height: 12),

                          // Role
                          if (userData?.role != null)
                            _buildInfoRow(
                              icon: Icons.work,
                              label: 'Role',
                              value: userData!.role,
                              valueColor: _getRoleColor(userData!.role),
                            ),
                          const SizedBox(height: 12),

                          // Blood Type
                          if (userData?.bloodType != null)
                            _buildInfoRow(
                              icon: Icons.bloodtype,
                              label: 'Blood Type',
                              value: userData!.bloodType,
                              valueColor: Colors.red,
                            ),
                          const SizedBox(height: 12),

                          // District
                          if (userData?.districtName != null)
                            _buildInfoRow(
                              icon: Icons.location_on,
                              label: 'District',
                              value: userData!.districtName,
                            ),
                          const SizedBox(height: 12),

                          // Phone Number
                          if (userData?.phoneNumber != null)
                            _buildInfoRow(
                              icon: Icons.phone,
                              label: 'Phone',
                              value: userData!.phoneNumber,
                            ),
                          const SizedBox(height: 12),

                          // Gender
                          if (userData?.gender != null)
                            _buildInfoRow(
                              icon:
                                  userData!.gender.toLowerCase() == 'male'
                                      ? Icons.male
                                      : Icons.female,
                              label: 'Gender',
                              value: userData!.gender,
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Quick Actions
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Action Buttons based on role
                  _buildQuickActions(context, userData?.role),
                ],
              ),
            );
          }

          // If not authenticated, show login prompt
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Please log in to continue',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return Colors.purple;
      case 'doctor':
        return Colors.blue;
      case 'donor':
        return Colors.green;
      case 'recipient':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildQuickActions(BuildContext context, String? role) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: _getActionButtons(context, role),
    );
  }

  List<Widget> _getActionButtons(BuildContext context, String? role) {
    List<Widget> buttons = [
      _buildActionButton(
        context,
        icon: Icons.edit,
        label: 'Edit Profile',
        onTap: () => Navigator.pushNamed(context, '/edit-profile'),
      ),
      _buildActionButton(
        context,
        icon: Icons.history,
        label: 'History',
        onTap: () => Navigator.pushNamed(context, '/history'),
      ),
    ];

    // Add role-specific buttons
    switch (role?.toLowerCase()) {
      case 'donor':
        buttons.addAll([
          _buildActionButton(
            context,
            icon: Icons.favorite,
            label: 'Donate Blood',
            onTap: () => Navigator.pushNamed(context, '/donate'),
          ),
          _buildActionButton(
            context,
            icon: Icons.schedule,
            label: 'Appointments',
            onTap: () => Navigator.pushNamed(context, '/appointments'),
          ),
        ]);
        break;
      case 'recipient':
        buttons.addAll([
          _buildActionButton(
            context,
            icon: Icons.search,
            label: 'Find Donors',
            onTap: () => Navigator.pushNamed(context, '/find-donors'),
          ),
          _buildActionButton(
            context,
            icon: Icons.request_page,
            label: 'Blood Request',
            onTap: () => Navigator.pushNamed(context, '/request-blood'),
          ),
        ]);
        break;
      case 'admin':
        buttons.addAll([
          _buildActionButton(
            context,
            icon: Icons.dashboard,
            label: 'Dashboard',
            onTap: () => Navigator.pushNamed(context, '/admin-dashboard'),
          ),
          _buildActionButton(
            context,
            icon: Icons.people,
            label: 'Manage Users',
            onTap: () => Navigator.pushNamed(context, '/manage-users'),
          ),
        ]);
        break;
    }

    return buttons;
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: Colors.red),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(AuthSignOutRequested());
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}

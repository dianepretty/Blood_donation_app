import 'package:blood_system/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/bloc.dart';
import '../blocs/auth/event.dart';

class CustomDrawer extends StatelessWidget {
  final String currentPage;
  final String? userName;
  final String? userEmail;
  final String? userRole;

  final VoidCallback? onNavigateToFAQ;

  const CustomDrawer({
    super.key,
    required this.currentPage,
    this.userName,
    this.userEmail,
    this.userRole,
    this.onNavigateToFAQ, // <-- Add the new param here
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildNavigationItems(context)),
            _buildLogoutSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Image.asset(
              'assets/images/header_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: const Color(0xFFD7263D).withOpacity(0.7),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userName ?? 'User Name',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail ?? 'user@example.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    userRole ?? 'Volunteer',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItems(BuildContext context) {
    final role = userRole?.toUpperCase() ?? 'VOLUNTEER';

    List<Map<String, dynamic>> navigationItems = [];

    if (role == 'HOSPITAL_ADMIN' || role == 'HOSPITAL ADMIN') {
      navigationItems = [
        {
          'title': 'Events',
          'icon': Icons.event,
          'route': '/events',
          'page': 'events',
        },
        {
          'title': 'Appointments',
          'icon': Icons.calendar_today,
          'route': '/appointments',
          'page': 'appointments',
        },
        {
          'title': 'Profile',
          'icon': Icons.person,
          'route': '/profile',
          'page': 'profile',
        },
        {
          'title': 'Settings',
          'icon': Icons.settings,
          'route': '/settings',
          'page': 'settings',
        },
        {
          'title': 'Help & Support',
          'icon': Icons.help_outline,
          'route': '/faq',
          'page': 'help',
        },
      ];
    } else {
      navigationItems = [
        {
          'title': 'Home',
          'icon': Icons.home,
          'route': '/events',
          'page': 'home',
        },
        {
          'title': 'Appointments',
          'icon': Icons.calendar_today,
          'route': '/appointments',
          'page': 'appointments',
        },
        {
          'title': 'Events',
          'icon': Icons.event,
          'route': '/events',
          'page': 'events',
        },
        {
          'title': 'Profile',
          'icon': Icons.person,
          'route': '/profile',
          'page': 'profile',
        },
        {
          'title': 'Donation History',
          'icon': Icons.history,
          'route': '/history',
          'page': 'history',
        },
        {
          'title': 'Settings',
          'icon': Icons.settings,
          'route': '/settings',
          'page': 'settings',
        },
        {
          'title': 'Help & Support',
          'icon': Icons.help_outline,
          'route': '/faq',
          'page': 'help',
        },
      ];
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: navigationItems.length,
      itemBuilder: (context, index) {
        final item = navigationItems[index];
        final isSelected = currentPage.toLowerCase() == item['page'];

        if (item['page'] == 'help') {
          return _buildHelpNavigationItem(
            context,
            title: item['title'] as String,
            icon: item['icon'] as IconData,
            route: item['route'] as String,
            isSelected: isSelected,
          );
        }

        return _buildNavigationItem(
          context,
          title: item['title'] as String,
          icon: item['icon'] as IconData,
          route: item['route'] as String,
          isSelected: isSelected,
        );
      },
    );
  }

  Widget _buildHelpNavigationItem(
      BuildContext context, {
        required String title,
        required IconData icon,
        required String route,
        required bool isSelected,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFB83A3A).withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFFB83A3A) : Colors.grey[600],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFB83A3A) : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: isSelected
            ? Container(
          width: 4,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFB83A3A),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2),
              bottomLeft: Radius.circular(2),
            ),
          ),
        )
            : null,
        onTap: () {
          Navigator.pop(context); // Close drawer first

          if (onNavigateToFAQ != null) {
            onNavigateToFAQ!(); // call callback if provided
          } else {
            // fallback navigation
            if (route != '/home') {
              Navigator.pushNamed(context, route);
            }
          }
        },
      ),
    );
  }

  Widget _buildNavigationItem(
      BuildContext context, {
        required String title,
        required IconData icon,
        required String route,
        required bool isSelected,
      }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFB83A3A).withOpacity(0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? const Color(0xFFB83A3A) : Colors.grey[600],
          size: 24,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFB83A3A) : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 16,
          ),
        ),
        trailing: isSelected
            ? Container(
          width: 4,
          height: 24,
          decoration: const BoxDecoration(
            color: Color(0xFFB83A3A),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2),
              bottomLeft: Radius.circular(2),
            ),
          ),
        )
            : null,
        onTap: () {
          Navigator.pop(context); // Close drawer
          Navigator.pushNamed(context, route); // Always navigate
        },
      ),
    );
  }


  Widget _buildLogoutSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: () {
                Navigator.pop(context); // Close drawer
                _showLogoutDialog(context);
              },
              icon: const Icon(Icons.logout, color: AppColors.red),
              label: const Text(
                'Logout',
                style: TextStyle(
                  color: AppColors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout, color: Color(0xFFB83A3A), size: 24),
              SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to logout?',
            style: TextStyle(color: Color(0xFF666666), fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(AuthSignOutRequested());
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/landing', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB83A3A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final double headerHeight = screenSize.height * 0.35;
    final bool isSmallScreen = screenSize.width < 400;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          // Header Section
          _buildHeader(context, headerHeight, isSmallScreen),

          // Content Section
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 16.0 : 24.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSection(
                      title: 'Hospital Admin',
                      actions: [
                        _ActionItem(
                          icon: Icons.add,
                          label: 'Add Event',
                          backgroundColor: Colors.grey[100]!,
                        ),
                        _ActionItem(
                          icon: Icons.check,
                          label: 'Approve Appointments',
                          backgroundColor: Colors.grey[100]!,
                        ),
                      ],
                      isSmallScreen: isSmallScreen,
                    ),

                    SizedBox(height: 32),

                    _buildSection(
                      title: 'Account',
                      actions: [
                        _ActionItem(
                          icon: Icons.person_outline,
                          label: 'Manage Profile',
                          backgroundColor: Colors.grey[100]!,
                        ),
                        _ActionItem(
                          icon: Icons.notifications_outlined,
                          label: 'Notifications',
                          backgroundColor: Colors.grey[100]!,
                        ),
                        _ActionItem(
                          icon: Icons.security_outlined,
                          label: 'Security',
                          backgroundColor: Colors.grey[100]!,
                        ),
                        _ActionItem(
                          icon: Icons.help_outline,
                          label: 'Help',
                          backgroundColor: Colors.grey[100]!,
                        ),
                      ],
                      isSmallScreen: isSmallScreen,
                    ),

                    SizedBox(height: 100), // Space for bottom navigation
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    double headerHeight,
    bool isSmallScreen,
  ) {
    return Container(
      width: double.infinity,
      height: headerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: Image.asset(
              'assets/images/header_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          // Semi-transparent red overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: Color(0xFFD7263D).withOpacity(0.4),
            ),
          ),
          // Notification icon
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          // Profile content
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: isSmallScreen ? 40 : 48,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/women/44.jpg',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Jone Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: isSmallScreen ? 20 : 24,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Johndoe@gmail.com',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isSmallScreen ? 14 : 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Joined 2023',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: isSmallScreen ? 12 : 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<_ActionItem> actions,
    required bool isSmallScreen,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isSmallScreen ? 20 : 24,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 16),
        ...actions.map(
          (action) => Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: _buildActionItem(action, isSmallScreen),
          ),
        ),
      ],
    );
  }

  Widget _buildActionItem(_ActionItem item, bool isSmallScreen) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: item.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(12),
            child: Icon(
              item.icon,
              color: Colors.grey[700],
              size: isSmallScreen ? 20 : 24,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              item.label,
              style: TextStyle(
                fontSize: isSmallScreen ? 16 : 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey[400],
            size: isSmallScreen ? 20 : 24,
          ),
        ],
      ),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  final Color backgroundColor;

  _ActionItem({
    required this.icon,
    required this.label,
    required this.backgroundColor,
  });
}

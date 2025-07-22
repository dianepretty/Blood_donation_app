import 'package:flutter/material.dart';

// Custom Bottom Navigation Component
class CustomBottomNavigation extends StatelessWidget {
  final String currentPage;
  final Function(int) onTap;

  const CustomBottomNavigation({
    Key? key,
    required this.currentPage,
    required this.onTap,
  }) : super(key: key);

  int _getCurrentIndex() {
    switch (currentPage.toLowerCase()) {
      case 'home':
        return 0;
      case 'history':
        return 1;
      case 'profile':
        return 2;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFB83A3A),
        unselectedItemColor: Colors.grey,
        currentIndex: _getCurrentIndex(),
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
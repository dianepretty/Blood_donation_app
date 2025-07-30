import 'package:flutter/material.dart';

// Custom Bottom Navigation Component
class CustomBottomNavigation extends StatelessWidget {
  final String currentPage;
  final Function(int) onTap;
  final String userRole;

  const CustomBottomNavigation({
    super.key,
    required this.currentPage,
    required this.onTap,
    required this.userRole,
    required SingleChildScrollView child,
  });

  int _getCurrentIndex() {
    final role = userRole.toUpperCase();

    if (role == 'HOSPITAL_ADMIN' || role == 'HOSPITAL ADMIN') {
      switch (currentPage.toLowerCase()) {
        case 'events':
          return 0;
        case 'appointments':
          return 1;
        case 'profile':
          return 2;
        default:
          return 0;
      }
    } else {
      // VOLUNTEER or default
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
  }

  List<BottomNavigationBarItem> _getNavigationItems() {
    final role = userRole.toUpperCase();

    if (role == 'HOSPITAL_ADMIN' || role == 'HOSPITAL ADMIN') {
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Events'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Appointments',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ];
    } else {
      // VOLUNTEER or default
      return const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check if MaterialLocalizations are available
    final materialLocalizations = MaterialLocalizations.of(context);
    if (materialLocalizations == null) {
      // Fallback to a simple container if MaterialLocalizations are not available
      return Container(
        height: 60,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _getNavigationItems().map((item) {
            final isSelected = _getCurrentIndex() == _getNavigationItems().indexOf(item);
            return Expanded(
              child: GestureDetector(
                onTap: () => onTap(_getNavigationItems().indexOf(item)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        (item.icon as Icon).icon,
                        color: isSelected ? const Color(0xFFB83A3A) : Colors.grey,
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.label ?? '',
                        style: TextStyle(
                          color: isSelected ? const Color(0xFFB83A3A) : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

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
        items: _getNavigationItems(),
      ),
    );
  }
}

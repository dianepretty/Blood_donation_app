import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/bloc.dart';
import '../blocs/auth/state.dart';
import 'app_bar.dart';
import 'drawer_navigation.dart';
import 'bottom_navigation.dart';

class MainNavigationWrapper extends StatefulWidget {
  final Widget child;
  final String currentPage;
  final String pageTitle;

  const MainNavigationWrapper({
    super.key,
    required this.child,
    required this.currentPage,
    required this.pageTitle,
  });

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        String? userName;
        String? userEmail;
        String? userRole;

        if (authState is AuthAuthenticated) {
          userName = authState.userData?.fullName;
          userEmail = authState.userData?.email;
          userRole = authState.userData?.role;
        }

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFFF5F5F5),
          drawer: CustomDrawer(
            currentPage: widget.currentPage,
            userName: userName,
            userEmail: userEmail,
            userRole: userRole,
          ),
          body: Column(
            children: [
              // Custom App Bar
              CustomAppBar(
                pageName: widget.pageTitle,
                scaffoldKey: _scaffoldKey,
                onNotificationPressed: () {
                  // Handle notification press
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications coming soon!'),
                      backgroundColor: Color(0xFFB83A3A),
                    ),
                  );
                },
              ),

              // Main Content
              Expanded(child: widget.child),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigation(
            currentPage: widget.currentPage,
            userRole: userRole ?? 'VOLUNTEER',
            onTap: (index) {
              _handleBottomNavigation(index, userRole ?? 'VOLUNTEER');
            },
          ),
        );
      },
    );
  }

  void _handleBottomNavigation(int index, String userRole) {
    final role = userRole.toUpperCase();

    if (role == 'HOSPITAL_ADMIN' || role == 'HOSPITAL ADMIN') {
      // Hospital Admin navigation
      switch (index) {
        case 0:
          if (widget.currentPage != 'events') {
            Navigator.pushReplacementNamed(context, '/events');
          }
          break;
        case 1:
          if (widget.currentPage != 'appointments') {
            Navigator.pushReplacementNamed(context, '/appointments');
          }
          break;
        case 2:
          if (widget.currentPage != 'profile') {
            Navigator.pushReplacementNamed(context, '/profile');
          }
          break;
      }
    } else {
      // Volunteer navigation
      switch (index) {
        case 0:
          if (widget.currentPage != 'home') {
            Navigator.pushReplacementNamed(context, '/home');
          }
          break;
        case 1:
          if (widget.currentPage != 'history') {
            Navigator.pushReplacementNamed(context, '/history');
          }
          break;
        case 2:
          if (widget.currentPage != 'profile') {
            Navigator.pushReplacementNamed(context, '/profile');
          }
          break;
      }
    }
  }

  // Helper method to get the default page for a user role
  static String getDefaultPageForRole(String userRole) {
    final role = userRole.toUpperCase();
    if (role == 'HOSPITAL_ADMIN' || role == 'HOSPITAL ADMIN') {
      return 'events';
    } else {
      return 'home';
    }
  }
}

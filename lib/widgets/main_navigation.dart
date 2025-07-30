import 'package:blood_system/widgets/red_header.dart';
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
  final Widget? floatingActionButton;
  final bool wrapWithScaffold;
  final bool showAppBar;
  final bool showDrawer;
  final bool showBottomNav;
  final Color? backgroundColor;

  const MainNavigationWrapper({
    super.key,
    required this.child,
    required this.currentPage,
    required this.pageTitle,
    this.floatingActionButton,
    this.wrapWithScaffold = true,
    this.showAppBar = true,
    this.showDrawer = true,
    this.showBottomNav = true,
    this.backgroundColor,
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

        // If wrapWithScaffold is false, just return the child with navigation logic
        if (!widget.wrapWithScaffold) {
          return widget.child;
        }

        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: widget.backgroundColor ?? const Color(0xFFF5F5F5),
          drawer:
              widget.showDrawer
                  ? CustomDrawer(
                    currentPage: widget.currentPage,
                    userName: userName,
                    userEmail: userEmail,
                    userRole: userRole,
                    onNavigateToFAQ:
                        _openFAQ, // pass the FAQ navigation callback if your drawer supports it
                  )
                  : null,
          appBar:
              widget.showAppBar
                  ? CustomAppBar(
                    pageName: widget.pageTitle,
                    scaffoldKey: _scaffoldKey,
                    onNotificationPressed: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                  )
                  : null,
          body: widget.child,
          floatingActionButton: widget.floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          bottomNavigationBar:
              widget.showBottomNav
                  ? CustomBottomNavigation(
                    currentPage: widget.currentPage,
                    userRole: userRole ?? 'VOLUNTEER',
                    onTap: (index) {
                      _handleBottomNavigation(index, userRole ?? 'VOLUNTEER');
                    },
                    child: SingleChildScrollView(child: SizedBox.shrink()),
                  )
                  : null,
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

  void _openFAQ() {
    Navigator.pushNamed(context, '/faq');
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

  // Static method to provide navigation functionality to existing Scaffolds
  static Widget withNavigation({
    required BuildContext context,
    required String currentPage,
    required String userRole,
  }) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        String? actualUserRole = userRole;

        if (authState is AuthAuthenticated) {
          actualUserRole = authState.userData?.role ?? userRole;
        }

        return CustomBottomNavigation(
          currentPage: currentPage,
          userRole: actualUserRole,
          onTap: (index) {
            _handleBottomNavigationStatic(
              context,
              index,
              actualUserRole ?? 'VOLUNTEER',
              currentPage,
            );
          },
          child: SingleChildScrollView(child: SizedBox.shrink()),
        );
      },
    );
  }

  static void _handleBottomNavigationStatic(
    BuildContext context,
    int index,
    String userRole,
    String currentPage,
  ) {
    final role = userRole.toUpperCase();

    if (role == 'HOSPITAL_ADMIN' || role == 'HOSPITAL ADMIN') {
      // Hospital Admin navigation
      switch (index) {
        case 0:
          if (currentPage != 'events') {
            Navigator.pushReplacementNamed(context, '/events');
          }
          break;
        case 1:
          if (currentPage != 'appointments') {
            Navigator.pushReplacementNamed(context, '/appointments');
          }
          break;
        case 2:
          if (currentPage != 'profile') {
            Navigator.pushReplacementNamed(context, '/profile');
          }
          break;
      }
    } else {
      // Volunteer navigation
      switch (index) {
        case 0:
          if (currentPage != 'home') {
            Navigator.pushReplacementNamed(context, '/home');
          }
          break;
        case 1:
          if (currentPage != 'history') {
            Navigator.pushReplacementNamed(context, '/history');
          }
          break;
        case 2:
          if (currentPage != 'profile') {
            Navigator.pushReplacementNamed(context, '/profile');
          }
          break;
      }
    }
  }
}

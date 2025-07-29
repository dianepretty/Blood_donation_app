import 'package:blood_system/theme/theme.dart';
import 'package:flutter/material.dart';

class RedHeader extends StatelessWidget {
  final String title;
  final double? height;
  final VoidCallback? onBack;
  final bool showBack;
  final bool showSettings;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const RedHeader({
    super.key,
    required this.title,
    this.height,
    this.onBack,
    this.showBack = false,
    this.showSettings = false,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = height ?? screenHeight * 0.18;
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return Container(
      width: double.infinity,
      height: headerHeight,
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
              color: AppColors.red.withOpacity(0.7),
            ),
          ),
          // Menu button (left side)
          if (onMenuPressed != null || scaffoldKey != null)
            Positioned(
              left: 16,
              top: 32,
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white, size: 28),
                onPressed:
                    onMenuPressed ??
                    () {
                      if (scaffoldKey?.currentState != null) {
                        scaffoldKey!.currentState!.openDrawer();
                      }
                    },
              ),
            ),
          // Back button (left side, only if menu is not shown)
          if (showBack &&
              onBack != null &&
              onMenuPressed == null &&
              scaffoldKey == null)
            Positioned(
              left: 16,
              top: 32,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: onBack,
              ),
            ),
          // Title (center)
          Positioned(
            left: isSmallScreen ? 56 : 64,
            right: isSmallScreen ? 56 : 64,
            top: headerHeight * 0.35,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 24 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Settings button (right side)
          if (showSettings)
            Positioned(
              right: isSmallScreen ? 16 : 24,
              top: headerHeight * 0.35,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.settings_outlined,
                  color: Colors.white,
                  size: isSmallScreen ? 24 : 28,
                ),
              ),
            ),
          // Notification button (right side)
          if (onNotificationPressed != null)
            Positioned(
              right: isSmallScreen ? 16 : 24,
              top: 32,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: onNotificationPressed,
              ),
            ),
        ],
      ),
    );
  }
}

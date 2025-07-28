import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onMenuPressed;
  final double? height;

  const CustomAppBar({
    super.key,
    required this.pageName,
    this.scaffoldKey,
    this.onNotificationPressed,
    this.onMenuPressed,
    this.height,
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
          // Background image layer
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
          // Red overlay
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              color: const Color(0xFFD7263D).withOpacity(0.7),
            ),
          ),
          // Menu button (left side)
          Positioned(
            left: 16,
            top: 32,
            child: IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 28),
              onPressed:
                  onMenuPressed ??
                  () {
                    scaffoldKey?.currentState?.openDrawer();
                  },
            ),
          ),
          // Page title (center)
          Positioned(
            left: isSmallScreen ? 56 : 64,
            right: isSmallScreen ? 56 : 64,
            top: headerHeight * 0.35,
            child: Center(
              child: Text(
                pageName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 24 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Notification button (right side)
          if (onNotificationPressed != null)
            Positioned(
              right: isSmallScreen ? 16 : 24,
              top: headerHeight * 0.35,
              child: GestureDetector(
                onTap: onNotificationPressed,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: isSmallScreen ? 24 : 28,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 120.0); // Default height when no height is provided
}

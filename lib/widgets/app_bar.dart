import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String pageName;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const CustomAppBar({
    super.key,
    required this.pageName,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.scaffoldKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFB83A3A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap:
                    onMenuPressed ??
                    () {
                      if (scaffoldKey?.currentState != null) {
                        scaffoldKey!.currentState!.openDrawer();
                      }
                    },
                child: const Icon(Icons.menu, color: Colors.white, size: 24),
              ),
              Text(
                pageName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: onNotificationPressed,
                child: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

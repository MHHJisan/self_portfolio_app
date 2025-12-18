import 'dart:ui';
import 'package:flutter/material.dart';

class GlassNavbar extends StatelessWidget {
  final bool hasScrolled;
  final void Function() onAboutTap;
  final void Function() onProjectTap;
  final void Function() onSkillsTap;
  final void Function() onServicesTap;

  final void Function() onExperienceTap;
  // final void Function() onContactTap;


  const GlassNavbar({
    required this.hasScrolled,
    required this.onAboutTap,
    required this.onProjectTap,
    required this.onSkillsTap,
    required this.onServicesTap,

    required this.onExperienceTap,
    // required this.onContactTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Calculate height dynamically to account for the phone's notch/status bar
    final double topPadding = MediaQuery.of(context).padding.top;
    final double navBarHeight = 75 + topPadding;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: navBarHeight,
          decoration: BoxDecoration(
            color: hasScrolled
                ? (isDark
                    ? Colors.black.withOpacity(0.7)
                    : Colors.white.withOpacity(0.8))
                : Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: hasScrolled
                    ? (isDark ? Colors.white10 : Colors.black12)
                    : Colors.transparent,
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 1. BRAND NAME (Left Anchored)
                  Text(
                    "Hasibul Haque Jisan",
                    style: TextStyle(
                      fontWeight: FontWeight.w900, // Extra Bold
                      fontSize: 20,
                      letterSpacing: -0.5,
                      color: isDark ? Colors.white : const Color(0xFF0F172A), // slate-900
                    ),
                  ),

                  // 2. NAV GROUP (Right Anchored)
                  if (screenWidth > 800)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _navLink("Skills", isDark, onSkillsTap),
                        _navLink("About", isDark, onAboutTap),
                        _navLink("Services", isDark, onServicesTap),
                        const SizedBox(width: 16), // Space before the button
                        _ctaButton(), // Let's Talk button appears immediately after links
                      ],
                    )
                  else
                  // Mobile Menu Icon
                    IconButton(
                      icon: Icon(
                        Icons.menu_rounded,
                        color: isDark ? Colors.white : Colors.black,
                        size: 28,
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Navigation Link Component
  Widget _navLink(String title, bool isDark, void Function() onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        foregroundColor: isDark ? Colors.white : Colors.black87,
        backgroundColor: Colors.transparent,
        overlayColor: Colors.transparent, // Removes the grey click splash
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800, // Explicitly Bold
        ),
      ),
    );
  }

  // "Let's Talk" CTA Button Component
  Widget _ctaButton() {
    return ElevatedButton(
      onPressed: () {
        // Add contact action
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4F46E5), // Indigo 600
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded-2xl
        ),
      ),
      child: const Text(
        "Let's talk",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child: Column(
        children: [
          // --- HEADER PART ---
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // --- NEW INTEGRATED BADGE ---
                _buildAboutMeBadge(isDark),

                const SizedBox(height: 24),
                Text(
                  "Engineering calm, reliable interfaces for ambitious teams.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 36,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "From marketing websites to multi-tenant applications, I obsess over the details that make software approachable—micro-interactions, motion, and systemised component workflows.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.6,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // --- PRINCIPLES GRID ---
          if (isMobile)
            Column(children: _buildPrinciples(isDark))
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildPrinciples(isDark)
                  .map((widget) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: widget,
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  // Helper to build the badge
  Widget _buildAboutMeBadge(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF312E81).withOpacity(0.3)
            : const Color(0xFFE0E7FF),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const PingDot(), // The animated dot
          const SizedBox(width: 8),
          Text(
            "About Me",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? const Color(0xFFA5B4FC)
                  : const Color(0xFF4338CA),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPrinciples(bool isDark) {
    final List<Map<String, String>> principles = [
      {"title": "Human-centered thinking", "desc": "Thoughtful defaults, clear flows, and measurable impact on business goals."},
      {"title": "A11y-first implementations", "desc": "Accessible by default, ensuring everyone can use the software effectively."},
      {"title": "Long-term maintainability", "desc": "Clean code architecture that grows with your team and product."},
    ];

    return principles.map((p) {
      return Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05),
                ),
                color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p["title"]!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    p["desc"]!,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

// --- ANIMATED PING DOT COMPONENT ---
class PingDot extends StatefulWidget {
  const PingDot({super.key});

  @override
  State<PingDot> createState() => _PingDotState();
}

class _PingDotState extends State<PingDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeTransition(
          opacity: Tween<double>(begin: 0.75, end: 0.0).animate(_controller),
          child: ScaleTransition(
            scale: Tween<double>(begin: 1.0, end: 2.5).animate(_controller),
            child: Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color: Color(0xFF818CF8),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        Container(
          height: 8,
          width: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF6366F1),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
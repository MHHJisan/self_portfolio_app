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
                Text(
                  "ABOUT",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4, // tracking-[0.3em]
                    color: isDark ? Colors.indigoAccent[100] : const Color(0xFF4F46E5),
                  ),
                ),
                const SizedBox(height: 16),
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
          // On mobile we stack (Column), on web we spread (Row)
          if (isMobile)
            Column(
              children: _buildPrinciples(isDark),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildPrinciples(isDark)
                  .map((widget) => Expanded(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: widget,
              )))
                  .toList(),
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
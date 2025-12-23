import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    final List<Map<String, dynamic>> skillCategories = [
      {
        "title": "Frontend",
        "skills": ["React / Next.js", "Vue.js", "AngularJS", "Flutter Web", "Tailwind CSS", "TypeScript"]
      },
      {
        "title": "Mobile",
        "skills": ["Flutter / Dart", "React Native", "Swift", "Java"]
      },
      {
        "title": "Backend/Tools",
        "skills": ["Node.js", "ExpressJS", "Laravel", "JavaSpring", "PostgreSQL", "Firebase", "CI/CD Pipelines"]
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child: Column(
        children: [
          // --- NEW HEADER BADGE ---
          _buildHeaderBadge(isDark),

          const SizedBox(height: 16),

          // --- UPDATED SUB-HEADER ---
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "Technologies I work with",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w800,
                height: 1.2,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // --- GRID ---
          if (isMobile)
            Column(
              children: skillCategories.map((cat) => _buildSkillCard(cat, isDark)).toList(),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: skillCategories
                  .map((cat) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildSkillCard(cat, isDark),
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }

  // Animated Badge Builder
  Widget _buildHeaderBadge(bool isDark) {
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
          const PingDot(), // Animated pulse
          const SizedBox(width: 8),
          Text(
            "TECHNICAL ARSENAL",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF4338CA),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(Map<String, dynamic> category, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
              ),
              color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.8),
              boxShadow: isDark ? [] : [
                BoxShadow(
                  color: const Color(0xFFE2E8F0).withOpacity(0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category["title"].toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: isDark ? Colors.white70 : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 20),
                ...category["skills"].map<Widget>((skill) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        height: 6,
                        width: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6366F1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        skill,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white.withOpacity(0.9) : const Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- PING DOT COMPONENT ---
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
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

    // Your skill data structure
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
        "skills": ["Node.js", "ExpressJS", "Laravel", "JavaSpring", "MONGODB" "PostgreSQL", "Firebase", "CI/CD Pipelines"]
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
      child: Column(
        children: [
          // --- HEADER ---
          Text(
            "TOOLKIT",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 4,
              color: const Color(0xFF4F46E5), // indigo-600
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              "A pragmatic stack honed on production systems.",
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
              // Shadow for Light Mode
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
                    color: isDark ? Colors.white70 : AppColors.slate900,
                  ),
                ),
                const SizedBox(height: 20),
                // Skills List
                ...category["skills"].map<Widget>((skill) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Container(
                        height: 6,
                        width: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6366F1), // indigo-500
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
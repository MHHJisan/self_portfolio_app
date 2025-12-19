import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

// 1. Define the Data Model
class Experience {
  final int id;
  final String period;
  final String company;
  final String role;
  final String description;
  final List<String> achievements;

  Experience({
    required this.id,
    required this.period,
    required this.company,
    required this.role,
    required this.description,
    required this.achievements,
  });

  // Helper to extract the year from the period string
  int get startYear {
    final match = RegExp(r'(19|20)\d{2}').firstMatch(period);
    return match != null ? int.parse(match.group(0)!) : 0;
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    // 2. Mock Data (Replace with your actual data)
    final List<Experience> experiences = [
      Experience(
        id: 1,
        period: "2023 — Present",
        company: "Global Tech Inc.",
        role: "Senior Software Engineer",
        description: "Leading the frontend architecture for high-traffic platforms.",
        achievements: ["Reduced bundle size by 40%", "Mentored 5 junior devs"],
      ),
      Experience(
        id: 2,
        period: "2022 — 2023",
        company: "Creative Studio",
        role: "Full Stack Developer",
        description: "Developed bespoke CMS solutions for enterprise clients.",
        achievements: ["Shipped 12+ production projects", "Implemented CI/CD"],
      ),
    ];

    // 3. Grouping Logic (Mirroring your grouped reduce logic)
    final Map<int, List<Experience>> grouped = {};
    for (var exp in experiences) {
      grouped.putIfAbsent(exp.startYear, () => []).add(exp);
    }
    final sortedYears = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        children: [
          // HEADER
          _buildHeader(isDark),
          const SizedBox(height: 60),

          // LIST OF YEARS
          ...sortedYears.map((year) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$year",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white70 : AppColors.slate600,
                  ),
                ),
                const SizedBox(height: 16),
                // LIST OF CARDS FOR THIS YEAR
                ...grouped[year]!.map((exp) => _ExperienceCard(exp: exp, isDark: isDark)),
                const SizedBox(height: 32),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Text(
          "EXPERIENCE",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            color: const Color(0xFF4F46E5),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            "Building high-quality software with teams across the globe.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
            ),
          ),
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience exp;
  final bool isDark;

  const _ExperienceCard({required this.exp, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(32),
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.period.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: isDark ? Colors.white38 : AppColors.slate500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  exp.role,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                Text(
                  exp.company,
                  style: TextStyle(
                    fontSize: 16,
                    color: isDark ? Colors.white60 : AppColors.slate500,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  exp.description,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: isDark ? Colors.white70 : AppColors.slate600,
                  ),
                ),
                const SizedBox(height: 24),
                // ACHIEVEMENTS
                ...exp.achievements.map((achievement) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        height: 6,
                        width: 6,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6366F1),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          achievement,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white60 : AppColors.slate500,
                          ),
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
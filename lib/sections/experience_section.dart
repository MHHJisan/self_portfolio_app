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
        period: "06/2022 — Present",
        company: "TechRA Learning Center",
        role: "Instructor, Web Development and Basic Programming and IELTS",
        description:
        "Co-founded and instructed at a skill development institution in Noakhali, BD, teaching Basic Programming in Java and Web Development with PHP & React.",
        achievements: [
          "Established curriculum and taught Basic Programming in Java to multiple cohorts",
          "Designed and delivered Web Development courses using PHP and React",
          "Taught IELTS preparation to students alongside technical subjects",
          "Built the institution from the ground up with tech enthusiast friends",
        ],
      ),
      Experience(
        id: 2,
        period: "2023 — Present",
        company: "Techraverse",
        role: "Lead Frontend Engineer",
        description:
        "Guiding the frontend guild, defining standards, and partnering directly with founders to launch new verticals.",
        achievements: [
          "Refactored the design system to support theming and dark mode",
          "Cut CLS issues by 68% through streaming & suspense-first layouts",
          "Mentored a team of 6 engineers across two timezones",
        ],
      ),
      Experience(
        id: 3,
        period: "2021 — 2023",
        company: "CPF International",
        role: "Full Stack Engineer",
        description:
        "Owned the digital fundraising stack end-to-end, from CRM integrations to performance budgets.",
        achievements: [
          "Scaled donation revenue 2.5× with a revamped checkout flow",
          "Built a custom content approval workflow with audit trails",
          "Established automated Lighthouse monitoring in CI",
        ],
      ),
      Experience(
        id: 4,
        period: "2024 — 2025",
        company: "HI-TECH SoftSys",
        role: "Software Engineer",
        description:
        "Developed an LMS system for web and mobile using Vue + Laravel for the web and Flutter for the mobile app (https://online-academy.islamicdigitallane.com/).",
        achievements: [
          "Built core LMS features for both web and mobile: courses, enrollments, and progress tracking",
          "Collaborated on cross-platform API design with Laravel back-end",
          "Delivered responsive Vue front-end components and Flutter mobile screens",
        ],
      ),
      Experience(
        id: 5,
        period: "Sep 2023 — Nov 2024",
        company: "Bioforge Health System LTD",
        role: "Software Engineer",
        description:
        "Developed and maintained a Hospital Management System (HMS) using Java Spring for the backend and AngularJS/ReactJS for the frontend. Integrated and configured Odoo accounting software with the HMS.",
        achievements: [
          "Implemented core HMS modules and integrations with Odoo",
          "Maintained and extended backend services in Java Spring",
          "Improved deployment and integration workflows",
        ],
      ),
      Experience(
        id: 6,
        period: "Feb 2024 — May 2024",
        company: "Octagon Learning (Bioforge)",
        role: "Software Engineer (Part-time) — ChatCls",
        description:
        "Developed a WhatsApp chatbot that delivers scheduled question sets to registered students using Node.js and Express.",
        achievements: [
          "Built a scheduling system to send subject-specific question sets",
          "Integrated with WhatsApp messaging for automated delivery",
          "Streamlined registration and message flows for student cohorts",
        ],
      ),
      Experience(
        id: 7,
        period: "May 2024 — Nov 2024",
        company: "Octagon Learning (Bioforge)",
        role: "Project Lead (Part-time) — QuestionpaperSplitter",
        description:
        "Led development of a script that ingests PDFs and auto-splits them into images where each image contains a single question, exporting results to a configured folder.",
        achievements: [
          "Designed a robust PDF-to-image pipeline for batch splitting",
          "Automated export and folder workflows for downstream processing",
          "Improved accuracy of question detection and split timing",
        ],
      ),
      Experience(
        id: 8,
        period: "Nov 2021 — May 2022",
        company: "ISZTECHS",
        role: "Web Developer",
        description:
        "Worked on PHP and Laravel-based web solutions for US-based clients, implementing core features and maintaining applications.",
        achievements: [
          "Delivered client-facing features in Laravel and core PHP",
          "Maintained legacy codebases and migrated features to Laravel",
          "Collaborated with remote teams to meet delivery deadlines",
        ],
      ),
      Experience(
        id: 9,
        period: "May 2019 — Apr 2020",
        company: "Sis InflextionPoint",
        role: "Jr. Software Developer",
        description:
        "Worked on iOS app development using Swift, contributing to app features and bug fixes.",
        achievements: [
          "Implemented UI components and view controllers in Swift",
          "Fixed bugs and improved app stability across iOS versions",
          "Collaborated with senior developers on feature design",
        ],
      ),
      Experience(
        id: 10,
        period: "Apr 2017 — Nov 2017",
        company: "Relativeagro Limited",
        role: "PHP Developer (Contractual, Part-time)",
        description:
        "Worked as a 3rd-year student on a web-based Livestock Management System using core PHP, and integrated an Account Management System.",
        achievements: [
          "Developed core modules for livestock management in PHP",
          "Integrated accounting features into the system",
          "Delivered features while balancing academic commitments",
        ],
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
                    color: isDark ? Colors.white70 : AppColors.slate900,
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

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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


    final Map<int, List<Experience>> grouped = {};
    for (var exp in experiences) {
      grouped.putIfAbsent(exp.startYear, () => []).add(exp);
    }
    final sortedYears = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              _buildHeader(isDark),
              const SizedBox(height: 60),

              ...sortedYears.map((year) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- NEW ICONIC YEAR HEADER ---
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 24, top: 10),
                      child: Row(
                        children: [
                          // Icon with a soft Indigo glow
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF6366F1).withOpacity(0.2),
                              ),
                            ),
                            child: const Icon(
                              Icons.calendar_today_rounded, // Modern calendar icon
                              size: 18,
                              color: Color(0xFF6366F1),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // The Year Text
                          Text(
                            "$year",
                            style: GoogleFonts.spaceMono(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 12),
                          // Decorative line to "anchor" the timeline
                          Expanded(
                            child: Container(
                              height: 1,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFF6366F1).withOpacity(0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // The cards for this year
                    ...grouped[year]!.map((exp) => ExperienceCard(exp: exp)),
                    const SizedBox(height: 40),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Text(
          "PROFESSIONAL JOURNEY",
          style: GoogleFonts.spaceMono(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            color: const Color(0xFF6366F1),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Building impact across industries.",
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 38,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

class ExperienceCard extends StatefulWidget {
  final Experience exp;
  const ExperienceCard({required this.exp, super.key});

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Same "Safe" Matrix from Projects
    final Matrix4 hoverTransform = Matrix4.translationValues(12.0, 0.0, 0.0); // Slides slightly right

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        // Mobile Support
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          transform: _isHovered ? hoverTransform : Matrix4.identity(),
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: isDark
                ? (_isHovered ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.04))
                : Colors.white,
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF6366F1).withOpacity(0.5)
                  : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
              width: 1,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(-10, 0),
                )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. DATE LABEL
              Text(
                widget.exp.period.toUpperCase(),
                style: GoogleFonts.spaceMono(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6366F1),
                ),
              ),
              const SizedBox(height: 12),

              // 2. ROLE & COMPANY
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.exp.role,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          widget.exp.company,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6366F1).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // 3. DESCRIPTION
              Text(
                widget.exp.description,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  height: 1.6,
                  color: isDark ? Colors.white60 : const Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 24),

              // 4. ACHIEVEMENTS LIST
              ...widget.exp.achievements.map((achievement) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.double_arrow_rounded, // Technical arrow icon
                        size: 14,
                        color: const Color(0xFF6366F1).withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        achievement,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: isDark ? Colors.white70 : const Color(0xFF475569),
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
    );
  }
}



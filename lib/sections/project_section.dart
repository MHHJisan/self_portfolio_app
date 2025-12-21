import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this to pubspec.yaml

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Your data structure
    final List<Map<String, dynamic>> projects = [
      {
        "id": 0,
        "title": "CPF International",
        "description": "High-conversion non-profit site with multilingual support, donation funnel, and event publishing workflow.",
        "tags": ["Next.js", "TypeScript", "Tailwind CSS", "Node.js", "Supabase"],
        "type": "web",
        "url": "https://www.cpfint.org",
      },
      {
        "id": 1,
        "title": "Techraverse Learning Platform",
        "description": "Modular learning platform with real-time classrooms, cohort analytics, and a custom CMS powering 30k+ monthly sessions.",
        "tags": ["Next.js", "TypeScript", "Tailwind CSS", "Node.js", "MongoDB"],
        "type": "web",
        "url": "https://learn.techraverse.com",
      },
      {
        "id": 2,
        "title": "Techra Quiz Web",
        "description": "Gamified quiz experience featuring adaptive question banks, instant scoring, and shareable summaries.",
        "tags": ["Next.js", "React", "Firebase", "Framer Motion"],
        "type": "web",
        "url": "https://techra-quiz-web.vercel.app",
      },
      {
        "id": 4,
        "title": "Techraverse.com",
        "description":
        "Content platform for engineering notes, MDX-powered articles, and tooling reviews with custom search.",
        "tags": ["Next.js", "TypeScript", "Contentful"],
        "type": "web",
        "url": "https://techraverse.com",

      },
      {
        "id": 5,
        "title": "Tasbeeh Tracker",
        "description": "A focused mobile application for spiritual habit tracking with cloud sync.",
        "tags": ["ReactNative", "JavaScript", "Firebase"],
        "type": "mobile",
        "url": "#",
      },
      {
        "id": 6,
        "title": "Self Portfolio App",
        "description": "built my self portfilo app - This one!",
        "tags": ["Flutter", "Dart", "Firebase"],
        "type": "mobile",
        "url": "#",
      },
    ];

    final webProjects = projects.where((p) => p['type'] == 'web').toList();
    final mobileProjects = projects.where((p) => p['type'] == 'mobile').toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF020617) : Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              // --- HEADER ---
              _buildHeader(isDark),

              // --- WEB PROJECTS ---
              _buildSubHeader("Web Applications", isDark),
              _buildProjectGrid(webProjects, screenWidth),

              const SizedBox(height: 12),

              // --- MOBILE PROJECTS ---
              _buildSubHeader("Mobile Applications", isDark),
              mobileProjects.isEmpty
                  ? _buildEmptyState(isDark)
                  : _buildProjectGrid(mobileProjects, screenWidth),
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
          "SELECTED WORK",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            color: const Color(0xFF4F46E5),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Recent projects that moved the needle.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSubHeader(String title, bool isDark) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : const Color(0xFF0F172A),
        ),
      ),
    );
  }

  Widget _buildProjectGrid(List<Map<String, dynamic>> items, double screenWidth) {
    bool isMobile = screenWidth < 800;
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        crossAxisSpacing: 32,
        mainAxisSpacing: 32,
        mainAxisExtent: 340, // Height of the card
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => ProjectCard(project: items[index]),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(60),
      child: Text(
        "No mobile applications to display yet.",
        style: TextStyle(color: isDark ? Colors.white38 : Colors.grey),
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  const ProjectCard({required this.project, super.key});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // // We use a Matrix4 translation for a "Lift" effect on hover
    // final hoverTransform = Matrix4.identity()
    //   ..translate(0, -8, 0) // Lifts the card up by 8 pixels
    //   ..scale(1.02);        // Slightly scales up for depth

    // SAFE CONSTRUCTION: Uses explicit doubles and factory constructors
    final Matrix4 hoverTransform = Matrix4.translationValues(0.0, -8.0, 0.0)
      ..scale(1.02, 1.02, 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutBack, // Gives it a snappy "engineering" bounce
        transform: _isHovered ? hoverTransform : Matrix4.identity(),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // Gradient background for a "Glass" feel
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [Colors.white.withValues(alpha: 0.08), Colors.white.withValues(alpha: 0.03)]
                : [Colors.white, const Color(0xFFF8FAFC)],
          ),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF6366F1).withValues(alpha: 0.5)
                : (isDark ? Colors.white.withValues(alpha: 0.1) : Colors.black.withValues(alpha: 0.08)),
            width: _isHovered ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                  : Colors.transparent,
              blurRadius: 30,
              offset: const Offset(0, 15),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. TOP BAR: Engineering Label (Project ID)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "PROJECT // 0${widget.project['id'] ?? 1}", // Technical ID
                  style: GoogleFonts.spaceMono( // Mono font for engineering vibe
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 300),
                  turns: _isHovered ? 0 : -0.125, // Rotates icon on hover
                  child: Icon(
                    Icons.arrow_outward_rounded,
                    color: _isHovered ? const Color(0xFF6366F1) : Colors.grey.withValues(alpha: 0.5),
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2. PROJECT TITLE
            Text(
              widget.project["title"],
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            // 3. DESCRIPTION
            Text(
              widget.project["description"],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 15,
                height: 1.6,
                color: isDark ? Colors.white.withValues(alpha: 0.6) : const Color(0xFF475569),
              ),
            ),

            const Spacer(),

            // 4. TECH STACK (Modern Chips)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (widget.project["tags"] as List<String>).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.spaceMono(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white70 : const Color(0xFF475569),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
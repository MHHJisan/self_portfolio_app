import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectSection extends StatelessWidget {
  const ProjectSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;

    final List<Map<String, dynamic>> projects = [
      {
        "id": 1,
        "title": "CPF International",
        "description": "High-conversion non-profit site with multilingual support, donation funnel, and event publishing workflow.",
        "tags": ["Next.js", "TypeScript", "Tailwind", "Supabase"],
        "type": "web",
        "url": "https://www.cpfint.org",
      },
      {
        "id": 2,
        "title": "Techraverse Learning",
        "description": "Modular learning platform with real-time classrooms, cohort analytics, and a custom CMS.",
        "tags": ["Next.js", "Node.js", "MongoDB", "Socket.io"],
        "type": "web",
        "url": "https://learn.techraverse.com",
      },
      {
        "id": 3,
        "title": "Techra Quiz Web",
        "description": "Gamified quiz experience featuring adaptive question banks and instant scoring.",
        "tags": ["React", "Firebase", "Framer Motion"],
        "type": "web",
        "url": "https://techra-quiz-web.vercel.app",
      },
      {
        "id": 4,
        "title": "Techraverse.com",
        "description": "Engineering notes and MDX-powered articles with custom search and tooling reviews.",
        "tags": ["Next.js", "TypeScript", "Contentful"],
        "type": "web",
        "url": "https://techraverse.com",
      },
      {
        "id": 5,
        "title": "Tasbeeh Tracker",
        "description": "A focused mobile application for spiritual habit tracking with cloud sync and custom reminders.",
        "tags": ["ReactNative", "JavaScript", "Firebase"],
        "type": "mobile",
        "url": "#",
      },
      {
        "id": 6,
        "title": "Self Portfolio App",
        "description": "The high-performance Flutter portfolio you are currently browsing.",
        "tags": ["Flutter", "Dart", "Firebase"],
        "type": "mobile",
        "url": "#",
      },
    ];

    final webProjects = projects.where((p) => p['type'] == 'web').toList();
    final mobileProjects = projects.where((p) => p['type'] == 'mobile').toList();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              _buildHeader(isDark),
              const SizedBox(height: 60),

              _buildSubHeader("Web Applications", isDark),
              const SizedBox(height: 24),
              _buildProjectGrid(webProjects, screenWidth),

              const SizedBox(height: 80),

              _buildSubHeader("Mobile Applications", isDark),
              const SizedBox(height: 24),
              _buildProjectGrid(mobileProjects, screenWidth),
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
          style: GoogleFonts.spaceMono(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
            color: const Color(0xFF6366F1),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Engineering impact through code.",
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

  Widget _buildSubHeader(String title, bool isDark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white70 : const Color(0xFF334155),
        ),
      ),
    );
  }

  Widget _buildProjectGrid(List<Map<String, dynamic>> items, double screenWidth) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth < 800 ? 1 : 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        mainAxisExtent: 320,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) => ProjectCard(project: items[index]),
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

  Future<void> _launchURL(String url) async {
    if (url == "#") return;
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Safe Matrix for both Web and Mobile
    final Matrix4 hoverTransform = Matrix4.translationValues(0.0, -12.0, 0.0)
      ..scale(1.02, 1.02, 1.0);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        // Mobile Interaction Support
        onTapDown: (_) => setState(() => _isHovered = true),
        onTapUp: (_) => setState(() => _isHovered = false),
        onTapCancel: () => setState(() => _isHovered = false),
        onTap: () => _launchURL(widget.project['url']),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          transform: _isHovered ? hoverTransform : Matrix4.identity(),
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: isDark
                ? (_isHovered ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.04))
                : Colors.white,
            border: Border.all(
              color: _isHovered
                  ? const Color(0xFF6366F1).withOpacity(0.5)
                  : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: const Color(0xFF6366F1).withOpacity(0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 20),
                )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PROJ // 0${widget.project['id']}",
                    style: GoogleFonts.spaceMono(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6366F1),
                    ),
                  ),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: _isHovered ? 0 : -0.125,
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      color: _isHovered ? const Color(0xFF6366F1) : Colors.grey,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.project["title"],
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.project["description"],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  height: 1.6,
                  color: isDark ? Colors.white60 : const Color(0xFF475569),
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (widget.project["tags"] as List<String>).map((tag) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: isDark ? Colors.white10 : Colors.transparent),
                    ),
                    child: Text(
                      tag.toUpperCase(),
                      style: GoogleFonts.spaceMono(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : const Color(0xFF64748B),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
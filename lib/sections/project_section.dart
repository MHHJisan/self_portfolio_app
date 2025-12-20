import 'package:flutter/material.dart';
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
          horizontal: BorderSide(color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
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

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF6366F1).withOpacity(0.4)
                : (isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: isDark ? Colors.black45 : const Color(0xFFE2E8F0),
                blurRadius: 40,
                offset: const Offset(0, 20),
              )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.project["title"],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                ),
                Icon(Icons.arrow_outward,
                    color: _isHovered ? const Color(0xFF4F46E5) : Colors.grey,
                    size: 20
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Description
            Text(
              widget.project["description"],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: isDark ? Colors.white70 : AppColors.slate600,
              ),
            ),
            const Spacer(),
            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (widget.project["tags"] as List<String>).map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F46E5),
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

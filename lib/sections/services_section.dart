import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 1024; // Matches Tailwind's lg breakpoint

    final List<Map<String, dynamic>> services = [
      {
        "id": "01",
        "title": "Product Engineering",
        "description":
        "Plan, build, and launch performant web products that scale with your roadmap.",
        "highlights": [
          "Full-stack Next.js development",
          "Design system implementation",
          "Web vitals & accessibility focus",
        ],
      },
      {
        "id": "02",
        "title": "Experience Design",
        "description":
        "Translate complex requirements into elegant, human-centered interfaces.",
        "highlights": [
          "Rapid prototyping",
          "Collaborative UX workshops",
          "Component-driven design",
        ],
      },
      {
        "id": "03",
        "title": "Technical Leadership",
        "description":
        "Partner with founders and teams to ship faster while raising the quality bar.",
        "highlights": [
          "Roadmap prioritisation",
          "Code reviews & mentoring",
          "Process automation",
        ],
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        children: [
          if (isMobile)
            Column(
              children: services.map((s) => _ServiceCard(service: s, isDark: isDark)).toList(),
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: services
                  .map((s) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: _ServiceCard(service: s, isDark: isDark),
                ),
              ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final Map<String, dynamic> service;
  final bool isDark;

  const _ServiceCard({required this.service, required this.isDark});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.only(bottom: 24),
        // Hover translation: translateY(-4)
        transform: _isHovered ? (Matrix4.identity()..translate(0, -8, 0)) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: _isHovered
                ? const Color(0xFF6366F1).withOpacity(0.4) // Indigo-500/40
                : (widget.isDark ? Colors.white10 : Colors.black.withOpacity(0.05)),
          ),
          color: widget.isDark
              ? Colors.white.withOpacity(0.05)
              : Colors.white.withOpacity(0.8),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: widget.isDark
                    ? Colors.black54
                    : const Color(0xFFE2E8F0).withOpacity(0.8),
                blurRadius: 30,
                offset: const Offset(0, 15),
              )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Numeric ID Box
                  AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: _isHovered ? 1.1 : 1.0,
                    child: Container(
                      height: 48,
                      width: 48,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.isDark
                            ? const Color(0xFF6366F1).withOpacity(0.2)
                            : const Color(0xFFEEF2FF),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        widget.service["id"],
                        style: const TextStyle(
                          color: Color(0xFF4F46E5),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    widget.service["title"],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: widget.isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Description
                  Text(
                    widget.service["description"],
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: widget.isDark ? Colors.white70 : AppColors.slate600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Highlights List
                  ...widget.service["highlights"].map<Widget>((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
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
                            item,
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.isDark ? Colors.white60 : AppColors.slate600,
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
      ),
    );
  }
}
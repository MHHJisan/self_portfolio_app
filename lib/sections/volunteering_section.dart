import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteeringItem {
  final int id;
  final String title;
  final String period;
  final String organization;
  final String? link;
  final String emoji;
  final List<String> details;

  VolunteeringItem({
    required this.id,
    required this.title,
    required this.period,
    required this.organization,
    required this.emoji,
    required this.details,
    this.link,
  });
}

class VolunteeringSection extends StatelessWidget {
  const VolunteeringSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    final List<VolunteeringItem> volunteering = [
      VolunteeringItem(
        id: 1,
        title: "Chief of Volunteer & Fundraising Manager",
        period: "June 2021 — Present",
        organization: "CPFINT.ORG",
        link: "https://www.cpfint.org",
        emoji: "🏆",
        details: [
          "Strategically managed and coordinated volunteer activities for the organization.",
          "Successfully led fundraising initiatives and campaigns to support foundation projects.",
          "Applied a goal-oriented approach to expanding the foundation's reach.",
        ],
      ),
      VolunteeringItem(
        id: 2,
        title: "Volunteer",
        period: "Apr 2015 — Present",
        organization: "We. Foundation",
        link: "https://www.facebook.com/groups/902085893250334",
        emoji: "🤝",
        details: [
          "Contributed to various charitable and non-profit initiatives, demonstrating long-term commitment to community service.",
        ],
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // --- HEADER ---
              _buildHeader(isDark),
              const SizedBox(height: 48),

              // --- LIST ---
              ...volunteering.map((v) => _VolunteeringCard(item: v, isDark: isDark)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Text("🌱", style: TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Text(
              "VOLUNTEERING & MANAGEMENT",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 3, // Reduced slightly to help fit
                color: const Color(0xFF4F46E5),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          "Community leadership & volunteer roles",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}

class _VolunteeringCard extends StatelessWidget {
  final VolunteeringItem item;
  final bool isDark;

  const _VolunteeringCard({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black.withAlpha(13),
        ),
        color: isDark ? Colors.white.withAlpha(13) : Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient Emoji Avatar
          Container(
            height: 56,
            width: 56,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF22D3EE)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))],
            ),
            child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 24))),
          ),
          const SizedBox(width: 20),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(width: 8),
                          _buildOrgBadge(context),
                        ],
                      ),
                    ),
                    if (MediaQuery.of(context).size.width > 600)
                      Text(item.period, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
                ...item.details.map((detail) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(Icons.circle, size: 6, color: Colors.indigo),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          detail,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.5,
                            color: isDark ? Colors.white70 : AppColors.slate500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrgBadge(BuildContext context) {
    return InkWell(
      onTap: item.link != null ? () => launchUrl(Uri.parse(item.link!)) : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isDark ? Colors.white10 : AppColors.slate500,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.organization,
              style: TextStyle(
                fontSize: 12,
                color: isDark ? Colors.white70 : AppColors.slate500,
              ),
            ),
            if (item.link != null) ...[
              const SizedBox(width: 4),
              const Icon(Icons.arrow_forward, size: 10),
            ]
          ],
        ),
      ),
    );
  }
}

// Helper extension to handle the Slate color palette easily
extension ColorHelpers on Color {
  static Color slate(int weight) {
    switch (weight) {
      case 100: return const Color(0xFFF1F5F9);
      case 600: return const Color(0xFF475569);
      default: return Colors.grey;
    }
  }
}
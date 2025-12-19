import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Award {
  final int id;
  final String title;
  final String issuer;
  final String year;
  final String? link;

  Award({
    required this.id,
    required this.title,
    required this.issuer,
    required this.year,
    this.link,
  });
}

class AwardsSection extends StatelessWidget {
  const AwardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Responsive Column Count: 1 for mobile, 2 for tablet, 3 for desktop
    int crossAxisCount = screenWidth < 640 ? 1 : (screenWidth < 1024 ? 2 : 3);

    final List<Award> awards = [
      Award(
        id: 1,
        title: "Certified Kubernetes Administrator",
        issuer: "Cloud Native Computing Foundation",
        year: "2022",
        link: "https://www.cncf.io/",
      ),
      Award(
        id: 2,
        title: "AWS Certified Solutions Architect — Associate",
        issuer: "Amazon Web Services",
        year: "2021",
        link: "https://aws.amazon.com/certification/",
      ),
      Award(
        id: 3,
        title: "Frontend Developer Nanodegree",
        issuer: "Udacity",
        year: "2020",
        link: "https://www.udacity.com/",
      ),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      child: Column(
        children: [
          // --- HEADER ---
          _buildHeader(isDark),
          const SizedBox(height: 48),

          // --- GRID ---
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: 200, // Fixed height for cards
            ),
            itemCount: awards.length,
            itemBuilder: (context, index) => _AwardCard(award: awards[index], isDark: isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Text(
          "AWARDS & CERTIFICATIONS",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            color: const Color(0xFF4F46E5),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "Selected recognitions and certificates",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Text(
            "A selection of certifications and awards that reflect recent training and achievements.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: isDark ? Colors.white70 : AppColors.slate500,
            ),
          ),
        ),
      ],
    );
  }
}

class _AwardCard extends StatelessWidget {
  final Award award;
  final bool isDark;

  const _AwardCard({required this.award, required this.isDark});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) throw Exception('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.all(24),
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  award.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  award.issuer,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? Colors.white60 : AppColors.slate500,
                  ),
                ),
                Text(
                  award.year,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Spacer(),
                if (award.link != null)
                  TextButton.icon(
                    onPressed: () => _launchUrl(award.link!),
                    iconAlignment: IconAlignment.end,
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text("View"),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      foregroundColor: const Color(0xFF4F46E5),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
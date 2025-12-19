import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/colors.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 900;

    return Stack(
      children: [
        // --- 1. Background Blur Blobs (Glow effects) ---
        Positioned(
          left: -50,
          top: 100,
          child: _BlurBlob(
            color: Colors.indigo.withOpacity(isDark ? 0.4 : 0.2),
          ),
        ),
        Positioned(
          right: -50,
          top: 50,
          child: _BlurBlob(
            color: Colors.cyan.withOpacity(isDark ? 0.3 : 0.2),
          ),
        ),

        // --- 2. Main Content ---
        Container(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 40,
          ),
          child: isMobile
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextSide(isDark),
              const SizedBox(height: 60),
              _buildImageSide(isDark, isMobile),
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 11, child: _buildTextSide(isDark)),
              const SizedBox(width: 40),
              Expanded(flex: 9, child: _buildImageSide(isDark, isMobile)),
            ],
          ),
        ),
      ],
    );
  }

  // Text Content (Left side on Web / Top on Mobile)
  Widget _buildTextSide(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Available" Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: isDark ? Colors.white10 : Colors.black12,
            ),
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white70,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(backgroundColor: Colors.green, radius: 4),
              const SizedBox(width: 8),
              Text(
                "Available for freelance & full-time",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I design & build thoughtful web products that feel effortless.",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
            height: 1.1,
            color: isDark ? Colors.white : AppColors.slate900,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "I'm Hasibul Haque Jisan, a full-stack engineer obsessed with experience quality. I partner with founders to ship reliable software.",
          style: TextStyle(
            fontSize: 18,
            height: 1.5,
            color: isDark ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(height: 40),
        // Action Buttons
        Row(
          children: [
            Expanded(
             child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? Colors.white : Colors.black,
                foregroundColor: isDark ? Colors.black : Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("View recent work", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("mhhaque.tech@gmail.com"),
              ),
            ),

          ],
        ),
      ],
    );
  }

  // Image Card Content (Right side on Web / Bottom on Mobile)
  Widget _buildImageSide(bool isDark, bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: isDark ? Colors.white10 : Colors.white),
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 50,
            offset: const Offset(0, 20),
          )
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Container(
              height: 380,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.2),
              child: Image.asset(
                'assets/profile.png',
                fit: BoxFit.cover,
                alignment: const Alignment(0, -0.8), // Matches object-position: 50% 10%
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Small Feature boxes (The "Focus" and "Mission" blocks)
          Row(
            children: [
              _buildFeatureBox("Focus", "Design systems", isDark),
              const SizedBox(width: 12),
              _buildFeatureBox("Mission", "Move faster", isDark),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFeatureBox(String label, String value, bool isDark) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? Colors.white10 : Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, color: Colors.grey, letterSpacing: 1)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// Helper for Background Glows
class _BlurBlob extends StatelessWidget {
  final Color color;
  const _BlurBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: Container(color: Colors.transparent),
      ),
    );
  }
}

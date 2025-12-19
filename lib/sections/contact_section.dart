import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this to pubspec.yaml

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  // Action methods
  Future<void> _launchEmail() async {
    final Uri url = Uri.parse('mailto:mhhaque.tech@gmail.com');
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  Future<void> _launchPhone() async {
    final Uri url = Uri.parse('tel:+8801796206206');
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // --- Main Card Container ---
          Container(
            width: 1000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: isDark ? Colors.white.withValues(alpha: 0.1) : Colors.white.withValues(alpha: 0.6),
              ),
              boxShadow: isDark
                  ? []
                  : [
                BoxShadow(
                  color: const Color(0xFF4F46E5).withValues(alpha: 0.08),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: isDark ? const Color(0xFF0F172A).withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.8),
                  padding: const EdgeInsets.all(40),
                  child: Stack(
                    children: [
                      // --- Background Glows (Blurred Circles) ---
                      Positioned(
                        top: -40,
                        left: -40,
                        child: _buildGlowCircle(
                          isDark ? Colors.indigo.withValues(alpha: 0.3) : Colors.indigo.withValues(alpha: 0.1),
                          160,
                        ),
                      ),
                      Positioned(
                        bottom: -40,
                        right: -40,
                        child: _buildGlowCircle(
                          isDark ? Colors.cyan.withValues(alpha: 0.3) : Colors.cyan.withValues(alpha: 0.1),
                          200,
                        ),
                      ),

                      // --- Content ---
                      Column(
                        children: [
                          Text(
                            "CONTACT",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 4,
                              color: isDark ? const Color(0xFF818CF8) : const Color(0xFF4F46E5),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "Let’s build something meaningful together.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Text(
                              "I reply to every note. Send a quick brief, a product idea, or a link to your roadmap—I'll respond within 48 hours.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: isDark ? Colors.white70 : const Color(0xFF475569),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // --- Buttons Row (Responsive) ---
                          Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            alignment: WrapAlignment.center,
                            children: [
                              // Email Button
                              _buildPrimaryButton(_launchEmail),
                              // Phone/Call Button
                              _buildSecondaryButton(_launchPhone, isDark),
                            ],
                          ),
                          const SizedBox(height: 40),

                          // --- Social Icons ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildSocialIcon(FontAwesomeIcons.github, "https://github.com/yourusername", isDark),
                              const SizedBox(width: 16),
                              _buildSocialIcon(FontAwesomeIcons.linkedin, "https://linkedin.com/in/yourusername", isDark),
                              const SizedBox(width: 16),
                              _buildSocialIcon(FontAwesomeIcons.twitter, "https://x.com/yourusername", isDark),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildGlowCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildPrimaryButton(VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.mail_outline, size: 20),
      label: const Text("mhhaque.tech@gmail.com"),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 10,
        shadowColor: const Color(0xFF4F46E5).withValues(alpha: 0.4),
      ),
    );
  }

  Widget _buildSecondaryButton(VoidCallback onTap, bool isDark) {
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: const Icon(Icons.phone_outlined, size: 20),
      label: const Text("Book a call"),
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? Colors.white : const Color(0xFF334155),
        side: BorderSide(color: isDark ? Colors.white24 : const Color(0xFFE2E8F0)),
        backgroundColor: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url, bool isDark) {
    return InkWell(
      onTap: () => launchUrl(Uri.parse(url)),
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: isDark ? Colors.white24 : const Color(0xFFE2E8F0)),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isDark ? Colors.white70 : const Color(0xFF475569),
        ),
      ),
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart'; // For website link
import 'package:self_portfolio_app/theme/colors.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  final String portfolioUrl = "https://mhhaque.vercel.app/";

  /// Logic to open external website
  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse(portfolioUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  /// Logic to extract the PDF from assets and open it locally
  Future<void> _openResume(BuildContext context) async {
    try {
      final byteData = await rootBundle.load('assets/Hasibul-Haque-Jisan.pdf');
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/Hasibul-Haque-Jisan.pdf');

      await file.writeAsBytes(byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes
      ));

      final result = await OpenFilex.open(file.path);

      if (result.type != ResultType.done && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open PDF: ${result.message}")),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error: Could not find or read the resume file.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Center(
        child: Column(
          children: [
            Text(
              "RESUME & LINKS",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                color: isDark ? const Color(0xFF818CF8) : const Color(0xFF4F46E5),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Download my resume",
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
                "Want a PDF copy or wish to see my live portfolio? Use the buttons below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? Colors.white70 : AppColors.slate500,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // --- Buttons Container ---
            Wrap(
              spacing: 16, // Gap between buttons
              runSpacing: 16, // Gap when wrapped vertically
              alignment: WrapAlignment.center,
              children: [
                // Download Resume Button
                _buildActionButton(
                  onTap: () => _openResume(context),
                  label: "Download resume",
                  icon: Icons.file_download_outlined,
                  isPrimary: true,
                ),

                // Visit Website Button
                _buildActionButton(
                  onTap: _launchWebsite,
                  label: "Visit my website",
                  icon: Icons.language,
                  isPrimary: false,
                  isDark: isDark,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required String label,
    required IconData icon,
    required bool isPrimary,
    bool isDark = false,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFF4F46E5) : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: isPrimary
                ? null
                : Border.all(color: isDark ? Colors.white24 : Colors.black12),
            boxShadow: isPrimary ? [
              BoxShadow(
                color: const Color(0xFF4F46E5).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ] : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                  icon,
                  color: isPrimary ? Colors.white : (isDark ? Colors.white : Colors.black87),
                  size: 20
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: isPrimary ? Colors.white : (isDark ? Colors.white : Colors.black87),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
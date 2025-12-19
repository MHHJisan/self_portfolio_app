import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final int currentYear = DateTime.now().year;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        // Matches border-t border-slate-200/70
        border: Border(
          top: BorderSide(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : const Color(0xFFE2E8F0).withValues(alpha: 0.7),
            width: 1,
          ),
        ),
        // Matches bg-white/80 and bg-slate-950/80
        color: isDark
            ? const Color(0xFF020617).withValues(alpha: 0.8)
            : Colors.white.withValues(alpha: 0.8),
      ),
      child: Center(
        child: Text(
          "Designed & built by Mh Haque · © $currentYear",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            // Matches text-slate-500
            color: isDark ? Colors.white70 : const Color(0xFF64748B),
            letterSpacing: 0.2,
          ),
        ),
      ),
    );
  }
}
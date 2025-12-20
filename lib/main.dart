import 'package:flutter/material.dart';
import 'package:self_portfolio_app/theme/colors.dart';
import 'sections/contact_section.dart';
import 'sections/footer_section.dart';
import 'sections/resume_section.dart';
import 'sections/about_section.dart';
import 'sections/award_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/project_section.dart';
import 'sections/services_section.dart';
import 'sections/skills_section.dart';
import 'sections/volunteering_section.dart';
import 'widgets/glass_nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: const Color(0xFF4F46E5),
        scaffoldBackgroundColor: AppColors.slate900,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020617),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolled = false;

  // GlobalKeys to link Navbar clicks to Section scrolls
  final GlobalKey heroSectionKey = GlobalKey();
  final GlobalKey projectsSectionKey = GlobalKey();
  final GlobalKey skillsSectionKey = GlobalKey();
  final GlobalKey aboutSectionKey = GlobalKey();
  final GlobalKey servicesSectionKey = GlobalKey();
  final GlobalKey experienceSectionKey = GlobalKey();
  final GlobalKey contactSectionKey = GlobalKey();


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 8 && !_hasScrolled) {
      setState(() => _hasScrolled = true);
    } else if (_scrollController.offset <= 8 && _hasScrolled) {
      setState(() => _hasScrolled = false);
    }
  }

  // Function to scroll to a given GlobalKey's widget
  void _scrollToSection(GlobalKey key) {
    // If the drawer is open, close it first
    if (Navigator.canPop(context)) Navigator.pop(context);

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate height dynamically to account for the phone's notch/status bar
    final double topPadding = MediaQuery.of(context).padding.top;
    final double navBarHeight = 75 + topPadding;

    return Scaffold(
      endDrawer: _buildDrawer(),
      body: Stack(
        children: [
          const BackgroundWrapper(),
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(height: navBarHeight),
                HeroSection(key: heroSectionKey),
                AboutSection(key: aboutSectionKey),
                ProjectSection(key: projectsSectionKey),
                ServicesSection(key: servicesSectionKey),
                SkillsSection(key: skillsSectionKey),
                ExperienceSection(key: experienceSectionKey),
                AwardsSection(),
                VolunteeringSection(),
                ResumeSection(),
                ContactSection(key: contactSectionKey),
                FooterSection(),
                // const SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GlassNavbar(
              hasScrolled: _hasScrolled,
              // Update these to match your GlassNavbar parameters
              onAboutTap: () => _scrollToSection(aboutSectionKey),
              onProjectTap: () => _scrollToSection(projectsSectionKey),
              onServicesTap: () => _scrollToSection(servicesSectionKey),
              onSkillsTap: () => _scrollToSection(skillsSectionKey),
              onExperienceTap: () => _scrollToSection(experienceSectionKey),
              onContactTap: () => _scrollToSection(contactSectionKey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: isDark ? AppColors.slate900 : Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // _drawerLink("Work", isDark, () => _scrollToSection(projectsSectionKey)),
              _drawerLink("About", isDark, () => _scrollToSection(aboutSectionKey)),
              _drawerLink("Projects", isDark, () => _scrollToSection(projectsSectionKey)),
              _drawerLink("Services", isDark, () => _scrollToSection(servicesSectionKey)),
              _drawerLink("Skills", isDark, () => _scrollToSection(skillsSectionKey)),
              _drawerLink("Experience", isDark, () => _scrollToSection(experienceSectionKey)),

              _drawerLink("Contact", isDark, () => _scrollToSection(contactSectionKey)),

              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: _ctaButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerLink(String title, bool isDark, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 8),
        foregroundColor: isDark ? Colors.white : Colors.cyanAccent,
        backgroundColor: Colors.transparent,
        overlayColor: Colors.transparent,
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _ctaButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4F46E5),
        foregroundColor: Colors.white,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: const Text(
        "Let's talk",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}



class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned.fill( // Added Positioned.fill to ensure it covers the back
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark
                  ? const Color(0xFF020617)
                  : const Color(0x00eef2ff).withValues(alpha: 0.9),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
      ),
    );
  }
}

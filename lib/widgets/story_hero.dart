import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import '../data/story_data.dart';

class StoryHero extends StatefulWidget {
  final VoidCallback onOpenStory;

  const StoryHero({super.key, required this.onOpenStory});

  @override
  State<StoryHero> createState() => _StoryHeroState();
}

class _StoryHeroState extends State<StoryHero> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
    _fadeIn = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 32 : 48,
        horizontal: isMobile ? 20 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: FadeTransition(
            opacity: _fadeIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. Google Top Bar (Grid menu, Google Logo, Profile Avatar)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.apps_rounded,
                      size: 26,
                      color: AppTheme.darkCharcoal,
                    ),

                    // Classic Google Colorful Logo for Selvakumar & Srinithi
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: _buildGoogleDoodleLogo(isMobile),
                        ),
                      ),
                    ),

                    // Avatar badge
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppTheme.darkMaroonAccent,
                        border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          'S',
                          style: AppTheme.monoStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // 2. Google Search Bar Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppTheme.deepBurgundy,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:  0.08),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, size: 22, color: AppTheme.deepBurgundy),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          StoryConfig.openingQuestion,
                          style: AppTheme.handwrittenStyle(
                            fontSize: isMobile ? 22 : 26,
                            color: AppTheme.deepBurgundy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Icon(Icons.mic_none_outlined, size: 20, color: AppTheme.deepBurgundy),
                      const SizedBox(width: 12),
                      const Icon(Icons.camera_alt_outlined, size: 20, color: AppTheme.deepBurgundy),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Search Category Filter Tabs
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _tabItem("ALL", false),
                      _tabItem("IMAGES", true),
                      _tabItem("VIDEO", false),
                      _tabItem("SHOPPING", false),
                      _tabItem("BOOKS", false),
                      _tabItem("MORE", false),
                    ],
                  ),
                ),
                const SizedBox(height: 36),

                // 4. Three Photo Frames Side-by-Side (from reference)
                Row(
                  children: [
                    Expanded(child: _photoBox(StoryConfig.memories[0].imagePath)),
                    const SizedBox(width: 16),
                    Expanded(child: _photoBox(StoryConfig.memories[1].imagePath)),
                    const SizedBox(width: 16),
                    Expanded(child: _photoBox(StoryConfig.memories[2].imagePath)),
                  ],
                ),
                const SizedBox(height: 36),

                // 5. Handwritten Calligraphy Answer Below (Reference image 1)
                Text(
                  "Selvakumar  ♡  Srinithi",
                  textAlign: TextAlign.center,
                  style: AppTheme.romanticCalligraphyStyle(
                    fontSize: isMobile ? 42 : 64,
                    color: AppTheme.deepBurgundy,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "SINCE 2022  ·  FOREVER & ALWAYS",
                  textAlign: TextAlign.center,
                  style: AppTheme.monoStyle(
                    fontSize: isMobile ? 10.5 : 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.8,
                    color: AppTheme.deepBurgundy,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Love means you… just you ♥",
                  textAlign: TextAlign.center,
                  style: AppTheme.serifStyle(
                    fontSize: isMobile ? 22 : 28,
                    color: AppTheme.darkCharcoal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "somewhere between friendship and forever.",
                  textAlign: TextAlign.center,
                  style: AppTheme.serifStyle(
                    fontSize: isMobile ? 18 : 22,
                    fontStyle: FontStyle.italic,
                    color: AppTheme.deepBurgundy,
                  ),
                ),
                const SizedBox(height: 40),

                // 6. Action Button (Featured Dark Maroon Accent)
                InkWell(
                  onTap: widget.onOpenStory,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 36, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppTheme.darkMaroonAccent,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFFD4AF37), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:  0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "OPEN OUR STORY",
                            style: AppTheme.monoStyle(
                              fontSize: 12,
                              color: Colors.white,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.arrow_forward,
                            size: 14,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabItem(String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        children: [
          Text(
            title,
            style: AppTheme.monoStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? AppTheme.deepBurgundy : AppTheme.darkCharcoal,
            ),
          ),
          const SizedBox(height: 6),
          if (isSelected)
            Container(
              width: 32,
              height: 2.5,
              color: AppTheme.deepBurgundy,
            ),
        ],
      ),
    );
  }

  Widget _photoBox(String imagePath) {
    return AspectRatio(
      aspectRatio: 0.85,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.warmPaper,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppTheme.darkCharcoal.withValues(alpha:  0.8), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppTheme.darkCharcoal.withValues(alpha:  0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            cacheWidth: 500,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppTheme.softBeige,
                child: const Center(
                  child: Icon(Icons.favorite_border, color: AppTheme.deepBurgundy, size: 28),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleDoodleLogo(bool isMobile) {
    final fontSize = isMobile ? 24.0 : 38.0;
    const name1 = "Selvakumar";
    const name2 = "Srinithi";

    const googleColors = [
      Color(0xFF4285F4), // Google Blue
      Color(0xFFEA4335), // Google Red
      Color(0xFFFBBC05), // Google Yellow
      Color(0xFF4285F4), // Google Blue
      Color(0xFF34A853), // Google Green
      Color(0xFFEA4335), // Google Red
    ];

    List<InlineSpan> spans = [];

    for (int i = 0; i < name1.length; i++) {
      spans.add(
        TextSpan(
          text: name1[i],
          style: TextStyle(
            color: googleColors[i % googleColors.length],
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    spans.add(
      const TextSpan(
        text: "  &  ",
        style: TextStyle(
          color: Color(0xFFEA4335),
          fontWeight: FontWeight.w900,
        ),
      ),
    );

    for (int i = 0; i < name2.length; i++) {
      spans.add(
        TextSpan(
          text: name2[i],
          style: TextStyle(
            color: googleColors[(i + 2) % googleColors.length],
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.catamaran(
          fontSize: fontSize,
          letterSpacing: 1.0,
        ),
        children: spans,
      ),
    );
  }
}

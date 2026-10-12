import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'photo_viewer.dart';

/// The "FALLING FOR YOU" Editorial Black & White Broadsheet Newspaper Section
/// - 100% High-Contrast Black & White Monochrome Aesthetic
/// - Updated Date: 13 OCT 2026 (Birthday Special Edition)
/// - Pure B&W photography with ITU-R BT.709 grayscale filter
/// - Clean, seamless presentation without unwanted FIG 1 / FIG 2 badges
/// - Giant serif masthead "FALLING FOR YOU" with double-rule dateline
class NewspaperFallingForYouSection extends StatefulWidget {
  const NewspaperFallingForYouSection({super.key});

  @override
  State<NewspaperFallingForYouSection> createState() =>
      _NewspaperFallingForYouSectionState();
}

class _NewspaperFallingForYouSectionState
    extends State<NewspaperFallingForYouSection> {
  // Grayscale matrix for true black-and-white film reproduction
  static const ColorFilter _grayscaleFilter = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ]);

  int? _hoveredPhotoIndex;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 80,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 680), // Editorial broadsheet width
          child: Column(
            children: [
              // Eyebrow Header
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF111111),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "THE BROADSHEET • SPECIAL EDITION",
                            style: AppTheme.monoStyle(
                              fontSize: 10.5,
                              letterSpacing: 1.8,
                              color: const Color(0xFF111111),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF111111),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          "B&W EDITORIAL",
                          style: AppTheme.monoStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: const Color(0xFF111111),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // The Main Black & White Newspaper Page Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Crisp, clean newsprint white
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: const Color(0xFF111111), // Sharp black border
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 36,
                      spreadRadius: 2,
                      offset: const Offset(0, 16),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 36,
                  vertical: isMobile ? 26 : 42,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Giant Newspaper Masthead: FALLING FOR YOU
                    Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "FALLING FOR YOU",
                          style: GoogleFonts.cinzel(
                            fontSize: isMobile ? 38 : 58,
                            fontWeight: FontWeight.w900,
                            letterSpacing: isMobile ? 2.5 : 4.5,
                            color: const Color(0xFF000000), // Pure ink black
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 2. Double-Line Masthead Metadata Sub-bar with updated Date: 13 OCT 2026
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFF000000), width: 1.8),
                          bottom: BorderSide(color: Color(0xFF000000), width: 1.2),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: isMobile
                          ? Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Text(
                                  "13 OCT 2026",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                                Text(
                                  "SINCE 2022 • OUR STORY",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                                Text(
                                  "SRINITHI & SELVAKUMAR",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "13 OCT 2026",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Text("●", style: TextStyle(fontSize: 7, color: Color(0xFF000000))),
                                    const SizedBox(width: 8),
                                    Text(
                                      "SINCE 2022 • OUR STORY",
                                      style: GoogleFonts.cormorantGaramond(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                        color: const Color(0xFF000000),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text("●", style: TextStyle(fontSize: 7, color: Color(0xFF000000))),
                                  ],
                                ),
                                Text(
                                  "SRINITHI & SELVAKUMAR",
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF000000),
                                  ),
                                ),
                              ],
                            ),
                    ),

                    SizedBox(height: isMobile ? 24 : 32),

                    // 3. Article 1: Headline + Left Story Column + Right Clean B&W Shoreline Photo
                    _buildArticleOne(isMobile),

                    SizedBox(height: isMobile ? 28 : 36),

                    // Horizontal Solid Dividing Rule
                    Container(
                      width: double.infinity,
                      height: 1.5,
                      color: const Color(0xFF000000),
                    ),

                    SizedBox(height: isMobile ? 24 : 32),

                    // 4. Article 2: Headline + Sub-italic + Multi-Column Story + Clean B&W Floral Photo
                    _buildArticleTwo(isMobile),

                    const SizedBox(height: 28),

                    // 5. Newspaper Bottom Colophon Bar with 13 October 2026 Birthday Dedication
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 14),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Color(0xFF000000), width: 1.0),
                        ),
                      ),
                      child: isMobile
                          ? Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 8,
                              runSpacing: 4,
                              children: [
                                Text(
                                  "PUBLISHED FOR SELVAKUMAR'S BIRTHDAY • 13 OCT 2026",
                                  style: AppTheme.monoStyle(
                                    fontSize: 8.5,
                                    letterSpacing: 0.8,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                                Text(
                                  "PAGE NO. 1 OF FOREVER",
                                  style: AppTheme.monoStyle(
                                    fontSize: 8.5,
                                    letterSpacing: 0.8,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "PUBLISHED FOR SELVAKUMAR'S BIRTHDAY • 13 OCT 2026",
                                  style: AppTheme.monoStyle(
                                    fontSize: 9,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                                Text(
                                  "PAGE NO. 1 OF FOREVER",
                                  style: AppTheme.monoStyle(
                                    fontSize: 9,
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF333333),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Article 1: "I don't want to be your friend, I want to kiss your neck"
  Widget _buildArticleOne(bool isMobile) {
    return isMobile
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "I don't want to be your friend, I want to kiss your neck",
                style: GoogleFonts.cormorantGaramond(
                  fontSize: 29,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                  color: const Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 16),
              _buildBwPhoto(
                photoPath: 'assets/photos/beach_standing.jpg',
                fallbackPath: 'assets/photos/sunset_selfie.jpg',
                memoryIndex: 1,
                hoverIndex: 1,
                height: 230,
              ),
              const SizedBox(height: 16),
              _buildArticleOneText(),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Headline + Narrative
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "I don't want to be your friend, I want to kiss your neck",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                        color: const Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: 50,
                      height: 1.2,
                      color: const Color(0xFF000000),
                    ),
                    const SizedBox(height: 14),
                    _buildArticleOneText(),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              // Right: Clean B&W Shoreline Photo
              Expanded(
                flex: 5,
                child: _buildBwPhoto(
                  photoPath: 'assets/photos/beach_standing.jpg',
                  fallbackPath: 'assets/photos/sunset_selfie.jpg',
                  memoryIndex: 1,
                  hoverIndex: 1,
                  height: 260,
                ),
              ),
            ],
          );
  }

  Widget _buildArticleOneText() {
    return Text(
      "What time you coming out? We started losing light. I'll never make it right. If you don't wander off. "
      "I'm so excited for the night. All we need's my bike and your enormous house. You said some day we might. "
      "When I'm closer to your height, Till then we'll knock around and see. If you're all I need. "
      "Somewhere between our late-night rides and unspoken glances, friendship gently melted away, and I realized there was nowhere in this universe I’d rather be than wrapped in your arms.",
      style: GoogleFonts.cormorantGaramond(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: const Color(0xFF1A1A1A),
      ),
      textAlign: TextAlign.justify,
    );
  }

  /// Article 2: "Don't you see me? I think I'm falling, I'm falling for you"
  Widget _buildArticleTwo(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Headline
        Text(
          "Don't you see me? I\nI think I'm falling, I'm falling for you",
          style: GoogleFonts.cormorantGaramond(
            fontSize: isMobile ? 26 : 34,
            fontWeight: FontWeight.w700,
            height: 1.15,
            color: const Color(0xFF000000),
          ),
        ),
        const SizedBox(height: 6),
        // Sub-headline italic
        Text(
          "And don't you need me? I",
          style: GoogleFonts.cormorantGaramond(
            fontSize: isMobile ? 18 : 22,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),

        const SizedBox(height: 18),

        // Multi-Column Text + Clean B&W Floral Photo
        isMobile
            ? Column(
                children: [
                  _buildBwPhoto(
                    photoPath: 'assets/photos/garden_flower_01.jpg',
                    fallbackPath: 'assets/photos/pink_flowers.jpg',
                    memoryIndex: 6,
                    hoverIndex: 2,
                    height: 210,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "I think I'm falling, I'm falling for you. On this night, and in this light. "
                    "I think I'm falling (I think I'm falling), I'm falling for you. And maybe you, change your mind. "
                    "(I think I'm falling, I think I'm falling.) I'm caught on your coat again. You said, 'Oh no, it's fine'. "
                    "I read between the lines and touched your leg again (again). I'll take it one day at a time. "
                    "Soon you will be mine, oh. But I want you now (I want you now.) When the smoke is in your eyes, you look so alive. "
                    "Do you fancy sitting down with maybe. 'Cause you're all I need. According to your heart. My place is not deliberate. "
                    "Feeling of your arms. Don't you see me? I, I think I'm falling, I'm falling for you. And don't you need me? "
                    "I. I think I'm falling, I'm falling for you. On this night, and in this light. I think I'm falling. "
                    "And maybe you, change your mind.",
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 15.5,
                      height: 1.5,
                      color: const Color(0xFF1A1A1A),
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column A
                  Expanded(
                    flex: 3,
                    child: Text(
                      "I think I'm falling, I'm falling for you. On this night, and in this light. I think I'm falling (I think I'm falling), I'm falling for you. "
                      "And maybe you, change your mind. (I think I'm falling, I think I'm falling.) I'm caught on your coat again. You said, 'Oh no, it's fine'. "
                      "I read between the lines and touched your leg again (again). I'll take it one day at a time. Soon you will be mine, oh. "
                      "But I want you now (I want you now.) When the smoke is in your eyes, you look so alive.",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 15.5,
                        height: 1.48,
                        color: const Color(0xFF1A1A1A),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(width: 18),
                  // Column B
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Do you fancy sitting down with maybe. 'Cause you're all I need. According to your heart. My place is not deliberate. "
                      "Feeling of your arms. Don't you see me? I, I think I'm falling, I'm falling for you. And don't you need me? "
                      "I. I think I'm falling, I'm falling for you. On this night, and in this light. I think I'm falling (I think I'm falling), "
                      "I'm falling for you And maybe you, change your mind.",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 15.5,
                        height: 1.48,
                        color: const Color(0xFF1A1A1A),
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const SizedBox(width: 18),
                  // Column C: Clean B&W Floral Photo
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBwPhoto(
                          photoPath: 'assets/photos/garden_flower_01.jpg',
                          fallbackPath: 'assets/photos/pink_flowers.jpg',
                          memoryIndex: 6,
                          hoverIndex: 2,
                          height: 190,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "“On this night, and in this light. I think I'm falling for you.”",
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xFF444444),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  /// Clean, Aesthetic Black & White Photo with Grayscale Filter & No Unwanted Badges
  Widget _buildBwPhoto({
    required String photoPath,
    required String fallbackPath,
    required int memoryIndex,
    required int hoverIndex,
    required double height,
  }) {
    final isHovered = _hoveredPhotoIndex == hoverIndex;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredPhotoIndex = hoverIndex),
      onExit: (_) => setState(() => _hoveredPhotoIndex = null),
      child: GestureDetector(
        onTap: () {
          PhotoViewerDialog.show(context, StoryConfig.memories, memoryIndex);
        },
        child: AnimatedScale(
          scale: isHovered ? 1.02 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              border: Border.all(color: const Color(0xFF111111), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isHovered ? 0.2 : 0.08),
                  blurRadius: isHovered ? 12 : 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.zero,
              child: ColorFiltered(
                // High-contrast true monochrome photographic filter
                colorFilter: _grayscaleFilter,
                child: Image.asset(
                  photoPath,
                  fit: BoxFit.cover,
                  cacheWidth: 600,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    fallbackPath,
                    fit: BoxFit.cover,
                    cacheWidth: 600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

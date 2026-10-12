import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/story_data.dart';
import '../models/memory.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'photo_viewer.dart';

/// Section 06 — The "Home" 3x3 Editorial Art Print & Couple Grid
/// Recreated faithfully from the user's reference design:
/// - 3x3 monochrome couple photo grid
/// - Large editorial serif title: "Home"
/// - Phonetic pronunciation: "/ hōm / noun"
/// - Horizontal dividing rule
/// - The poetic dictionary definition of Home as a tight hug and safe sanctuary.
class PhotoCollage extends StatefulWidget {
  const PhotoCollage({super.key});

  @override
  State<PhotoCollage> createState() => _PhotoCollageState();
}

class _PhotoCollageState extends State<PhotoCollage> {
  // Toggle between classic B&W film aesthetic (as in the reference image) and full color
  bool _isBlackAndWhite = true;
  int? _hoveredIndex;

  // Standard photographic grayscale luminance matrix (ITU-R BT.709)
  static const ColorFilter _grayscaleFilter = ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
  ]);

  // The 9 curated authentic couple photos of Selvakumar & Srinithi for the 3x3 grid
  List<Memory> get _gridMemories {
    final all = StoryConfig.memories;
    if (all.length >= 9) {
      // Pick 9 diverse couple memories (beach, traditional, casual, events, temple, candid, sunset, blossoms)
      return [
        all[0],  // Beach walk
        all[1],  // Beach standing laughing
        all[2],  // Traditional veshti & saree
        all[3],  // Matching white tees
        all[4],  // Celebration night
        all[5],  // Temple visit
        all[6],  // Frangipani glance
        all.length > 11 ? all[11] : all[7], // Sunset golden hour
        all.length > 12 ? all[12] : all[8], // Hilltop summit
      ];
    }
    return all.take(9).toList();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final memories = _gridMemories;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 80,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620), // Art print width for optimal 3x3 proportions
          child: Column(
            children: [
              // Subtle section eyebrow & B&W toggle
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
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
                              color: AppTheme.deepBurgundy,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "DEFINITION OF US",
                            style: AppTheme.monoStyle(
                              fontSize: 11,
                              letterSpacing: 2.2,
                              color: AppTheme.deepBurgundy,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                    // Monochrome / Full-color aesthetic toggle
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isBlackAndWhite = !_isBlackAndWhite;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFDCD6CE),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _isBlackAndWhite ? Icons.filter_b_and_w : Icons.palette_outlined,
                              size: 14,
                              color: AppTheme.deepBurgundy,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _isBlackAndWhite ? "B&W Film" : "Color",
                              style: AppTheme.monoStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.darkCharcoal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

              // The Main "Home" Editorial Art Print Card
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xFFE8E3DC),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1B1B1B).withValues(alpha: 0.08),
                      blurRadius: 36,
                      spreadRadius: 2,
                      offset: const Offset(0, 16),
                    ),
                    BoxShadow(
                      color: const Color(0xFF1B1B1B).withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 22 : 36,
                  vertical: isMobile ? 28 : 42,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. 3x3 Photo Grid
                    _buildThreeByThreeGrid(memories, isMobile),

                    SizedBox(height: isMobile ? 32 : 44),

                    // 2. Large Editorial Headline: "Home"
                    Text(
                      "Home",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 54 : 68,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A1A),
                        letterSpacing: -1.0,
                        height: 0.95,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 3. Pronunciation & Part of Speech: / hōm / noun
                    Text(
                      "/ hōm / noun",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 19 : 22,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4A4A4A),
                        letterSpacing: 0.5,
                      ),
                    ),

                    SizedBox(height: isMobile ? 12 : 16),

                    // 4. Solid Black Divider Line
                    Container(
                      width: double.infinity,
                      height: 1.5,
                      color: const Color(0xFF1A1A1A),
                    ),

                    SizedBox(height: isMobile ? 16 : 22),

                    // 5. The Moving Dictionary Definition of Home
                    Text(
                      "A place that feels like a tight hug: Where time stands still for just a moment, where the noise of the outside world is blocked out and where you can breathe it all out after being tense all day. From the moment you enter the door, you are safe, you are warm and you are exceptionally loved.",
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 17 : 20.5,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF222222),
                        height: 1.55,
                        letterSpacing: 0.15,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 6. Subtle Bottom Signature / Interactive Stamp
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SELVAKUMAR & SRINITHI",
                            style: AppTheme.monoStyle(
                              fontSize: 9.5,
                              letterSpacing: 1.8,
                              color: const Color(0xFF88827C),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.touch_app_outlined,
                                size: 11,
                                color: Color(0xFF88827C),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "tap any photo to view memory",
                                style: AppTheme.monoStyle(
                                  fontSize: 9.5,
                                  letterSpacing: 0.8,
                                  color: const Color(0xFF88827C),
                                ),
                              ),
                            ],
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

  /// Builds the 3x3 photo grid matching the reference image
  Widget _buildThreeByThreeGrid(List<Memory> memories, bool isMobile) {
    const double gutter = 7.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final itemWidth = (totalWidth - (gutter * 2)) / 3;

        return Column(
          children: [
            for (int row = 0; row < 3; row++) ...[
              if (row > 0) const SizedBox(height: gutter),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int col = 0; col < 3; col++) ...[
                    if (col > 0) const SizedBox(width: gutter),
                    SizedBox(
                      width: itemWidth,
                      height: itemWidth * 1.08, // Subtle portrait proportion like reference image
                      child: _buildPhotoCell(
                        memories: memories,
                        index: (row * 3) + col,
                        itemWidth: itemWidth,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        );
      },
    );
  }

  /// Single photo cell with black & white filter, hover zoom, and tap to view
  Widget _buildPhotoCell({
    required List<Memory> memories,
    required int index,
    required double itemWidth,
  }) {
    if (index >= memories.length) {
      return Container(color: const Color(0xFFF0EBE5));
    }

    final memory = memories[index];
    final isHovered = _hoveredIndex == index;

    Widget photoWidget = Image.asset(
      memory.imagePath,
      fit: BoxFit.cover,
      cacheWidth: 500,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFFEBE6DF),
          child: const Center(
            child: Icon(Icons.favorite, size: 20, color: Color(0xFFC0B8AE)),
          ),
        );
      },
    );

    // Apply grayscale filter if in B&W mode (and not currently hovered)
    if (_isBlackAndWhite && !isHovered) {
      photoWidget = ColorFiltered(
        colorFilter: _grayscaleFilter,
        child: photoWidget,
      );
    }

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: GestureDetector(
        onTap: () {
          // Open high-res memory viewer
          PhotoViewerDialog.show(context, StoryConfig.memories, index);
        },
        child: AnimatedScale(
          scale: isHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF2ECE4),
              borderRadius: BorderRadius.circular(2),
              boxShadow: isHovered
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            clipBehavior: Clip.antiAlias,
            child: photoWidget,
          ),
        ),
      ),
    );
  }
}

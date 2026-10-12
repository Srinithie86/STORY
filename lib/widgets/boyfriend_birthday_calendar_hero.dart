import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';

/// Single Unique October 13 Calendar Card with Selvakumar Photo Background.
/// Features:
/// 1. Selvakumar Gym / Couple photo clearly visible through a delicate frosted glass veil.
/// 2. Day 13 highlighted ONLY with a romantic lipstick kiss 💋 aesthetic (no crude drawn heart).
/// 3. Interactive floating kisses when Day 13 is tapped.
/// 4. Photo toggle between Gym photo, Couple Car photo, and Beach photo.
class BoyfriendBirthdayCalendarHero extends StatefulWidget {
  final String gymPhotoPath;
  final int highlightDay; // 13 for Oct 13

  const BoyfriendBirthdayCalendarHero({
    super.key,
    this.gymPhotoPath = 'assets/photos/selvakumar_gym.png',
    this.highlightDay = 13,
  });

  @override
  State<BoyfriendBirthdayCalendarHero> createState() =>
      _BoyfriendBirthdayCalendarHeroState();
}

class _BoyfriendBirthdayCalendarHeroState
    extends State<BoyfriendBirthdayCalendarHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _kissPulseController;
  late int _selectedPhotoIndex;
  final List<String> _photos = [
    'assets/photos/selvakumar_gym.png',
    'assets/photos/who_is_he_couple_car.jpg',
    'assets/photos/selvakumar_beach.png',
  ];

  final List<_FloatingKiss> _floatingKisses = [];
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _selectedPhotoIndex = 0;
    _kissPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _kissPulseController.dispose();
    super.dispose();
  }

  void _triggerKissBurst() {
    setState(() {
      for (int i = 0; i < 7; i++) {
        _floatingKisses.add(_FloatingKiss(
          x: 140 + _rnd.nextDouble() * 120,
          y: 320 + _rnd.nextDouble() * 60,
          vx: (_rnd.nextDouble() - 0.5) * 3.5,
          vy: -2.5 - _rnd.nextDouble() * 3.0,
          emoji: i % 2 == 0 ? "💋" : "💖",
          size: 18 + _rnd.nextDouble() * 10,
        ));
      }
    });

    Future.delayed(const Duration(milliseconds: 1400), () {
      if (mounted) {
        setState(() {
          _floatingKisses.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final activePhoto = _photos[_selectedPhotoIndex];

    return RepaintBoundary(
      child: Container(
        width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isMobile ? 360 : 470,
        minHeight: isMobile ? 540 : 620,
      ),
      margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFD4AF37), // Zari Champagne Gold Border
          width: 2.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B1220).withValues(alpha: 0.18),
            blurRadius: 32,
            offset: const Offset(0, 14),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            // 1. Photo Background — Crystal Clear & Fully Visible to the Users
            Positioned.fill(
              child: Image.asset(
                activePhoto,
                fit: BoxFit.cover,
                cacheWidth: 600,
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF420008),
                    child: const Center(
                      child: Icon(Icons.favorite, color: Colors.white, size: 40),
                    ),
                  );
                },
              ),
            ),

            // 2. Very subtle warm luminous tint so the photo is vibrant and visible
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.10),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.25),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),
            ),

            // 3. Top Switcher Pill: Tap to change background photo
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedPhotoIndex =
                        (_selectedPhotoIndex + 1) % _photos.length;
                  });
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFD4AF37),
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.touch_app_rounded,
                          size: 11, color: Color(0xFF8B1220)),
                      const SizedBox(width: 4),
                      Text(
                        _selectedPhotoIndex == 0
                            ? "Gym 💪"
                            : _selectedPhotoIndex == 1
                                ? "Couple ♡"
                                : "Beach 🌊",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF8B1220),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 4. Frosted Glassmorphic Veil — Translucent so the background photo shines through without scroll lag!
            Center(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 22),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.44), // Translucent Glass Veil!
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.75),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                        // Top Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFD4AF37)
                                  .withValues(alpha: 0.6),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            "SINCE 2022  ·  CELEBRATING 24 YEARS",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: isMobile ? 10.5 : 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.2,
                              color: const Color(0xFF8B1220),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Calligraphic Month Header ("~ October ~")
                        Text(
                          "~ October ~",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.greatVibes(
                            fontSize: isMobile ? 48 : 58,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF380811),
                            shadows: [
                              Shadow(
                                color: Colors.white.withValues(alpha: 0.95),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "2026",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: isMobile ? 22 : 28,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 3.0,
                            color: const Color(0xFF8B1220),
                            shadows: [
                              Shadow(
                                color: Colors.white.withValues(alpha: 0.95),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Calendar Grid (Day 13 highlighted ONLY with romantic kiss 💋)
                        _buildCalendarGrid(isMobile),

                        const SizedBox(height: 16),

                        // Romantic Kiss Footer Badge
                        GestureDetector(
                          onTap: _triggerKissBurst,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5.5),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.90),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFD4AF37),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("💋",
                                      style: TextStyle(fontSize: 13)),
                                  const SizedBox(width: 6),
                                  Text(
                                    "OCTOBER 13 · BIRTHDAY KISS FOR MY BOY ♡",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: isMobile ? 9 : 10.5,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.0,
                                      color: const Color(0xFF8B1220),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text("💋",
                                      style: TextStyle(fontSize: 13)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

            // 5. Floating Interactive Romantic Kisses 💋
            ..._floatingKisses.map((k) {
              return Positioned(
                left: k.x,
                top: k.y,
                child: Opacity(
                  opacity: k.opacity,
                  child: Text(
                    k.emoji,
                    style: TextStyle(fontSize: k.size),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    ),
    );
  }

  /// Clean Calendar Grid for October 2026
  /// Highlighting Oct 13 ONLY with romantic lipstick kiss 💋 aesthetic
  Widget _buildCalendarGrid(bool isMobile) {
    const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    // October 2026 starts on Thursday (index 4)
    const firstDayOffset = 4;
    const totalDays = 31;

    final cellStyle = GoogleFonts.caveat(
      fontSize: isMobile ? 21 : 26,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1E1014),
      shadows: [
        Shadow(
          color: Colors.white.withValues(alpha: 0.95),
          blurRadius: 4,
        ),
      ],
    );

    final headerStyle = GoogleFonts.caveat(
      fontSize: isMobile ? 20 : 25,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF8B1220),
      shadows: [
        Shadow(
          color: Colors.white.withValues(alpha: 0.95),
          blurRadius: 4,
        ),
      ],
    );

    return Column(
      children: [
        // Days of the week row
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysOfWeek.map((day) {
              return SizedBox(
                width: 38,
                child: Center(
                  child: Text(day, style: headerStyle),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),

        // 5-week Calendar Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 35, // 5 rows * 7 days
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemBuilder: (context, index) {
            final dayNumber = index - firstDayOffset + 1;

            if (dayNumber < 1 || dayNumber > totalDays) {
              return const SizedBox.shrink();
            }

            final isHighlighted = (dayNumber == widget.highlightDay);

            if (isHighlighted) {
              return Center(
                child: GestureDetector(
                  onTap: _triggerKissBurst,
                  child: AnimatedBuilder(
                    animation: _kissPulseController,
                    builder: (context, child) {
                      final scale =
                          0.96 + (_kissPulseController.value * 0.08);

                      return Transform.scale(
                        scale: scale,
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            // Romantic Rose Lipstick Glow Halo
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFE0E6)
                                    .withValues(alpha: 0.85),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFFF2D55),
                                  width: 1.8,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFFF2D55)
                                        .withValues(alpha: 0.40),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  '$dayNumber',
                                  style: cellStyle.copyWith(
                                    color: const Color(0xFFC2185B), // Romantic Crimson
                                    fontWeight: FontWeight.w900,
                                    fontSize: isMobile ? 22 : 27,
                                  ),
                                ),
                              ),
                            ),

                            // ONLY ROMANTIC KISS 💋 stamped on the date!
                            Positioned(
                              top: -7,
                              right: -6,
                              child: Transform.rotate(
                                angle: -0.15,
                                child: const Text(
                                  "💋",
                                  style: TextStyle(
                                    fontSize: 16,
                                    shadows: [
                                      Shadow(
                                        color: Color(0xFFFF4081),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }

            return Center(
              child: Text(
                '$dayNumber',
                style: cellStyle,
              ),
            );
          },
        ),
      ],
    );
  }
}

/// Floating romantic kiss particle for interactive tap
class _FloatingKiss {
  double x;
  double y;
  double vx;
  double vy;
  String emoji;
  double size;
  double opacity = 1.0;

  _FloatingKiss({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.emoji,
    required this.size,
  });
}

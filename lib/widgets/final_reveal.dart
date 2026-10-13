import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/story_data.dart';
import '../utils/responsive.dart';
import 'who_is_he_movie_credits.dart';

/// 100% Template-Matched "BEST BOYFRIEND IN THE WORLD" Full-Screen Official Certificate Widget.
/// Exactly replicates the classic diploma award template (gold starburst seal, ornate guilloche border,
/// formal citation text, and Srinithi's calligraphic signature).
class FinalRevealSection extends StatelessWidget {
  final VoidCallback? onReplayStory;

  const FinalRevealSection({
    super.key,
    this.onReplayStory,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent, // Background video runs continuously and remains fully visible
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 40 : 80,
        horizontal: isMobile ? 12 : 28,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1040), // Full-Screen Cover Width
          child: Column(
            children: [
              // 1. Main Full-Screen Classic Certificate Template
              const _ClassicBestBoyfriendCertificate(),
              const SizedBox(height: 48),

              // 2. "WHO IS HE?" Cinematic Movie Credits Pet Name Reel with Selvakumar's Gym Photo
              const WhoIsHeMovieCreditsSection(),
              const SizedBox(height: 48),

              // 3. Grand Cinematic Movie End Card & Replay Action
              _CinematicMovieEndCard(onReplayStory: onReplayStory),
            ],
          ),
        ),
      ),
    );
  }
}

/// 100% Reference-Matched Classic Award Certificate Card
class _ClassicBestBoyfriendCertificate extends StatelessWidget {
  const _ClassicBestBoyfriendCertificate();

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F6EE), // Cream Vintage Diploma Paper
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 36,
            spreadRadius: 2,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: CustomPaint(
        painter: const _ClassicCertificateFramePainter(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 64,
            vertical: isMobile ? 36 : 64,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              // 1. MAIN TITLE: BEST BOYFRIEND IN THE WORLD
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  children: [
                    Text(
                      "BEST BOYFRIEND",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: isMobile ? 36 : 54,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3.0,
                        color: const Color(0xFF1C252C),
                        height: 1.05,
                      ),
                    ),
                    Text(
                      "IN THE WORLD",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cinzel(
                        fontSize: isMobile ? 32 : 48,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4.0,
                        color: const Color(0xFF1C252C),
                        height: 1.10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // 2. SUB-CAPTION: This certificate acknowledges that
              Text(
                "This certificate acknowledges that",
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isMobile ? 18 : 24,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF37474F),
                ),
              ),
              const SizedBox(height: 16),

              // 3. RECIPIENT NAME: Selvakumar
              Text(
                StoryConfig.boyName,
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isMobile ? 38 : 56,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: const Color(0xFF1A2327),
                ),
              ),
              const SizedBox(height: 8),

              // Divider Line
              Container(
                width: isMobile ? 220 : 440,
                height: 1.2,
                color: const Color(0xFF78909C),
              ),
              const SizedBox(height: 28),

              // 4. OFFICIAL CITATION PARAGRAPH
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 680),
                child: Column(
                  children: [
                    Text(
                      "Has been officially designated",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 18 : 23,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263238),
                      ),
                    ),
                    Text(
                      "He's the perfectest man I've ever known",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 18 : 23,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263238),
                      ),
                    ),
                    Text(
                      "and he's the love of my life.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 18 : 23,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263238),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "With constant loving, caring and sharing, I am proud to",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 17 : 22,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263238),
                      ),
                    ),
                    Text(
                      "issue you with this award of excellence.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 17 : 22,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263238),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "I appreciate you so much",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 18 : 23,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263238),
                      ),
                    ),
                    Text(
                      "and love you dearly.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 18 : 23,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF263238),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 44),

              // 5. BOTTOM ROW: Gold Starburst Seal, Date, and Calligraphic Signature
              LayoutBuilder(
                builder: (context, constraints) {
                  final isSmall = constraints.maxWidth < 600;

                  return isSmall
                      ? Column(
                          children: [
                            const CustomPaint(
                              size: Size(80, 80),
                              painter: _GoldStarburstSealPainter(),
                            ),
                            const SizedBox(height: 24),
                            _buildDateAndSignature(isMobile),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const CustomPaint(
                              size: Size(96, 96),
                              painter: _GoldStarburstSealPainter(),
                            ),
                            _buildDateAndSignature(isMobile),
                          ],
                        );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildDateAndSignature(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Calligraphic Signature
        Text(
          StoryConfig.girlName, // Srinithi
          style: GoogleFonts.greatVibes(
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1C252C),
          ),
        ),
        Container(
          width: isMobile ? 180 : 240,
          height: 1.2,
          color: const Color(0xFF2C2523),
        ),
        const SizedBox(height: 8),
        Text(
          "13 October 2026",
          style: GoogleFonts.cormorantGaramond(
            fontSize: isMobile ? 16 : 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF37474F),
          ),
        ),
      ],
    );
  }
}

/// Custom Painter for Ornate Golden Guilloche Border Frame around Certificate
class _ClassicCertificateFramePainter extends CustomPainter {
  const _ClassicCertificateFramePainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final w = size.width;
    final h = size.height;

    final outerGold = Paint()
      ..color = const Color(0xFFC5A059)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;

    final innerGold = Paint()
      ..color = const Color(0xFFD4AF37)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final thinGold = Paint()
      ..color = const Color(0xFFB8860B).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Outer Scalloped Frame Padding
    const p = 14.0;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(p, p, w - (p * 2), h - (p * 2)), const Radius.circular(8)), outerGold);

    // Inner Double Rules
    const p2 = 26.0;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(p2, p2, w - (p2 * 2), h - (p2 * 2)), const Radius.circular(4)), innerGold);

    const p3 = 30.0;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(p3, p3, w - (p3 * 2), h - (p3 * 2)), const Radius.circular(4)), thinGold);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Painter for Official Gold Starburst Scalloped Foil Seal Stamp
class _GoldStarburstSealPainter extends CustomPainter {
  const _GoldStarburstSealPainter();

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final w = size.width;
    final h = size.height;
    final center = Offset(w * 0.5, h * 0.5);
    final outerRadius = w * 0.48;
    final innerRadius = w * 0.40;

    final path = Path();
    const points = 32; // 32 Starburst Scallop Teeth
    final angleStep = (pi * 2) / points;

    for (int i = 0; i < points; i++) {
      final angle = i * angleStep;
      final r = (i % 2 == 0) ? outerRadius : innerRadius;
      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // Gold Foil Gradient Fill
    final goldGradient = const LinearGradient(
      colors: [
        Color(0xFFFFD700),
        Color(0xFFE6C200),
        Color(0xFFC5A059),
        Color(0xFFF0E68C),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(path, Paint()..shader = goldGradient);
    canvas.drawPath(path, Paint()..color = const Color(0xFFB8860B)..style = PaintingStyle.stroke..strokeWidth = 1.5);

    // Inner Gold Ring
    canvas.drawCircle(center, outerRadius * 0.72, Paint()..color = const Color(0xFFB8860B)..style = PaintingStyle.stroke..strokeWidth = 1.5);
    canvas.drawCircle(center, outerRadius * 0.65, Paint()..color = const Color(0xFFDAA520)..style = PaintingStyle.stroke..strokeWidth = 1.0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Grand Cinematic Romantic Movie End Card
/// Features:
/// 1. Full-screen letterboxed 35mm film still with couple car photograph & subtitles.
/// 2. Elegant typography with emotional focal point ("~ The End ~ Or rather, our beginning").
/// 3. Refined film credits (Starring, Directed by, Soundtrack, Runtime).
/// 4. Interactive Heartbeat sender counter.
/// 5. Prominent "REPLAY OUR STORY ↺" smooth scroll action back to the start.
/// 6. Warm sunset-inspired ivory, muted rose, burgundy and golden-hour colors.
class _CinematicMovieEndCard extends StatefulWidget {
  final VoidCallback? onReplayStory;

  const _CinematicMovieEndCard({this.onReplayStory});

  @override
  State<_CinematicMovieEndCard> createState() => _CinematicMovieEndCardState();
}

class _CinematicMovieEndCardState extends State<_CinematicMovieEndCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  int _heartbeatsSent = 1000;
  bool _justTapped = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onSendHeartbeat() {
    setState(() {
      _heartbeatsSent++;
      _justTapped = true;
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _justTapped = false);
    });
  }

  void _handleReplay(BuildContext context) {
    if (widget.onReplayStory != null) {
      widget.onReplayStory!();
    } else {
      final scrollable = Scrollable.maybeOf(context);
      if (scrollable != null) {
        scrollable.position.animateTo(
          0.0,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        // Luminous Translucent Warm Cream Frosted Glass Veil:
        // Background video & textures shine through continuously!
        color: const Color(0xFFFFFDF9).withValues(alpha: 0.74),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.65), // Antique Champagne Gold
          width: 1.8,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF722F37).withValues(alpha: 0.12),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Column(
          children: [
            // 1. Subtle Golden-Hour Top Highlight Bar
            Container(
              height: 2.5,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF722F37),
                    Color(0xFFD4AF37),
                    Color(0xFFFFF9F1),
                    Color(0xFFD4AF37),
                    Color(0xFF722F37),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 18 : 48,
                vertical: isMobile ? 32 : 56,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 2. Cinematic Clapperboard Header Pill in Warm Cream
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4EE).withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFD7A6A1),
                          width: 1.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF722F37).withValues(alpha: 0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("🎬", style: TextStyle(fontSize: 13)),
                          const SizedBox(width: 8),
                          Text(
                            "THE FINAL SCENE · A LIFETIME PRODUCTION",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isMobile ? 9.5 : 11,
                              letterSpacing: 2.2,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF722F37),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text("✨", style: TextStyle(fontSize: 13)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 3. 35mm Gallery Framed Film Still of Selva & Srinithi
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? 340 : 540,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9F1),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.70),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF722F37).withValues(alpha: 0.12),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Letterbox Top Bar with Film Stamp
                          Container(
                            color: const Color(0xFFFFF2EC).withValues(alpha: 0.95),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "KODAK VISION3 · 35MM",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 8.5,
                                      letterSpacing: 1.5,
                                      color: const Color(0xFF80604B),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Text(
                                    "SCENE 24 · TAKE ∞",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 8.5,
                                      letterSpacing: 1.5,
                                      color: const Color(0xFF722F37),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Framed Couple Photograph
                          AspectRatio(
                            aspectRatio: 16 / 10,
                            child: Image.asset(
                              'assets/photos/who_is_he_couple_car.jpg',
                              fit: BoxFit.cover,
                              alignment: const Alignment(0, -0.2),
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFFFF2EC),
                                  child: const Center(
                                    child: Icon(Icons.favorite, color: Color(0xFF722F37), size: 36),
                                  ),
                                );
                              },
                            ),
                          ),

                          // Subtitle Dialogue Bar
                          Container(
                            width: double.infinity,
                            color: const Color(0xFFFFF2EC).withValues(alpha: 0.95),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                            child: Text(
                              "“You made me realize what forever feels like.”",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: isMobile ? 13 : 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF380811),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 4. Emotional Title: ~ The End ~
                  Text(
                    "~ The End ~",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.greatVibes(
                      fontSize: isMobile ? 44 : 58,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4A0E17), // Rich Majestic Wine
                      shadows: [
                        Shadow(
                          color: Colors.white.withValues(alpha: 0.95),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    "Or rather, the beautiful start of every tomorrow with you.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: isMobile ? 17 : 21,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF282522),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 5. Final Message Quote with Whitespace & Intimacy
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Text(
                      "“${StoryConfig.finalFooterText}”",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 21 : 27,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        height: 1.45,
                        color: const Color(0xFF722F37),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 580),
                    child: Text(
                      "A digital sanctuary crafted with infinite love. Whenever your heart searches for quiet comfort, every laughter, every walk, and every promise is kept safe right here.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isMobile ? 12 : 14,
                        color: const Color(0xFF4A3B32),
                        height: 1.6,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "~ No matter where life leads us, my heart will always choose you ♡ — Srinithi ~",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(
                      fontSize: isMobile ? 18 : 22,
                      color: const Color(0xFFC2185B),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 6. Refined Film-Credit Style Block in Warm Blush/Ivory
                  Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 640),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4EE).withValues(alpha: 0.88),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFB69A68).withValues(alpha: 0.45),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF722F37).withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Wrap(
                      alignment: WrapAlignment.spaceAround,
                      spacing: 20,
                      runSpacing: 12,
                      children: [
                        _buildCreditItem("STARRING", "Selvakumar & Srinithi", isMobile),
                        _buildCreditItem("DIRECTED BY", "Love & Destiny", isMobile),
                        _buildCreditItem("SOUNDTRACK", "Un Kaiyil En Peyar ♡", isMobile),
                        _buildCreditItem("RUNTIME", "2022 → Forever", isMobile),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 7. Interactive Heartbeat Button & Replay Action Row
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      // Heartbeat Sender in Soft Rose Glass
                      GestureDetector(
                        onTap: _onSendHeartbeat,
                        child: AnimatedScale(
                          scale: _justTapped ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 180),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 16 : 22,
                              vertical: isMobile ? 11 : 13,
                            ),
                            decoration: BoxDecoration(
                              color: _justTapped ? const Color(0xFFFFE0E6) : const Color(0xFFFFF0F3),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: _justTapped
                                    ? const Color(0xFFFF4D6D)
                                    : const Color(0xFFD7A6A1),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFFFF2D55).withValues(alpha: 0.12),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ScaleTransition(
                                    scale: _pulseAnimation,
                                    child: const Icon(
                                      Icons.favorite_rounded,
                                      size: 16,
                                      color: Color(0xFFFF4D6D),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _justTapped
                                        ? "Heartbeat Received ♡"
                                        : "Send a Heartbeat (${_heartbeatsSent.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')})",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: isMobile ? 11 : 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF722F37),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Replay Story Action Button (Returns to top smoothly)
                      ElevatedButton.icon(
                        onPressed: () => _handleReplay(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF722F37), // Muted Burgundy
                          foregroundColor: Colors.white,
                          elevation: 6,
                          shadowColor: const Color(0xFF722F37).withValues(alpha: 0.40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(color: Color(0xFFE2C89A), width: 1.4),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 20 : 28,
                            vertical: isMobile ? 11 : 13,
                          ),
                        ),
                        icon: const Icon(Icons.replay_rounded, size: 16, color: Color(0xFFE2C89A)),
                        label: Text(
                          "REPLAY OUR STORY ↺",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: isMobile ? 11 : 12.5,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.2,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // 8. Elegant Minimal Divider & Couple Citation
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: isMobile ? 36 : 70,
                        height: 1,
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.45),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "◆",
                          style: TextStyle(
                            fontSize: 9,
                            color: const Color(0xFFB69A68),
                          ),
                        ),
                      ),
                      Container(
                        width: isMobile ? 36 : 70,
                        height: 1,
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.45),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Couple Names
                  Text(
                    "SELVAKUMAR  ·  SRINITHI",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 3.5,
                      color: const Color(0xFF722F37),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Our Love Story  ·  Since 2022  ·  Forever & Beyond",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 10 : 11.5,
                      letterSpacing: 1.6,
                      color: const Color(0xFF80604B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildCreditItem(String label, String value, bool isMobile) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? 8.5 : 9.5,
            letterSpacing: 1.8,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF80604B),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.cormorantGaramond(
            fontSize: isMobile ? 13 : 15,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF722F37),
          ),
        ),
      ],
    );
  }
}

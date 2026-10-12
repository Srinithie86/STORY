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
  const FinalRevealSection({super.key});

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
              // Main Full-Screen Classic Certificate Template
              const _ClassicBestBoyfriendCertificate(),
              const SizedBox(height: 48),

              // "WHO IS HE?" Cinematic Movie Credits Pet Name Reel with Selvakumar's Gym Photo
              const WhoIsHeMovieCreditsSection(),
              const SizedBox(height: 48),

              // Stylish Heart-Embedded Memory Quote Card ("A FOREVER REMINDER FOR YOU")
              const _HeartMemoryFooterCard(),
              const SizedBox(height: 36),

              // Bottom Minimal Citation
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "SELVAKUMAR  ♡  SRINITHI  ·  2026 → FOREVER",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 11 : 12.5,
                    letterSpacing: 3.2,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.8),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Built with endless love for the one who holds my heart ♡",
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isMobile ? 16 : 18,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFE082),
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withValues(alpha: 0.8),
                      blurRadius: 8,
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

/// Neat, Aesthetic, Clean Modern Luxury Memory Card for A FOREVER REMINDER
class _HeartMemoryFooterCard extends StatefulWidget {
  const _HeartMemoryFooterCard();

  @override
  State<_HeartMemoryFooterCard> createState() => _HeartMemoryFooterCardState();
}

class _HeartMemoryFooterCardState extends State<_HeartMemoryFooterCard>
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

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.94), // Luxurious Pearl White / Pure Ivory
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.50), // Fine Champagne Gold Hairline
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B1220).withValues(alpha: 0.08),
            blurRadius: 36,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Delicate Top Gold Ambient Highlight
            Positioned(
              top: 0,
              left: 40,
              right: 40,
              height: 1,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      const Color(0xFFD4AF37).withValues(alpha: 0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : 52,
                vertical: isMobile ? 36 : 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. Ultra-Clean Minimalist Header Pill Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8E7),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.60),
                        width: 1.0,
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.auto_awesome,
                            size: 13,
                            color: Color(0xFFD4AF37),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "A FOREVER REMINDER FOR YOU",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isMobile ? 10 : 11.5,
                              letterSpacing: 2.8,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF8B1220),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 2. High-End Editorial Serif Quote
                  Text(
                    "“${StoryConfig.finalFooterText}”",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: isMobile ? 24 : 32,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: const Color(0xFF2C1820), // Royal Burgundy / Rich Espresso
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 3. Clean Warm Sub-Caption
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Text(
                      "A digital sanctuary crafted with infinite love. Whenever your heart searches for quiet comfort, every laughter, every walk, and every promise is kept safe right here.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isMobile ? 13 : 14.5,
                        color: const Color(0xFF4E342E), // Warm Rich Espresso
                        height: 1.65,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 4. Neat Interactive Heartbeat Button
                  GestureDetector(
                    onTap: _onSendHeartbeat,
                    child: AnimatedScale(
                      scale: _justTapped ? 1.05 : 1.0,
                      duration: const Duration(milliseconds: 180),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 26,
                          vertical: isMobile ? 11 : 13,
                        ),
                        decoration: BoxDecoration(
                          color: _justTapped ? const Color(0xFFFFECEE) : const Color(0xFFFFFBF5),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: _justTapped
                                ? const Color(0xFFFF4D6D).withValues(alpha: 0.8)
                                : const Color(0xFFD4AF37).withValues(alpha: 0.60),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _justTapped
                                  ? const Color(0xFFFF4D6D).withValues(alpha: 0.25)
                                  : Colors.black.withValues(alpha: 0.05),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
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
                                child: Icon(
                                  Icons.favorite_rounded,
                                  size: isMobile ? 18 : 20,
                                  color: const Color(0xFFFF4D6D),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                _justTapped
                                    ? "Heartbeat Received ♡"
                                    : "Send a Heartbeat (${_heartbeatsSent.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')})",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: isMobile ? 12.5 : 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2C1820),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // 5. Aesthetic Minimal Divider & Names
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: isMobile ? 32 : 60,
                        height: 1,
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.25),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "◆",
                          style: TextStyle(
                            fontSize: 9,
                            color: const Color(0xFFD4AF37).withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                      Container(
                        width: isMobile ? 32 : 60,
                        height: 1,
                        color: const Color(0xFFD4AF37).withValues(alpha: 0.25),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Couple Signature Text
                  Text(
                    "SELVAKUMAR  ·  SRINITHI",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 12 : 13.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.5,
                      color: const Color(0xFF8B1220),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Our Love Story  ·  Since 2022  ·  Forever & Beyond",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 10 : 11,
                      letterSpacing: 1.5,
                      color: const Color(0xFF5D4037),
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
}

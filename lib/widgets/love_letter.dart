import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'interactive_envelope.dart';

/// Section 09 — The Love Letter
/// Recreated with the romantic burgundy crumpled parchment aesthetic and
/// sugar-coated handwritten cursive font requested by the user.
class LoveLetterSection extends StatefulWidget {
  const LoveLetterSection({super.key});

  @override
  State<LoveLetterSection> createState() => _LoveLetterSectionState();
}

class _LoveLetterSectionState extends State<LoveLetterSection>
    with TickerProviderStateMixin {
  bool _isOpen = false; // Default closed as interactive sealed envelope
  bool _showExtendedLetter = false; // Toggle to read the extended anniversary & birthday promises
  
  late AnimationController _sparkleController;
  late AnimationController _heartBurstController;
  final List<_HeartParticle> _heartParticles = [];
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _sparkleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    _heartBurstController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..addListener(() {
        if (_heartBurstController.isAnimating) {
          setState(() {
            for (var p in _heartParticles) {
              p.update();
            }
          });
        }
      });
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    _heartBurstController.dispose();
    super.dispose();
  }

  void _triggerHeartBurst() {
    _heartParticles.clear();
    for (int i = 0; i < 30; i++) {
      _heartParticles.add(
        _HeartParticle(
          x: 140 + _rnd.nextDouble() * 240,
          y: 180 + _rnd.nextDouble() * 200,
          vx: (_rnd.nextDouble() - 0.5) * 9,
          vy: -3 - _rnd.nextDouble() * 6.5,
          size: 14 + _rnd.nextDouble() * 20,
          color: Color.fromRGBO(
            225 + _rnd.nextInt(30),
            40 + _rnd.nextInt(60),
            60 + _rnd.nextInt(50),
            0.9,
          ),
        ),
      );
    }
    _heartBurstController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 90,
        horizontal: isMobile ? 16 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Editorial Tag Header matching reference photo
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "B E   M I N E",
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: isMobile ? 18 : 22,
                    letterSpacing: 8.0,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF8B1220),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "F O R E V E R   &   A L W A Y S",
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: isMobile ? 12 : 14,
                    letterSpacing: 5.5,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4A1A22),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "…October 13 is almost here… and I wanted to put my whole heart out here for you.\nNo pressure, just a gentle reminder that I'd love to spend every tomorrow with you.",
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isMobile ? 15 : 18,
                  height: 1.4,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF4E342E),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Let's see where forever takes us ♡",
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isMobile ? 13 : 15,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF8B1220),
                ),
              ),
              const SizedBox(height: 14),

              // Interactive hint
              Text(
                _isOpen ? "Tap anywhere on the letter to burst hearts 💕" : "Tap the envelope to open the letter 💌",
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isMobile ? 15 : 17,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6B0F1A),
                ),
              ),
              const SizedBox(height: 28),

              // Interactive Animated Envelope / Unfolded Burgundy Letter
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 650),
                switchInCurve: Curves.easeInOutCubic,
                switchOutCurve: Curves.easeInOutCubic,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 0.96, end: 1.0).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: _isOpen
                    ? KeyedSubtree(
                        key: const ValueKey('opened_burgundy_letter'),
                        child: _buildOpenedBurgundyLetter(isMobile),
                      )
                    : KeyedSubtree(
                        key: const ValueKey('sealed_envelope'),
                        child: _buildEnvelope(isMobile),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEnvelope(bool isMobile) {
    return Column(
      children: [
        InteractiveEnvelope(
          isOpen: _isOpen,
          onOpen: () {
            if (mounted) {
              setState(() => _isOpen = true);
              _triggerHeartBurst();
            }
          },
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            if (mounted) {
              setState(() => _isOpen = true);
              _triggerHeartBurst();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5A0E18),
            foregroundColor: Colors.white,
            elevation: 8,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: isMobile ? 12 : 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: const BorderSide(color: Color(0xFFD4AF37), width: 1.4),
            ),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("💌", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  "Unfold Love Letter",
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// The Crumpled Burgundy Parchment Love Letter matching the user's reference image
  Widget _buildOpenedBurgundyLetter(bool isMobile) {
    // Elegant cursive script style with cream/ivory ink
    final TextStyle salutationStyle = GoogleFonts.alexBrush(
      fontSize: isMobile ? 38 : 48,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFF7EBE1), // Delicate warm cream / ivory ink
      letterSpacing: 0.5,
    );

    final TextStyle cursiveBodyStyle = GoogleFonts.alexBrush(
      fontSize: isMobile ? 25 : 31,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFF3E7DC), // Ivory white ink
      height: 1.55,
      letterSpacing: 0.3,
    );

    final TextStyle cursiveHighlightStyle = GoogleFonts.alexBrush(
      fontSize: isMobile ? 26 : 33,
      fontWeight: FontWeight.w600,
      color: const Color(0xFFFFECC7), // Warm golden champagne cursive glow
      height: 1.55,
      letterSpacing: 0.4,
    );

    final TextStyle signatureStyle = GoogleFonts.alexBrush(
      fontSize: isMobile ? 32 : 40,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFF7EBE1),
      letterSpacing: 0.8,
    );

    return GestureDetector(
      onTap: _triggerHeartBurst,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // The Crumpled Burgundy Paper Container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF260207).withValues(alpha: 0.5),
                  blurRadius: 36,
                  spreadRadius: 2,
                  offset: const Offset(0, 18),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CustomPaint(
                painter: _CrumpledBurgundyParchmentPainter(),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 24 : 48,
                    vertical: isMobile ? 36 : 56,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Row: Envelope Action & Fold Button
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text("💌", style: TextStyle(fontSize: 12)),
                                      const SizedBox(width: 6),
                                      Text(
                                        "FOR SELVAKUMAR",
                                        style: AppTheme.monoStyle(
                                          fontSize: 9.5,
                                          letterSpacing: 1.5,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFFF7EBE1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 12),
                            Row(
                              children: [
                                // Toggle to view extended birthday letter
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showExtendedLetter = !_showExtendedLetter;
                                    });
                                  },
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: Colors.white.withValues(alpha: 0.2),
                                        width: 0.8,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          _showExtendedLetter ? Icons.unfold_less : Icons.unfold_more,
                                          size: 13,
                                          color: const Color(0xFFF7EBE1),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _showExtendedLetter ? "Short Letter" : "Read Full Letter",
                                          style: AppTheme.monoStyle(
                                            fontSize: 9.5,
                                            color: const Color(0xFFF7EBE1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  icon: const Icon(Icons.close_rounded, size: 20, color: Color(0xFFF7EBE1)),
                                  onPressed: () => setState(() => _isOpen = false),
                                  tooltip: "Fold back into envelope",
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: isMobile ? 24 : 32),

                      // 1. Salutation
                      Text(
                        "My Dearest Love,",
                        style: salutationStyle,
                      ),

                      SizedBox(height: isMobile ? 18 : 24),

                      // 2. Paragraph 1: Sugar-coated words from reference image
                      Text(
                        "There are so many things I wish I could tell you, yet somehow words never seem enough. You have become my favorite part of every day, the quiet thought that makes me smile for no reason, and the peace my heart always searches for.",
                        style: cursiveBodyStyle,
                      ),

                      SizedBox(height: isMobile ? 22 : 28),

                      // 3. Paragraph 2: Finding love in little moments
                      Text(
                        "Thank you for loving me, for standing beside me, and for making even the ordinary moments feel special. With you, I’ve learned that love isn’t found in grand gestures — it’s hidden in the little moments, the laughter we share, the comfort of your presence, and the way you make me feel at home.",
                        style: cursiveBodyStyle,
                      ),

                      SizedBox(height: isMobile ? 22 : 28),

                      // 4. Paragraph 3: Choosing you forever
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border(
                            left: BorderSide(
                              color: const Color(0xFFD4AF37).withValues(alpha: 0.8),
                              width: 2.5,
                            ),
                          ),
                        ),
                        child: Text(
                          "If I had to choose again, I would still choose you — today, tomorrow, and every time after that.",
                          style: cursiveHighlightStyle,
                        ),
                      ),

                      SizedBox(height: isMobile ? 22 : 28),

                      // 5. Paragraph 4: Safe reminder of belonging
                      Text(
                        "Keep this little letter as a reminder that no matter where life takes us, there will always be someone whose heart belongs to you.",
                        style: cursiveBodyStyle,
                      ),

                      // Extended Birthday Letter Section (if toggled)
                      if (_showExtendedLetter) ...[
                        SizedBox(height: isMobile ? 26 : 34),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: const Color(0xFFD4AF37).withValues(alpha: 0.35),
                        ),
                        SizedBox(height: isMobile ? 24 : 30),

                        Text(
                          "Happy Birthday to my favourite person, my best friend, and my love. 💖❤️\n\n"
                          "You came into my life as a friend, but slowly, without me even realising it, you became someone so special to my heart. "
                          "Somewhere between our conversations, our silly fights, our laughs, and our little moments, I started falling for you. "
                          "And today, you are not just my love; you are a beautiful part of my life that I never want to lose.\n\n"
                          "10,000+ fights, endless breakups, and still I choose you every single day. I want to fight with you, laugh with you, and love you forever. 🤍❤️\n\n"
                          "May all your dreams come true, may life always give you reasons to smile, and may you know that someone is always cheering for you and loving you with all her heart. 💌",
                          style: cursiveBodyStyle,
                        ),
                      ],

                      SizedBox(height: isMobile ? 36 : 48),

                      // 6. Sign-off, Authentic Couple Stamp & Crimson Wax Seal
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Authentic couple photo stamp (mini polaroid postage stamp)
                          Container(
                            width: isMobile ? 65 : 85,
                            height: isMobile ? 80 : 105,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(2, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: Image.asset(
                                      'assets/photos/matching_tees.jpg',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "10 • 13",
                                  style: AppTheme.monoStyle(
                                    fontSize: 8,
                                    color: AppTheme.darkCharcoal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Center: The Official Crimson Wax Seal with "S & M" Heart
                          _buildLetterWaxSeal(isMobile),

                          // Handwritten Sign-off
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Forever your girl,",
                                  style: signatureStyle,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Srinithi ♡",
                                  style: GoogleFonts.alexBrush(
                                    fontSize: isMobile ? 32 : 44,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFD7A8), // Golden peach ink glow
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "the friend who fell in love with you 💋",
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: isMobile ? 12 : 14,
                                    fontStyle: FontStyle.italic,
                                    color: const Color(0xFFF7EBE1).withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 36),

                      // Fold back into envelope action button
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            if (mounted) {
                              setState(() => _isOpen = false);
                            }
                          },
                          icon: const Text("✉️", style: TextStyle(fontSize: 16)),
                          label: Text(
                            "Fold Back into Envelope",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isMobile ? 12 : 13.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFF7EBE1),
                              letterSpacing: 0.6,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFD4AF37), width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 22 : 32,
                              vertical: isMobile ? 11 : 13,
                            ),
                            backgroundColor: Colors.black.withValues(alpha: 0.28),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Particle Heart Burst Canvas Overlay
          if (_heartParticles.isNotEmpty)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: _HeartParticlePainter(_heartParticles),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Official 3D Crimson Wax Seal with "S & M" Heart monogram on the letter
  Widget _buildLetterWaxSeal(bool isMobile) {
    final double sealSize = isMobile ? 62.0 : 76.0;

    return GestureDetector(
      onTap: _triggerHeartBurst,
      child: Tooltip(
        message: "Sealed with Srinithi's love ♡ (Tap for hearts)",
        child: Container(
          width: sealSize,
          height: sealSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.70),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.55),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: const Color(0xFF8B1220).withValues(alpha: 0.40),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Transform.scale(
              scale: 1.28,
              child: Image.asset(
                'assets/photos/crimson_wax_seal.jpg',
                fit: BoxFit.cover,
                cacheWidth: 300,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF8B1220),
                  child: const Center(
                    child: Icon(Icons.favorite, color: Colors.white, size: 26),
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

/// Custom Painter for Crumpled Burgundy Wrinkled Paper Background
/// Creates authentic creased parchment texture matching the reference image.
class _CrumpledBurgundyParchmentPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    final rect = Offset.zero & size;

    // Deep Burgundy Base Radial Gradient
    final baseGradient = RadialGradient(
      center: const Alignment(-0.1, -0.2),
      radius: 1.25,
      colors: const [
        Color(0xFF6B121F), // Rich crimson red highlight center
        Color(0xFF4A0A14), // Dark wine burgundy
        Color(0xFF2E040B), // Deep shadows at edges
      ],
      stops: const [0.0, 0.65, 1.0],
    );

    final paint = Paint()..shader = baseGradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Procedural Wrinkle Creases & Crushed Folds
    final random = Random(42); // Fixed seed for stable authentic creases
    final creasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final width = size.width;
    final height = size.height;

    // 1. Draw interconnected crease lines across the parchment
    const int numFolds = 45;
    for (int i = 0; i < numFolds; i++) {
      final p1 = Offset(
        random.nextDouble() * width,
        random.nextDouble() * height,
      );
      final p2 = Offset(
        p1.dx + (random.nextDouble() - 0.5) * 240,
        p1.dy + (random.nextDouble() - 0.5) * 240,
      );

      // Dark fold crevice
      creasePaint.color = Colors.black.withValues(alpha: 0.16 + random.nextDouble() * 0.14);
      creasePaint.strokeWidth = 1.2 + random.nextDouble() * 2.5;
      canvas.drawLine(p1, p2, creasePaint);

      // Light crease ridge highlight (gives 3D relief)
      creasePaint.color = Colors.white.withValues(alpha: 0.04 + random.nextDouble() * 0.06);
      creasePaint.strokeWidth = 0.8 + random.nextDouble() * 1.4;
      canvas.drawLine(
        Offset(p1.dx + 1.2, p1.dy + 1.2),
        Offset(p2.dx + 1.2, p2.dy + 1.2),
        creasePaint,
      );
    }

    // 2. Triangular facet shading for crushed paper topography
    final facetPaint = Paint()..style = PaintingStyle.fill;
    final facetPath = Path();
    for (int i = 0; i < 22; i++) {
      final p1 = Offset(random.nextDouble() * width, random.nextDouble() * height);
      final p2 = Offset(p1.dx + (random.nextDouble() - 0.5) * 180, p1.dy + (random.nextDouble() - 0.5) * 180);
      final p3 = Offset(p1.dx + (random.nextDouble() - 0.5) * 180, p1.dy + (random.nextDouble() - 0.5) * 180);

      facetPath.reset();
      facetPath.moveTo(p1.dx, p1.dy);
      facetPath.lineTo(p2.dx, p2.dy);
      facetPath.lineTo(p3.dx, p3.dy);
      facetPath.close();

      final isHighlight = random.nextBool();
      facetPaint.color = isHighlight
          ? Colors.white.withValues(alpha: 0.025 + random.nextDouble() * 0.035)
          : Colors.black.withValues(alpha: 0.07 + random.nextDouble() * 0.08);
      canvas.drawPath(facetPath, facetPaint);
    }

    // 3. Subtle edge vignette
    final vignetteGradient = RadialGradient(
      center: Alignment.center,
      radius: 1.0,
      colors: [
        Colors.transparent,
        Colors.black.withValues(alpha: 0.28),
      ],
      stops: const [0.7, 1.0],
    );
    final vignettePaint = Paint()..shader = vignetteGradient.createShader(rect);
    canvas.drawRect(rect, vignettePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeartParticle {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  Color color;

  _HeartParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.color,
  });

  void update() {
    x += vx;
    y += vy;
    vy += 0.22;
    size = max(0.0, size - 0.35);
  }
}

class _HeartParticlePainter extends CustomPainter {
  final List<_HeartParticle> particles;

  _HeartParticlePainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    for (var p in particles) {
      if (p.size <= 0) continue;
      final paint = Paint()..color = p.color;
      final path = Path();
      final s = p.size;
      path.moveTo(p.x, p.y + s * 0.3);
      path.cubicTo(p.x - s * 0.5, p.y - s * 0.2, p.x - s, p.y + s * 0.3, p.x, p.y + s);
      path.cubicTo(p.x + s, p.y + s * 0.3, p.x + s * 0.5, p.y - s * 0.2, p.x, p.y + s * 0.3);
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

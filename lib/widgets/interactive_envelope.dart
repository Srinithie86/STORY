import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';

/// Interactive Love Letter Envelope with Thread Unlock Animation
/// Perfectly recreated from the reference vintage editorial love letter design:
/// - Giant "Be My Love" vintage serif background typography
/// - Rich tilted velvet crimson envelope
/// - Authentic terracotta/golden cord thread wrapped across the envelope with loose loops
/// - Ornate embossed crimson red wax seal with "S & M" heart monogram
/// - Multi-stage cinematic "Thread Unlock" animation:
///   1. Thread loosens, unties, and smoothly slides away with golden particle sparks
///   2. Wax seal lifts and glows
///   3. Flap folds open in 3D
///   4. Crisp cream letter card slides upward displaying "Dear Mani, I hope this finds you well..."
class InteractiveEnvelope extends StatefulWidget {
  final VoidCallback onOpen;
  final bool isOpen;

  const InteractiveEnvelope({
    super.key,
    required this.onOpen,
    required this.isOpen,
  });

  @override
  State<InteractiveEnvelope> createState() => _InteractiveEnvelopeState();
}

class _InteractiveEnvelopeState extends State<InteractiveEnvelope>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _threadAnimation;
  late Animation<double> _sealAnimation;
  late Animation<double> _flapAnimation;
  late Animation<double> _cardSlideAnimation;
  late Animation<double> _photoSlideAnimation;

  final List<_ThreadSparkle> _sparkles = [];
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );

    // Multi-phase cinematic animations
    _threadAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.40, curve: Curves.easeInOutCubic),
    );

    _sealAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.52, curve: Curves.easeOutBack),
    );

    _flapAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.35, 0.72, curve: Curves.easeInBack),
    );

    _cardSlideAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.48, 0.98, curve: Curves.easeOutCubic),
    );

    _photoSlideAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.40, 0.88, curve: Curves.easeOutQuad),
    );

    _controller.addListener(() {
      if (_controller.value > 0.05 && _controller.value < 0.45 && _sparkles.length < 18) {
        _spawnSparkle();
      }
      for (final s in _sparkles) {
        s.update();
      }
      _sparkles.removeWhere((s) => s.opacity <= 0.0);
    });

    if (widget.isOpen) {
      _controller.value = 1.0;
    }
  }

  void _spawnSparkle() {
    _sparkles.add(
      _ThreadSparkle(
        x: 180 + (_rnd.nextDouble() - 0.5) * 80,
        y: 250 + (_rnd.nextDouble() - 0.5) * 40,
        vx: (_rnd.nextDouble() - 0.5) * 4.5,
        vy: -1.0 - _rnd.nextDouble() * 3.5,
        color: _rnd.nextBool()
            ? const Color(0xFFFFD54F)
            : const Color(0xFFE67E22),
      ),
    );
  }

  bool _isOpening = false;

  @override
  void didUpdateWidget(covariant InteractiveEnvelope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOpen != oldWidget.isOpen) {
      if (widget.isOpen) {
        _controller.value = 1.0;
        _isOpening = false;
      } else {
        _controller.value = 0.0;
        _isOpening = false;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_isOpening) {
      widget.onOpen();
      return;
    }
    setState(() => _isOpening = true);
    _controller.forward(from: 0.0);
    Future.delayed(const Duration(milliseconds: 1300), () {
      if (mounted && _isOpening) {
        widget.onOpen();
        setState(() => _isOpening = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final targetWidth = min(availableWidth, 380.0);
        final scale = targetWidth / 380.0;

        return GestureDetector(
          onTap: _handleTap,
          child: Center(
            child: SizedBox(
              width: targetWidth,
              height: 520 * scale,
              child: Transform.scale(
                scale: scale,
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 380,
                  height: 520,
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // =========================================================
                  // 1. GIANT BACKGROUND WATERMARK TYPOGRAPHY ("Be My Love")
                  // Directly matching the "Be My Val" editorial vintage background
                  // =========================================================
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Opacity(
                        opacity: 0.85,
                        child: Stack(
                          children: [
                            Positioned(
                              left: -12,
                              top: 20,
                              child: Text(
                                "Be",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 160,
                                  fontWeight: FontWeight.w700,
                                  height: 0.8,
                                  color: const Color(0xFF8B1220).withValues(alpha: 0.88),
                                ),
                              ),
                            ),
                            Positioned(
                              right: -10,
                              top: 80,
                              child: Text(
                                "My",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 150,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.italic,
                                  height: 0.8,
                                  color: const Color(0xFF8B1220).withValues(alpha: 0.88),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 20,
                              bottom: 20,
                              child: Text(
                                "Love",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: 140,
                                  fontWeight: FontWeight.w700,
                                  height: 0.8,
                                  color: const Color(0xFF8B1220).withValues(alpha: 0.88),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // =========================================================
                  // 2. THE TILTED VELVET CRIMSON ENVELOPE ASSEMBLY
                  // =========================================================
                  Transform.rotate(
                    angle: -0.04, // Elegant vintage editorial 2.3-degree tilt
                    child: SizedBox(
                      width: 330,
                      height: 440,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        clipBehavior: Clip.none,
                        children: [
                          // 2A. ENVELOPE BACK INTERIOR (Dark deep velvet burgundy cavity)
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 320,
                              height: 250,
                              decoration: BoxDecoration(
                                color: const Color(0xFF42050B), // Deep shadow burgundy
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.35),
                                    blurRadius: 28,
                                    offset: const Offset(0, 16),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // 2B. COUPLE POLAROIDS POKING OUT BEHIND LETTER (Memory touches)
                          Positioned(
                            bottom: 100 + _photoSlideAnimation.value * 65,
                            left: 18,
                            child: Transform.rotate(
                              angle: -0.16 + _photoSlideAnimation.value * -0.05,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.25),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: SizedBox(
                                    width: 90,
                                    height: 105,
                                    child: Image.asset(
                                      "assets/photos/beach_standing.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 105 + _photoSlideAnimation.value * 70,
                            right: 18,
                            child: Transform.rotate(
                              angle: 0.14 + _photoSlideAnimation.value * 0.05,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.25),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: SizedBox(
                                    width: 88,
                                    height: 110,
                                    child: Image.asset(
                                      "assets/photos/traditional_couple.jpg",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // 2C. CRISP CREAM LETTER CARD SLIDING UPWARDS
                          // Exactly matching the "Dear Val, I hope this finds you well..." card!
                          Positioned(
                            bottom: 60 + _cardSlideAnimation.value * 175,
                            child: Container(
                              width: 295,
                              height: 250,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFDFBF7), // Warm premium cardstock
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: const Color(0xFFEBE1D3), width: 1.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.24),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Salutation "Dear Mani,"
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Dear ",
                                            style: GoogleFonts.cormorantGaramond(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF1E1719),
                                            ),
                                          ),
                                          TextSpan(
                                            text: "Mani,",
                                            style: GoogleFonts.cormorantGaramond(
                                              fontSize: 25,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF8B1220),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),

                                    // Subtitle "I hope this finds you well..."
                                    Text(
                                      "I hope this finds you well…",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cormorantGaramond(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF2E2326),
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    // Romantic body message matching reference rhythm
                                    Text(
                                      "…October 13 is almost here… and I wanted to put my whole heart out here for you. No pressure, just a gentle reminder that I'd truly love to spend every tomorrow by your side.",
                                      textAlign: TextAlign.center,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.cormorantGaramond(
                                        fontSize: 12.5,
                                        height: 1.3,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF5D4037),
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    // Romantic closing accent
                                    Text(
                                      "Let's see where forever takes us ♡",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.cormorantGaramond(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF8B1220),
                                      ),
                                    ),
                                    const SizedBox(height: 12),

                                    // Tap to Read Full Letter Button
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF7A0E1A),
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF7A0E1A).withValues(alpha: 0.3),
                                            blurRadius: 6,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "UNFOLD LOVE LETTER",
                                              style: AppTheme.monoStyle(
                                                fontSize: 9,
                                                letterSpacing: 0.8,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            const Icon(
                                              Icons.arrow_upward_rounded,
                                              size: 11,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          // 2D. ENVELOPE FRONT BODY (V-shaped pocket)
                          Positioned(
                            bottom: 0,
                            child: CustomPaint(
                              size: const Size(320, 250),
                              painter: _VelvetEnvelopeBodyPainter(),
                            ),
                          ),

                          // 2E. ENVELOPE FLAP (3D Flip Animation)
                          Positioned(
                            bottom: 115,
                            child: Transform(
                              alignment: Alignment.topCenter,
                              transform: Matrix4.identity()
                                ..setEntry(3, 2, 0.002) // Perspective 3D
                                ..rotateX(pi * _flapAnimation.value),
                              child: CustomPaint(
                                size: const Size(320, 135),
                                painter: _VelvetEnvelopeFlapPainter(
                                  isOpen: _flapAnimation.value > 0.5,
                                ),
                              ),
                            ),
                          ),

                          // 2F. THE ORANGE / GOLDEN THREAD CORD (Thread Unlock Animation)
                          // Custom Painter that renders horizontal cord & flowing loose loops
                          Positioned(
                            bottom: 0,
                            child: CustomPaint(
                              size: const Size(320, 250),
                              painter: _ThreadCordPainter(
                                unlockProgress: _threadAnimation.value,
                              ),
                            ),
                          ),

                          // 2G. THE LUXURY EMBOSSED CRIMSON WAX SEAL WITH "S & M" HEART
                          Positioned(
                            bottom: 118 + (_sealAnimation.value * -15),
                            child: Transform.scale(
                              scale: 1.0 + (_sealAnimation.value * 0.25),
                              child: Transform.rotate(
                                angle: _sealAnimation.value * -0.15,
                                child: Opacity(
                                  opacity: (1.0 - _sealAnimation.value * 1.5).clamp(0.0, 1.0),
                                  child: _buildRealisticWaxSeal(),
                                ),
                              ),
                            ),
                          ),

                          // 2H. THREAD UNLOCK SPARKLES
                          ..._sparkles.map((sparkle) {
                            return Positioned(
                              left: sparkle.x - 3,
                              top: sparkle.y - 3,
                              child: Opacity(
                                opacity: sparkle.opacity,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: sparkle.color,
                                    boxShadow: [
                                      BoxShadow(
                                        color: sparkle.color.withValues(alpha: 0.8),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRealisticWaxSeal() {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.65),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.50),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: const Color(0xFF8B1220).withValues(alpha: 0.35),
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
            errorBuilder: (context, error, stackTrace) => _buildVectorWaxSealFallback(),
          ),
        ),
      ),
    );
  }

  Widget _buildVectorWaxSealFallback() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [
            Color(0xFFA31220),
            Color(0xFF7A0E1A),
            Color(0xFF4E050D),
          ],
        ),
        border: Border.all(color: const Color(0xFFB52331), width: 1.5),
      ),
      child: const Center(
        child: Text(
          "S&M\n♡",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFFF2D6),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}

// Sparkle particle on thread untying
class _ThreadSparkle {
  double x;
  double y;
  double vx;
  double vy;
  double opacity = 1.0;
  Color color;

  _ThreadSparkle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
  });

  void update() {
    x += vx;
    y += vy;
    vy += 0.08;
    opacity = max(0.0, opacity - 0.045);
  }
}

// =============================================================================
// VELVET ENVELOPE BODY PAINTER
// =============================================================================
class _VelvetEnvelopeBodyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bodyPath = Path();
    bodyPath.moveTo(0, 0);
    bodyPath.lineTo(w * 0.5, h * 0.52);
    bodyPath.lineTo(w, 0);
    bodyPath.lineTo(w, h);
    bodyPath.lineTo(0, h);
    bodyPath.close();

    // Velvet gradient fill
    final rect = Rect.fromLTWH(0, 0, w, h);
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF8B1220), // Rich Velvet Crimson
          Color(0xFF6E0D18),
          Color(0xFF4A0810),
        ],
      ).createShader(rect);

    canvas.drawPath(bodyPath, paint);

    // Subtle golden/crimson rim highlight
    final strokePaint = Paint()
      ..color = const Color(0xFFA82333).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawPath(bodyPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// VELVET ENVELOPE FLAP PAINTER
// =============================================================================
class _VelvetEnvelopeFlapPainter extends CustomPainter {
  final bool isOpen;

  _VelvetEnvelopeFlapPainter({required this.isOpen});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final flapPath = Path();
    flapPath.moveTo(0, 0);
    flapPath.lineTo(w * 0.5, h);
    flapPath.lineTo(w, 0);
    flapPath.close();

    final rect = Rect.fromLTWH(0, 0, w, h);
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isOpen
            ? const [Color(0xFF45060D), Color(0xFF610B15)]
            : const [Color(0xFF961626), Color(0xFF700E1B)],
      ).createShader(rect);

    canvas.drawPath(flapPath, paint);

    final rimPaint = Paint()
      ..color = const Color(0xFFB52335).withValues(alpha: 0.7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawPath(flapPath, rimPaint);
  }

  @override
  bool shouldRepaint(covariant _VelvetEnvelopeFlapPainter oldDelegate) =>
      oldDelegate.isOpen != isOpen;
}

// =============================================================================
// THREAD CORD PAINTER WITH UNLOCK ANIMATION
// Directly renders the terracotta / golden thread wrapping the envelope
// and pulls/unties outwards when unlockProgress increases!
// =============================================================================
class _ThreadCordPainter extends CustomPainter {
  final double unlockProgress;

  _ThreadCordPainter({required this.unlockProgress});

  @override
  void paint(Canvas canvas, Size size) {
    if (unlockProgress >= 1.0) return;

    final w = size.width;
    final cordY = size.height * 0.52; // Meets at center wax seal

    final alpha = ((1.0 - unlockProgress * 1.3).clamp(0.0, 1.0) * 255).toInt();
    if (alpha <= 0) return;

    final cordColor = Color.fromARGB(alpha, 222, 107, 54); // Terracotta orange
    final cordShadowColor = Color.fromARGB((alpha * 0.4).toInt(), 40, 10, 10);
    final highlightColor = Color.fromARGB(alpha, 255, 179, 110);

    final cordPaint = Paint()
      ..color = cordColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.0;

    final shadowPaint = Paint()
      ..color = cordShadowColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3.8;

    final highlightPaint = Paint()
      ..color = highlightColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.0;

    // Displacement when untying: left pulls left, right pulls right
    final leftShiftX = -unlockProgress * 90;
    final leftShiftY = unlockProgress * 25;
    final rightShiftX = unlockProgress * 95;
    final rightShiftY = -unlockProgress * 20;

    // --- LEFT THREAD HALF ---
    canvas.save();
    canvas.translate(leftShiftX, leftShiftY);

    final leftPath = Path();
    // Straight cord across from edge to center
    leftPath.moveTo(-15, cordY);
    leftPath.lineTo(w * 0.5 - (unlockProgress * 30), cordY);

    // Decorative loose curly loop on left edge matching reference photo
    leftPath.moveTo(-15, cordY);
    leftPath.cubicTo(
      -45, cordY + 25,
      -65, cordY + 80,
      -35, cordY + 130,
    );
    leftPath.cubicTo(
      -10, cordY + 175,
      -25, cordY + 220,
      -40, cordY + 250,
    );

    canvas.drawPath(leftPath, shadowPaint);
    canvas.drawPath(leftPath, cordPaint);
    canvas.drawPath(leftPath, highlightPaint);
    canvas.restore();

    // --- RIGHT THREAD HALF ---
    canvas.save();
    canvas.translate(rightShiftX, rightShiftY);

    final rightPath = Path();
    // Straight cord from center to right edge
    rightPath.moveTo(w * 0.5 + (unlockProgress * 30), cordY);
    rightPath.lineTo(w + 15, cordY);

    // Flowing loose cord running off to the right matching reference photo
    rightPath.moveTo(w + 15, cordY);
    rightPath.cubicTo(
      w + 40, cordY - 15,
      w + 75, cordY - 35,
      w + 120, cordY - 20,
    );

    canvas.drawPath(rightPath, shadowPaint);
    canvas.drawPath(rightPath, cordPaint);
    canvas.drawPath(rightPath, highlightPaint);
    canvas.restore();

    // --- CENTER KNOT (Only visible when sealed) ---
    if (unlockProgress < 0.25) {
      final knotPaint = Paint()
        ..color = cordColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5;

      final knotCenter = Offset(w * 0.5, cordY);
      canvas.drawCircle(knotCenter, 10 * (1.0 - unlockProgress * 3), knotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _ThreadCordPainter oldDelegate) =>
      oldDelegate.unlockProgress != unlockProgress;
}

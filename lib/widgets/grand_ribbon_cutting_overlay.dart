import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import '../data/story_data.dart';

class GrandRibbonCuttingOverlay extends StatefulWidget {
  final VoidCallback onDismiss;

  const GrandRibbonCuttingOverlay({super.key, required this.onDismiss});

  @override
  State<GrandRibbonCuttingOverlay> createState() => _GrandRibbonCuttingOverlayState();
}

class _GrandRibbonCuttingOverlayState extends State<GrandRibbonCuttingOverlay>
    with TickerProviderStateMixin {
  late AnimationController _cutController;
  late Animation<double> _cutAnimation;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  late AnimationController _snipController;
  late Animation<double> _snipAnimation;

  late AnimationController _confettiController;

  bool _isCut = false;
  bool _showBirthdayModal = false;
  final List<_ConfettiParticle> _particles = [];

  @override
  void initState() {
    super.initState();

    _cutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _cutAnimation = CurvedAnimation(
      parent: _cutController,
      curve: Curves.easeInOutCubic,
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _snipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _snipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _snipController, curve: Curves.easeInOut),
    );

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..addListener(() {
        setState(() {
          for (var particle in _particles) {
            particle.update();
          }
        });
      });
  }

  @override
  void dispose() {
    _cutController.dispose();
    _pulseController.dispose();
    _snipController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _generateConfetti(Size size) {
    final random = Random();
    final cx = size.width / 2;
    final cy = size.height / 2;

    _particles.clear();
    for (int i = 0; i < 65; i++) {
      final angle = random.nextDouble() * 2 * pi;
      final speed = 5.0 + random.nextDouble() * 15.0;
      final colors = [
        const Color(0xFFFFD54F), // Gold
        const Color(0xFFD32F2F), // Red Satin
        const Color(0xFFFFF8E1), // Cream
        const Color(0xFFFF4081), // Pink Ribbon
        const Color(0xFFFFB300), // Amber Gold
        const Color(0xFFE91E63), // Deep Magenta
      ];

      _particles.add(
        _ConfettiParticle(
          x: cx,
          y: cy,
          vx: cos(angle) * speed,
          vy: sin(angle) * speed - 4.0,
          color: colors[random.nextInt(colors.length)],
          size: 5.0 + random.nextDouble() * 7.0,
          rotation: random.nextDouble() * 2 * pi,
          vRot: (random.nextDouble() - 0.5) * 0.25,
          isHeart: random.nextBool(),
        ),
      );
    }
  }

  void _cutRibbon() async {
    if (_isCut) return;

    setState(() {
      _isCut = true;
    });

    _snipController.forward();

    final screenSize = MediaQuery.of(context).size;
    _generateConfetti(screenSize);

    await Future.delayed(const Duration(milliseconds: 200));

    _cutController.forward();
    _confettiController.forward(from: 0.0);

    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {
        _showBirthdayModal = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: Listenable.merge([_cutAnimation, _confettiController, _snipAnimation]),
      builder: (context, child) {
        final cutProgress = _cutAnimation.value;
        final bgOpacity = (1.0 - cutProgress * 0.75).clamp(0.0, 1.0);

        return Stack(
          children: [
            // 1. Semi-Transparent Vignette Overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.center,
                    radius: 1.2,
                    colors: [
                      Color.fromRGBO(42, 6, 12, bgOpacity * 0.75),
                      Color.fromRGBO(15, 2, 5, bgOpacity * 0.95),
                    ],
                  ),
                ),
              ),
            ),

            // 2. Ultra-Realistic 3D Satin Ribbon Cross & Curling Snap Effect
            Positioned.fill(
              child: CustomPaint(
                painter: _Real3DSatinRibbonPainter(
                  cutProgress: cutProgress,
                  isCut: _isCut,
                ),
              ),
            ),

            // 3. 3D Confetti Burst (Foil Stars, Hearts, Ribbons)
            if (_particles.isNotEmpty)
              Positioned.fill(
                child: CustomPaint(
                  painter: _ConfettiPainter(particles: _particles),
                ),
              ),

            // 4. Center Gold Wax Seal & 3D Scissors (Before Cut)
            if (!_isCut)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Gold Embossed Wax Seal Badge with Names
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF5A101D), Color(0xFF380811)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: const Color(0xFFFFD54F), width: 3.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.6),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                          BoxShadow(
                            color: const Color(0xFFFFD54F).withValues(alpha: 0.5),
                            blurRadius: 25,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star_rounded, color: Color(0xFFFFD54F), size: 20),
                          const SizedBox(width: 10),
                          Text(
                            "${StoryConfig.boyName}  ♡  ${StoryConfig.girlName}",
                            style: AppTheme.romanticCalligraphyStyle(
                              fontSize: isMobile ? 32 : 46,
                              color: const Color(0xFFFFF8E1),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.star_rounded, color: Color(0xFFFFD54F), size: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Interactive 3D Metallic Scissors Button ✂️
                    ScaleTransition(
                      scale: _pulseAnimation,
                      child: GestureDetector(
                        onTap: _cutRibbon,
                        child: _ThreeDScissorsWidget(
                          snipProgress: _snipAnimation.value,
                          isMobile: isMobile,
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Tap to Cut Hint Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2B0006).withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: const Color(0xFFFFD54F).withValues(alpha: 0.6), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD54F).withValues(alpha: 0.3),
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.touch_app_rounded, color: Color(0xFFFFD54F), size: 18),
                          const SizedBox(width: 10),
                          Text(
                            "TAP SCISSORS TO CUT THE RIBBON ✂️",
                            style: AppTheme.monoStyle(
                              fontSize: isMobile ? 11 : 13,
                              color: const Color(0xFFFFF8E1),
                              letterSpacing: 1.8,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // 5. Grand Birthday Celebration Modal Popup
            if (_showBirthdayModal)
              Center(
                child: TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.elasticOut,
                  builder: (context, val, child) {
                    return Transform.scale(
                      scale: val,
                      child: Container(
                        width: min(screenSize.width * 0.9, 490.0),
                        padding: const EdgeInsets.all(36),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4A0A14), Color(0xFF2E050B)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(color: const Color(0xFFFFD54F), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.6),
                              blurRadius: 35,
                              offset: const Offset(0, 18),
                            ),
                            BoxShadow(
                              color: const Color(0xFFFFD54F).withValues(alpha: 0.4),
                              blurRadius: 45,
                              spreadRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("👑 🎂 💖 👑", style: TextStyle(fontSize: 34)),
                            const SizedBox(height: 14),

                            Text(
                              "HAPPY BIRTHDAY",
                              style: AppTheme.monoStyle(
                                fontSize: 13,
                                letterSpacing: 3.5,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFFFFD54F),
                              ),
                            ),
                            const SizedBox(height: 4),

                            Text(
                              "My Love!",
                              style: GoogleFonts.greatVibes(
                                fontSize: isMobile ? 46 : 58,
                                color: const Color(0xFFFFF8E1),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Names Crest
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF6B0F1A),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: const Color(0xFFFFD54F).withValues(alpha: 0.6)),
                              ),
                              child: Text(
                                "${StoryConfig.boyName}  ♡  ${StoryConfig.girlName}",
                                style: GoogleFonts.caveat(
                                  fontSize: 24,
                                  color: const Color(0xFFFFD54F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            Text(
                              "Welcome to your personal digital archive! Every memory, video, and letter here was made to celebrate your special day.",
                              textAlign: TextAlign.center,
                              style: AppTheme.serifStyle(
                                fontSize: isMobile ? 16 : 18,
                                color: const Color(0xFFFFF8E1),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // OPEN OUR STORY BUTTON
                            ElevatedButton(
                              onPressed: widget.onDismiss,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFFD54F),
                                foregroundColor: const Color(0xFF380811),
                                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                elevation: 12,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "ENTER OUR STORY ✦",
                                    style: AppTheme.monoStyle(
                                      fontSize: 13,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF380811),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.arrow_forward_rounded, color: Color(0xFF380811), size: 20),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

/// Custom 3D Metallic Scissors Widget
class _ThreeDScissorsWidget extends StatelessWidget {
  final double snipProgress;
  final bool isMobile;

  const _ThreeDScissorsWidget({
    required this.snipProgress,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final size = isMobile ? 90.0 : 110.0;
    final angle = snipProgress * 0.35;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Color(0xFFFFE082), Color(0xFFFFB300), Color(0xFFFF6F00)],
          stops: [0.0, 0.65, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: const Color(0xFFFFD54F).withValues(alpha: 0.7),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Left Blade
          Transform.rotate(
            angle: -0.2 + angle,
            child: const Icon(
              Icons.content_cut_rounded,
              color: Color(0xFF380811),
              size: 52,
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter for Photorealistic 3D Satin Ribbon with Specular Highlights & Snap Curl Waves
class _Real3DSatinRibbonPainter extends CustomPainter {
  final double cutProgress;
  final bool isCut;

  _Real3DSatinRibbonPainter({required this.cutProgress, required this.isCut});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    final ribbonWidth = max(w * 0.085, 54.0);

    final shiftX = cutProgress * w * 0.7;
    final shiftY = cutProgress * h * 0.7;

    final curlWave = sin(cutProgress * pi) * 35.0;

    // 1. HORIZONTAL SATIN RIBBON (Left & Right Halves)
    _drawHorizontalSatinBand(
      canvas,
      startX: 0 - shiftX,
      endX: cx - shiftX,
      cy: cy,
      ribbonWidth: ribbonWidth,
      curlOffset: -curlWave,
      isLeft: true,
    );

    _drawHorizontalSatinBand(
      canvas,
      startX: cx + shiftX,
      endX: w + shiftX,
      cy: cy,
      ribbonWidth: ribbonWidth,
      curlOffset: curlWave,
      isLeft: false,
    );

    // 2. VERTICAL SATIN RIBBON (Top & Bottom Halves)
    _drawVerticalSatinBand(
      canvas,
      cx: cx,
      startY: 0 - shiftY,
      endY: cy - shiftY,
      ribbonWidth: ribbonWidth,
      curlOffset: -curlWave,
      isTop: true,
    );

    _drawVerticalSatinBand(
      canvas,
      cx: cx,
      startY: cy + shiftY,
      endY: h + shiftY,
      ribbonWidth: ribbonWidth,
      curlOffset: curlWave,
      isTop: false,
    );

    // 3. 3D CENTER SATIN BOW LOOPS (Before Cut)
    if (cutProgress < 0.2) {
      final opacity = (1.0 - cutProgress * 5.0).clamp(0.0, 1.0);
      _draw3DSatinBow(canvas, Offset(cx, cy), ribbonWidth, opacity);
    }
  }

  void _drawHorizontalSatinBand(
    Canvas canvas, {
    required double startX,
    required double endX,
    required double cy,
    required double ribbonWidth,
    required double curlOffset,
    required bool isLeft,
  }) {
    final topY = cy - ribbonWidth / 2;
    final bottomY = cy + ribbonWidth / 2;
    final rect = Rect.fromLTRB(startX, topY, endX, bottomY);

    // 3D Specular Satin Fabric Shader
    final satinShader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: const [
        Color(0xFF2E0006), // Top Deep Shadow Edge
        Color(0xFF8B0000), // Rich Satin Red
        Color(0xFFFF6F7D), // Specular High-Gloss Silk Reflection
        Color(0xFF8B0000), // Rich Satin Red
        Color(0xFF2E0006), // Bottom Shadow Edge
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    ).createShader(rect);

    final ribbonPaint = Paint()..shader = satinShader;

    // Drop Shadow under Ribbon
    final shadowPaint = Paint()..color = Colors.black.withValues(alpha: 0.45);
    canvas.drawRect(rect.shift(const Offset(0, 6)), shadowPaint);

    // Band Body
    final bandPath = Path();
    if (isLeft) {
      bandPath.moveTo(startX, topY);
      bandPath.lineTo(endX, topY + curlOffset);
      bandPath.lineTo(endX, bottomY + curlOffset);
      bandPath.lineTo(startX, bottomY);
    } else {
      bandPath.moveTo(startX, topY + curlOffset);
      bandPath.lineTo(endX, topY);
      bandPath.lineTo(endX, bottomY);
      bandPath.lineTo(startX, bottomY + curlOffset);
    }
    bandPath.close();

    canvas.drawPath(bandPath, ribbonPaint);

    // Dual Gold Stitched Border Lines
    final goldBorder = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD54F), Color(0xFFB78103), Color(0xFFFFD54F)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    if (isLeft) {
      canvas.drawLine(Offset(startX, topY), Offset(endX, topY + curlOffset), goldBorder);
      canvas.drawLine(Offset(startX, bottomY), Offset(endX, bottomY + curlOffset), goldBorder);
    } else {
      canvas.drawLine(Offset(startX, topY + curlOffset), Offset(endX, topY), goldBorder);
      canvas.drawLine(Offset(startX, bottomY + curlOffset), Offset(endX, bottomY), goldBorder);
    }
  }

  void _drawVerticalSatinBand(
    Canvas canvas, {
    required double cx,
    required double startY,
    required double endY,
    required double ribbonWidth,
    required double curlOffset,
    required bool isTop,
  }) {
    final leftX = cx - ribbonWidth / 2;
    final rightX = cx + ribbonWidth / 2;
    final rect = Rect.fromLTRB(leftX, startY, rightX, endY);

    final satinShader = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: const [
        Color(0xFF2E0006),
        Color(0xFF8B0000),
        Color(0xFFFF6F7D),
        Color(0xFF8B0000),
        Color(0xFF2E0006),
      ],
      stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
    ).createShader(rect);

    final ribbonPaint = Paint()..shader = satinShader;
    final shadowPaint = Paint()..color = Colors.black.withValues(alpha: 0.45);

    canvas.drawRect(rect.shift(const Offset(6, 0)), shadowPaint);

    final bandPath = Path();
    if (isTop) {
      bandPath.moveTo(leftX, startY);
      bandPath.lineTo(rightX, startY);
      bandPath.lineTo(rightX + curlOffset, endY);
      bandPath.lineTo(leftX + curlOffset, endY);
    } else {
      bandPath.moveTo(leftX + curlOffset, startY);
      bandPath.lineTo(rightX + curlOffset, startY);
      bandPath.lineTo(rightX, endY);
      bandPath.lineTo(leftX, endY);
    }
    bandPath.close();

    canvas.drawPath(bandPath, ribbonPaint);

    final goldBorder = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFFD54F), Color(0xFFB78103), Color(0xFFFFD54F)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    if (isTop) {
      canvas.drawLine(Offset(leftX, startY), Offset(leftX + curlOffset, endY), goldBorder);
      canvas.drawLine(Offset(rightX, startY), Offset(rightX + curlOffset, endY), goldBorder);
    } else {
      canvas.drawLine(Offset(leftX + curlOffset, startY), Offset(leftX, endY), goldBorder);
      canvas.drawLine(Offset(rightX + curlOffset, startY), Offset(rightX, endY), goldBorder);
    }
  }

  void _draw3DSatinBow(Canvas canvas, Offset center, double ribbonWidth, double opacity) {
    if (opacity <= 0) return;

    final bowPaint = Paint()
      ..color = const Color(0xFF8B0000).withValues(alpha: opacity)
      ..style = PaintingStyle.fill;

    final goldLine = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final r = ribbonWidth * 1.2;

    // 4 Satin Bow Loops 🎀
    final loop1 = Path();
    loop1.addOval(Rect.fromCenter(center: Offset(center.dx - r * 0.7, center.dy - r * 0.7), width: r, height: r * 0.6));
    canvas.drawPath(loop1, bowPaint);
    canvas.drawPath(loop1, goldLine);

    final loop2 = Path();
    loop2.addOval(Rect.fromCenter(center: Offset(center.dx + r * 0.7, center.dy - r * 0.7), width: r, height: r * 0.6));
    canvas.drawPath(loop2, bowPaint);
    canvas.drawPath(loop2, goldLine);

    final loop3 = Path();
    loop3.addOval(Rect.fromCenter(center: Offset(center.dx - r * 0.7, center.dy + r * 0.7), width: r, height: r * 0.6));
    canvas.drawPath(loop3, bowPaint);
    canvas.drawPath(loop3, goldLine);

    final loop4 = Path();
    loop4.addOval(Rect.fromCenter(center: Offset(center.dx + r * 0.7, center.dy + r * 0.7), width: r, height: r * 0.6));
    canvas.drawPath(loop4, bowPaint);
    canvas.drawPath(loop4, goldLine);
  }

  @override
  bool shouldRepaint(covariant _Real3DSatinRibbonPainter oldDelegate) =>
      oldDelegate.cutProgress != cutProgress || oldDelegate.isCut != isCut;
}

/// Particle Data Structure
class _ConfettiParticle {
  double x;
  double y;
  double vx;
  double vy;
  Color color;
  double size;
  double rotation;
  double vRot;
  bool isHeart;

  _ConfettiParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
    required this.rotation,
    required this.vRot,
    required this.isHeart,
  });

  void update() {
    x += vx;
    y += vy;
    vy += 0.22; // gravity
    vx *= 0.985;
    rotation += vRot;
  }
}

/// Painter for 3D Confetti Burst (Foil Circles, Hearts, Ribbons)
class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;

  _ConfettiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    for (var p in particles) {
      final paint = Paint()..color = p.color;
      canvas.save();
      canvas.translate(p.x, p.y);
      canvas.rotate(p.rotation);

      if (p.isHeart) {
        final path = Path();
        final s = p.size;
        path.moveTo(0, s * 0.4);
        path.cubicTo(-s * 0.5, -s * 0.2, -s, s * 0.3, 0, s);
        path.cubicTo(s, s * 0.3, s * 0.5, -s * 0.2, 0, s * 0.4);
        canvas.drawPath(path, paint);
      } else {
        canvas.drawRect(Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 1.8), paint);
      }
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

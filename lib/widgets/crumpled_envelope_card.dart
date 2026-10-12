// Animated Crumpled Envelope Card with a subtle pulse effect
import 'dart:math';
import 'package:flutter/material.dart';
import 'sunflower_decorations.dart';

class CrumpledEnvelopeCard extends StatefulWidget {
  final Widget child;
  final String? handwrittenTitle;
  final VoidCallback? onTapEnvelope;
  final double width;
  final double height;

  const CrumpledEnvelopeCard({
    super.key,
    required this.child,
    this.handwrittenTitle,
    this.onTapEnvelope,
    this.width = 380,
    this.height = 650,
  });

  @override
  State<CrumpledEnvelopeCard> createState() => _CrumpledEnvelopeCardState();
}

class _CrumpledEnvelopeCardState extends State<CrumpledEnvelopeCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pulsating shadow opacity based on animation value
    final shadowOpacity = 0.24 + 0.06 * (0.5 - _controller.value);
    return ScaleTransition(
      scale: _scale,
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: widget.width,
            maxHeight: widget.height,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF380811).withValues(alpha: 0.5),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
              // Subtle pulsing shadow for extra love
              BoxShadow(
                color: Colors.black.withValues(alpha: shadowOpacity),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomPaint(
              painter: _CrumpledBurgundyBackgroundPainter(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Top Right South Indian Kolam Watermark Accent
                  Positioned(
                    top: 14,
                    right: 14,
                    child: CustomPaint(
                      size: const Size(48, 48),
                      painter: _SouthIndianKolamWatermarkPainter(),
                    ),
                  ),
                  // Bottom Left South Indian Kolam Watermark Accent
                  Positioned(
                    bottom: 14,
                    left: 14,
                    child: CustomPaint(
                      size: const Size(48, 48),
                      painter: _SouthIndianKolamWatermarkPainter(),
                    ),
                  ),
                  // 1. Tilted Kraft Paper Envelope with Red/Gold Heart
                  Positioned(
                    top: widget.height * 0.16,
                    child: Transform.rotate(
                      angle: -0.28, // ~16 degrees tilt
                      child: _buildKraftEnvelope(),
                    ),
                  ),
                  // 2. Overlapping Beige Card / Content Container with Zari Gold Border
                  Positioned(
                    left: 16,
                    right: 16,
                    top: widget.height * 0.35,
                    bottom: 24,
                    child: GestureDetector(
                      onTap: widget.onTapEnvelope,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFDF9), // Warm Sandalwood / Jasmine Cream paper
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFD4AF37), // Zari Gold Border
                            width: 1.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.24),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(18),
                        child: Stack(
                          children: [
                            // Inner Gold Zari Line Frame
                            Positioned.fill(
                              child: IgnorePointer(
                                child: Container(
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: widget.child,
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
      ),
    );
  }

  // Tilted Kraft Paper Envelope with Brush Red Heart
  Widget _buildKraftEnvelope() {
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFC7AB88), // Realistic Kraft paper brown
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(4, 12),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _KraftEnvelopeFlapPainter(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Hand-painted Red Heart & Sunflower Stamp on the flap
            Positioned(
              top: 44,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    size: const Size(36, 32),
                    painter: _PaintedHeartPainter(),
                  ),
                  const SizedBox(width: 6),
                  CustomPaint(
                    size: const Size(32, 32),
                    painter: SunflowerMotifPainter(),
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

/// Custom Painter for Crumpled Burgundy Wrinkled Paper Background
class _CrumpledBurgundyBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    final rect = Offset.zero & size;

    // Deep Burgundy Base Gradient
    final baseGradient = RadialGradient(
      center: Alignment.center,
      radius: 1.1,
      colors: const [
        Color(0xFF7A1C29), // Rich Deep Red
        Color(0xFF5A101D), // Dark Wine Burgundy
        Color(0xFF380811), // Shadows
      ],
      stops: const [0.0, 0.65, 1.0],
    );

    final paint = Paint()..shader = baseGradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // Procedural Wrinkle Creases & Shadows
    final random = Random(101); // Fixed seed for consistent organic wrinkles
    final creasePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final width = size.width;
    final height = size.height;

    // Draw main diagonal & interconnecting paper fold lines
    final numFolds = 35;
    for (int i = 0; i < numFolds; i++) {
      final p1 = Offset(
        random.nextDouble() * width,
        random.nextDouble() * height,
      );
      final p2 = Offset(
        p1.dx + (random.nextDouble() - 0.5) * 220,
        p1.dy + (random.nextDouble() - 0.5) * 220,
      );

      // Dark crease shadow
      creasePaint.color = Colors.black.withValues(alpha: 0.14 + random.nextDouble() * 0.12);
      creasePaint.strokeWidth = 1.5 + random.nextDouble() * 2.5;
      canvas.drawLine(p1, p2, creasePaint);

      // Parallel highlight line (gives 3D fold reflection)
      creasePaint.color = Colors.white.withValues(alpha: 0.05 + random.nextDouble() * 0.08);
      creasePaint.strokeWidth = 1.0 + random.nextDouble() * 1.5;
      canvas.drawLine(
        Offset(p1.dx + 1.2, p1.dy + 1.2),
        Offset(p2.dx + 1.2, p2.dy + 1.2),
        creasePaint,
      );
    }

    // Triangular paper facet shading to mimic crumpled paper effect
    final facetPaint = Paint()..style = PaintingStyle.fill;
    final facetPath = Path();
    for (int i = 0; i < 18; i++) {
      final p1 = Offset(random.nextDouble() * width, random.nextDouble() * height);
      final p2 = Offset(p1.dx + (random.nextDouble() - 0.5) * 160, p1.dy + (random.nextDouble() - 0.5) * 160);
      final p3 = Offset(p1.dx + (random.nextDouble() - 0.5) * 160, p1.dy + (random.nextDouble() - 0.5) * 160);

      facetPath.reset();
      facetPath.moveTo(p1.dx, p1.dy);
      facetPath.lineTo(p2.dx, p2.dy);
      facetPath.lineTo(p3.dx, p3.dy);
      facetPath.close();

      final isHighlight = random.nextBool();
      facetPaint.color = isHighlight
          ? Colors.white.withValues(alpha: 0.03 + random.nextDouble() * 0.03)
          : Colors.black.withValues(alpha: 0.08 + random.nextDouble() * 0.07);
      canvas.drawPath(facetPath, facetPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Painter for Kraft Paper Flap Lines
class _KraftEnvelopeFlapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    final flapPath = Path();
    // Top V-shaped envelope flap
    flapPath.moveTo(0, 0);
    flapPath.lineTo(size.width / 2, size.height * 0.48);
    flapPath.lineTo(size.width, 0);
    flapPath.close();

    // Darker kraft paper shade for flap shadow depth
    final flapPaint = Paint()
      ..color = const Color(0xFFBA9E7B)
      ..style = PaintingStyle.fill;

    canvas.drawPath(flapPath, flapPaint);

    // Flap outline shadow
    final linePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawPath(flapPath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Painter for Hand-Painted Red Heart Seal
class _PaintedHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    final heartPath = Path();
    final width = size.width;
    final height = size.height;

    // Smooth hand-brushed heart curve
    heartPath.moveTo(width / 2, height * 0.85);
    heartPath.cubicTo(
      width * 0.1,
      height * 0.5,
      0,
      height * 0.15,
      width * 0.28,
      height * 0.05,
    );
    heartPath.cubicTo(
      width * 0.42,
      height * 0.02,
      width / 2,
      height * 0.25,
      width / 2,
      height * 0.28,
    );
    heartPath.cubicTo(
      width / 2,
      height * 0.25,
      width * 0.58,
      height * 0.02,
      width * 0.72,
      height * 0.05,
    );
    heartPath.cubicTo(
      width,
      height * 0.15,
      width * 0.9,
      height * 0.5,
      width / 2,
      height * 0.85,
    );
    heartPath.close();

    // Rich crimson brush fill
    final heartPaint = Paint()
      ..color = const Color(0xFFC0262D)
      ..style = PaintingStyle.fill;

    canvas.drawPath(heartPath, heartPaint);

    // Inner painted brush stroke texture
    final strokePaint = Paint()
      ..color = const Color(0xFF91161C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    canvas.drawPath(heartPath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Painter for Subtle South Indian Kolam Background Watermark
class _SouthIndianKolamWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    final paint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2.5;

    for (int i = 0; i < 4; i++) {
      final angle = (i * 90) * pi / 180;
      final path = Path();
      path.moveTo(center.dx, center.dy);
      path.quadraticBezierTo(
        center.dx + r * cos(angle + 0.4),
        center.dy + r * sin(angle + 0.4),
        center.dx + r * cos(angle),
        center.dy + r * sin(angle),
      );
      canvas.drawPath(path, paint);
    }
    canvas.drawCircle(center, r * 0.4, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

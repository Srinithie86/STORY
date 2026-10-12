import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';

/// Clean Scrollable Comic Gift Card featuring "I have a gift for you... It's me ♡!"
/// Exactly matches reference image 1, 2, and 3 without extra text or photo cards.
class LongLineGiftCard extends StatefulWidget {
  const LongLineGiftCard({super.key});

  @override
  State<LongLineGiftCard> createState() => _LongLineGiftCardState();
}

class _LongLineGiftCardState extends State<LongLineGiftCard> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isMobile ? 360 : 660,
        maxHeight: isMobile ? 380 : 440,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5EC), // Warm Cream Parchment Paper
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD4AF37).withValues(alpha: 0.6), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 6-Page Extended Carousel
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              // PAGE 1: Bean character "I have a gift for you"
              _buildPage1(isMobile),

              // PAGE 2 to 5: Clean continuous line only (NO TEXT)
              _buildCleanLinePage(),
              _buildCleanLinePage(),
              _buildCleanLinePage(),
              _buildCleanLinePage(),

              // PAGE 6: Final reveal pointing to "It's me ♡" (NO extra photo card)
              _buildFinalRevealPage(isMobile),
            ],
          ),

          // Left Navigation Arrow Button
          if (_currentPage > 0)
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  onPressed: _prevPage,
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.chevron_left_rounded, color: Colors.black87, size: 24),
                  ),
                ),
              ),
            ),

          // Right Navigation Arrow Button
          if (_currentPage < _totalPages - 1)
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  onPressed: _nextPage,
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.chevron_right_rounded, color: Colors.black87, size: 24),
                  ),
                ),
              ),
            ),

          // Bottom Carousel Page Indicators (○ ○ ○ ○ ○ ○)
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_totalPages, (index) {
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 16 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: _currentPage == index
                          ? const Color(0xFF6B0F1A)
                          : Colors.black.withValues(alpha: 0.2),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // Page 1: Bean Character + "I have a gift for you"
  Widget _buildPage1(bool isMobile) {
    return CustomPaint(
      painter: _GiftPage1Painter(),
      child: Stack(
        children: [
          Positioned(
            right: isMobile ? 24 : 54,
            top: isMobile ? 70 : 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I have",
                  style: GoogleFonts.caveat(
                    fontSize: isMobile ? 34 : 44,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C2523),
                  ),
                ),
                Text(
                  "a",
                  style: GoogleFonts.caveat(
                    fontSize: isMobile ? 34 : 44,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C2523),
                  ),
                ),
                Text(
                  "gift for",
                  style: GoogleFonts.caveat(
                    fontSize: isMobile ? 34 : 44,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C2523),
                  ),
                ),
                Text(
                  "you",
                  style: GoogleFonts.caveat(
                    fontSize: isMobile ? 34 : 44,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2C2523),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Intermediate Pages: Clean Continuous Straight Line Only (NO TEXT AT ALL)
  Widget _buildCleanLinePage() {
    return CustomPaint(
      painter: _GiftPage2Painter(),
    );
  }

  // Page 6: Final Reveal pointing to "It's me ♡" (Exact Reference Image 3)
  Widget _buildFinalRevealPage(bool isMobile) {
    return CustomPaint(
      painter: _GiftPage3Painter(),
      child: Stack(
        children: [
          // Handwritten Text "It's me ♡"
          Positioned(
            left: isMobile ? 90 : 160,
            top: isMobile ? 50 : 75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "It's",
                      style: GoogleFonts.caveat(
                        fontSize: isMobile ? 42 : 54,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2C2523),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "me ♡",
                      style: GoogleFonts.caveat(
                        fontSize: isMobile ? 42 : 54,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFD32F2F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  constraints: BoxConstraints(maxWidth: isMobile ? 220 : 320),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0F2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFFFB74D), width: 1),
                  ),
                  child: Text(
                    "I am your forever gift, your best friend, and the one who will love you through every single chapter! 🫂❤️✨",
                    style: GoogleFonts.montserrat(
                      fontSize: isMobile ? 11 : 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF6B0F1A),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter for Page 1: Cute Bean Character + Hand Extension Line
class _GiftPage1Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final w = size.width;
    final h = size.height;

    final linePaint = Paint()
      ..color = const Color(0xFF2C2523)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final fillWhite = Paint()..color = const Color(0xFFFFFDF9);
    final blushPaint = Paint()..color = const Color(0xFFFF8A80).withValues(alpha: 0.5);
    final heartPaint = Paint()..color = const Color(0xFFE57373);

    // Bean Character Body
    final beanCenter = Offset(w * 0.28, h * 0.52);
    final beanRect = Rect.fromCenter(center: beanCenter, width: w * 0.24, height: h * 0.48);

    canvas.drawRRect(RRect.fromRectAndRadius(beanRect, Radius.circular(w * 0.12)), fillWhite);
    canvas.drawRRect(RRect.fromRectAndRadius(beanRect, Radius.circular(w * 0.12)), linePaint);

    // Eyes
    canvas.drawCircle(Offset(w * 0.24, h * 0.42), 3.5, Paint()..color = const Color(0xFF2C2523));
    canvas.drawCircle(Offset(w * 0.32, h * 0.42), 3.5, Paint()..color = const Color(0xFF2C2523));

    // Blush Cheeks
    canvas.drawCircle(Offset(w * 0.21, h * 0.46), 6.0, blushPaint);
    canvas.drawCircle(Offset(w * 0.35, h * 0.46), 6.0, blushPaint);

    // Smile
    final smilePath = Path();
    smilePath.moveTo(w * 0.26, h * 0.47);
    smilePath.quadraticBezierTo(w * 0.28, h * 0.51, w * 0.30, h * 0.47);
    canvas.drawPath(smilePath, linePaint);

    // Left Arm behind back
    final armLeft = Path();
    armLeft.moveTo(w * 0.16, h * 0.52);
    armLeft.lineTo(w * 0.12, h * 0.58);
    armLeft.lineTo(w * 0.17, h * 0.63);
    canvas.drawPath(armLeft, linePaint);

    // Legs
    canvas.drawLine(Offset(w * 0.23, h * 0.76), Offset(w * 0.23, h * 0.88), linePaint);
    canvas.drawLine(Offset(w * 0.33, h * 0.76), Offset(w * 0.33, h * 0.88), linePaint);
    canvas.drawCircle(Offset(w * 0.22, h * 0.88), 3.5, Paint()..color = const Color(0xFF2C2523));
    canvas.drawCircle(Offset(w * 0.34, h * 0.88), 3.5, Paint()..color = const Color(0xFF2C2523));

    // Right Arm holding out horizontal long line
    canvas.drawLine(Offset(w * 0.40, h * 0.55), Offset(w, h * 0.55), linePaint);

    // Floating Hearts 💕
    _drawHeart(canvas, Offset(w * 0.08, h * 0.42), 12, heartPaint);
    _drawHeart(canvas, Offset(w * 0.14, h * 0.30), 16, heartPaint);
    _drawHeart(canvas, Offset(w * 0.11, h * 0.66), 14, heartPaint);
  }

  void _drawHeart(Canvas canvas, Offset c, double size, Paint paint) {
    final path = Path();
    final s = size;
    path.moveTo(c.dx, c.dy + s * 0.3);
    path.cubicTo(c.dx - s * 0.5, c.dy - s * 0.2, c.dx - s, c.dy + s * 0.3, c.dx, c.dy + s);
    path.cubicTo(c.dx + s, c.dy + s * 0.3, c.dx + s * 0.5, c.dy - s * 0.2, c.dx, c.dy + s * 0.3);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter for Intermediate Pages: Clean Continuous Straight Line
class _GiftPage2Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final linePaint = Paint()
      ..color = const Color(0xFF2C2523)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8;

    canvas.drawLine(Offset(0, size.height * 0.55), Offset(size.width, size.height * 0.55), linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter for Page 6: Looping Line with Pointing Finger Hand
class _GiftPage3Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final w = size.width;
    final h = size.height;

    final linePaint = Paint()
      ..color = const Color(0xFF2C2523)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final fillWhite = Paint()..color = const Color(0xFFFFFDF9);
    final heartPaint = Paint()..color = const Color(0xFFE57373);

    // Line entering from left, looping right and bending back left pointing at "It's me ♡"!
    final loopPath = Path();
    loopPath.moveTo(0, h * 0.55);
    loopPath.lineTo(w * 0.72, h * 0.55);
    loopPath.cubicTo(w * 0.94, h * 0.55, w * 0.94, h * 0.30, w * 0.72, h * 0.30);
    loopPath.lineTo(w * 0.54, h * 0.30);
    canvas.drawPath(loopPath, linePaint);

    // Pointing Finger Hand 👉 pointing left towards "It's me ♡"
    final handX = w * 0.54;
    final handY = h * 0.30;

    final handPath = Path();
    handPath.moveTo(handX, handY - 10);
    handPath.lineTo(handX - 24, handY - 10);
    handPath.lineTo(handX - 24, handY + 10);
    handPath.lineTo(handX - 8, handY + 10);
    handPath.lineTo(handX, handY + 4);
    handPath.close();

    canvas.drawPath(handPath, fillWhite);
    canvas.drawPath(handPath, linePaint);

    // Pointing index finger tip
    canvas.drawLine(Offset(handX - 24, handY - 6), Offset(handX - 34, handY - 6), linePaint);

    // Floating Hearts 💕
    _drawHeart(canvas, Offset(w * 0.82, h * 0.22), 16, heartPaint);
    _drawHeart(canvas, Offset(w * 0.90, h * 0.42), 18, heartPaint);
    _drawHeart(canvas, Offset(w * 0.80, h * 0.65), 14, heartPaint);
  }

  void _drawHeart(Canvas canvas, Offset c, double size, Paint paint) {
    final path = Path();
    final s = size;
    path.moveTo(c.dx, c.dy + s * 0.3);
    path.cubicTo(c.dx - s * 0.5, c.dy - s * 0.2, c.dx - s, c.dy + s * 0.3, c.dx, c.dy + s);
    path.cubicTo(c.dx + s, c.dy + s * 0.3, c.dx + s * 0.5, c.dy - s * 0.2, c.dx, c.dy + s * 0.3);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

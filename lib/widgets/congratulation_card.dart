import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';

/// 100% Reference-Matched Interactive Birthday Surprise Gift Card Flow:
/// - Screen 0: "Happy birthday, love! do you wanna open your gift" with 3D Red Gift Box & [YES] / [NO]
/// - Screen 1 (If [NO]): "how dare you???" with Angry Knife Chick & [TRY AGAIN]
/// - Screen 2 (If [YES]): "Tap to open" with Dark Red Stitched Heart Envelope
/// - Screen 3: "I LOVE YOU THIIIS MUCH" Flork Pop-up Card & Penguin with Balloons + [next]
/// - Screen 4: "Hugging you through my phone" with Green Baby Dino Hugging Phone + [next]
/// - Screen 5: "Flowers for you cutie" with Flork Roses, "You're perfect." 💋, and Blushing Chibi + [next]
/// - Screen 6: "Happy Birthday — Make a wish" with Birthday Cake & Party Popper + [Blow] & [Replay ↺]
class CongratulationCard extends StatefulWidget {
  const CongratulationCard({super.key});

  @override
  State<CongratulationCard> createState() => _CongratulationCardState();
}

class _CongratulationCardState extends State<CongratulationCard>
    with TickerProviderStateMixin {
  // 0: Question, 1: Angry Chick, 2: Tap to Open, 3: Flork Love, 4: Dino Hug, 5: Flowers Cutie, 6: Cake Blow
  int _currentStep = 0;
  bool _isCandleBlown = false;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  late AnimationController _giftPulseController;
  late AnimationController _confettiController;
  final List<_ConfettiParticle> _confettiParticles = [];
  final Random _rnd = Random();

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _shakeAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );

    _giftPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..addListener(() {
        if (_confettiController.isAnimating) {
          setState(() {
            for (var p in _confettiParticles) {
              p.update();
            }
          });
        }
      });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _giftPulseController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _clickNo() {
    setState(() {
      _currentStep = 1; // "how dare you???"
    });
    _shakeController.forward(from: 0.0);
  }

  void _clickYes() {
    setState(() {
      _currentStep = 2; // "Tap to open"
    });
  }

  void _tryAgain() {
    setState(() {
      _currentStep = 0; // Back to gift question
    });
  }

  void _openEnvelope() {
    setState(() {
      _currentStep = 3; // Flork pop-up
    });
    _triggerConfetti();
  }

  void _nextStep() {
    setState(() {
      if (_currentStep < 6) {
        _currentStep++;
        if (_currentStep == 6) {
          _isCandleBlown = false;
        }
      } else {
        _currentStep = 0;
        _isCandleBlown = false;
      }
    });
  }

  void _blowCandle() {
    if (_isCandleBlown) return;
    setState(() {
      _isCandleBlown = true;
    });
    _triggerConfetti();
  }

  void _triggerConfetti() {
    _confettiParticles.clear();
    for (int i = 0; i < 50; i++) {
      _confettiParticles.add(
        _ConfettiParticle(
          x: 100 + _rnd.nextDouble() * 380,
          y: 60 + _rnd.nextDouble() * 180,
          vx: (_rnd.nextDouble() - 0.5) * 9,
          vy: -3 - _rnd.nextDouble() * 7,
          size: 6 + _rnd.nextDouble() * 9,
          color: [
            const Color(0xFFE53935),
            const Color(0xFFFFD54F),
            const Color(0xFF81C784),
            const Color(0xFF64B5F6),
            const Color(0xFFBA68C8),
            const Color(0xFFFF8A80),
            const Color(0xFFFF4081),
          ][_rnd.nextInt(7)],
        ),
      );
    }
    _confettiController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_currentStep == 1 ? _shakeAnimation.value : 0.0, 0.0),
          child: Center(
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: isMobile ? 380 : 580,
                minHeight: isMobile ? 480 : 540,
              ),
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3D271D).withValues(alpha: 0.08),
                    blurRadius: 28,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: const Color(0xFFB69A68).withValues(alpha: 0.06),
                    blurRadius: 14,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: CustomPaint(
                  painter: _GinghamBorderPainter(),
                  child: Container(
                    margin: const EdgeInsets.all(14), // Gingham border margin
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFDF9), // Warm ivory parchment
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE8DDD2),
                        width: 1.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CustomPaint(
                        painter: _GraphPaperPainter(),
                        child: Stack(
                          children: [
                            // 4 Gold Corner Stars
                            const Positioned(
                              top: 8,
                              left: 8,
                              child: _CornerStar(),
                            ),
                            const Positioned(
                              top: 8,
                              right: 8,
                              child: _CornerStar(),
                            ),
                            const Positioned(
                              bottom: 8,
                              left: 8,
                              child: _CornerStar(),
                            ),
                            const Positioned(
                              bottom: 8,
                              right: 8,
                              child: _CornerStar(),
                            ),

                            // Top Bunting Banners across the whole card (shown on screens 2..6)
                            if (_currentStep >= 2)
                              Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                height: 50,
                                child: IgnorePointer(
                                  child: CustomPaint(
                                    painter: _TopBuntingBannerPainter(),
                                  ),
                                ),
                              ),

                            // Main Interactive Content Screen
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 350),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              child: _buildCurrentScreen(isMobile),
                            ),

                            // Confetti Particle Layer
                            if (_confettiParticles.isNotEmpty)
                              Positioned.fill(
                                child: IgnorePointer(
                                  child: CustomPaint(
                                    painter: _ConfettiPainter(_confettiParticles),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentScreen(bool isMobile) {
    Widget content;
    switch (_currentStep) {
      case 0:
        content = _buildQuestionScreen(isMobile);
        break;
      case 1:
        content = _buildAngryScreen(isMobile);
        break;
      case 2:
        content = _buildTapToOpenScreen(isMobile);
        break;
      case 3:
        content = _buildFlorkLoveScreen(isMobile);
        break;
      case 4:
        content = _buildDinoHugScreen(isMobile);
        break;
      case 5:
        content = _buildFlowersCutieScreen(isMobile);
        break;
      case 6:
      default:
        content = _buildMakeAWishCakeScreen(isMobile);
        break;
    }
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: content,
      ),
    );
  }

  // ==========================================
  // SCREEN 0: "Happy birthday, love! do you wanna open your gift"
  // ==========================================
  Widget _buildQuestionScreen(bool isMobile) {
    return Padding(
      key: const ValueKey<int>(0),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 32,
        vertical: isMobile ? 24 : 36,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Happy birthday, love!",
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF4A3228),
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "do you wanna open your gift",
            textAlign: TextAlign.center,
            style: GoogleFonts.caveat(
              fontSize: isMobile ? 21 : 26,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF80604B),
            ),
          ),
          SizedBox(height: isMobile ? 20 : 28),

          // 3D Red Gift Box
          AnimatedBuilder(
            animation: _giftPulseController,
            builder: (context, child) {
              final scale = 1.0 + (_giftPulseController.value * 0.05);
              return Transform.scale(
                scale: scale,
                child: child,
              );
            },
            child: Container(
              width: isMobile ? 170 : 210,
              height: isMobile ? 170 : 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3D271D).withValues(alpha: 0.10),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/photos/red_gift_box.jpg',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => _buildGiftBoxIllustration(isMobile),
                ),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 28 : 36),

          // [✔ YES] and [✖ NO] Buttons
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _clickYes,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 26 : 34,
                      vertical: isMobile ? 10 : 13,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9E4B57), Color(0xFF722F37)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE2C89A), width: 1.4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF722F37).withValues(alpha: 0.28),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded, size: 18, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "YES",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                InkWell(
                  onTap: _clickNo,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 26 : 34,
                      vertical: isMobile ? 10 : 13,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9F1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE5DDD0), width: 1.4),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF80604B).withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.close_rounded, size: 18, color: Color(0xFF80604B)),
                        const SizedBox(width: 8),
                        Text(
                          "NO",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: isMobile ? 14 : 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            color: const Color(0xFF80604B),
                          ),
                        ),
                      ],
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

  // ==========================================
  // SCREEN 1: "how dare you???" (Angry Knife Chick)
  // ==========================================
  Widget _buildAngryScreen(bool isMobile) {
    return Padding(
      key: const ValueKey<int>(1),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 36,
        vertical: isMobile ? 24 : 36,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "how dare you???",
            textAlign: TextAlign.center,
            style: GoogleFonts.caveat(
              fontSize: isMobile ? 32 : 44,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF722F37),
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),

          Container(
            width: isMobile ? 190 : 230,
            height: isMobile ? 190 : 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3D271D).withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/photos/angry_knife_chick.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildAngryChickIllustration(isMobile),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 26 : 34),

          // [TRY AGAIN] Button
          InkWell(
            onTap: _tryAgain,
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 30 : 42,
                vertical: isMobile ? 10 : 13,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF9F1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFF5A3E2B), width: 1.8),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF5A3E2B).withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                "TRY AGAIN",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: const Color(0xFF382319),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SCREEN 2: "Tap to open" (Dark Red Envelope with Stitched Heart)
  // ==========================================
  Widget _buildTapToOpenScreen(bool isMobile) {
    return Padding(
      key: const ValueKey<int>(2),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: isMobile ? 24 : 36,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            "Tap to open",
            textAlign: TextAlign.center,
            style: GoogleFonts.cinzel(
              fontSize: isMobile ? 24 : 30,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF4A3228),
            ),
          ),
          SizedBox(height: isMobile ? 22 : 30),

          GestureDetector(
            onTap: _openEnvelope,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: isMobile ? 230 : 290,
                height: isMobile ? 150 : 180,
                decoration: BoxDecoration(
                  color: const Color(0xFF722F37), // Muted burgundy envelope
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFB69A68),
                    width: 1.2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF722F37).withValues(alpha: 0.30),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: Size(isMobile ? 230 : 290, isMobile ? 150 : 180),
                      painter: _EnvelopeLidPainter(),
                    ),

                    SizedBox(
                      width: isMobile ? 84 : 104,
                      height: isMobile ? 84 : 104,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: Size(isMobile ? 84 : 104, isMobile ? 84 : 104),
                            painter: _StitchedHeartPainter(),
                          ),
                          Text(
                            "OPEN",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: isMobile ? 12 : 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                              color: const Color(0xFF722F37),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 20 : 26),
          Text(
            "tap the heart to reveal your gift ♡",
            style: GoogleFonts.caveat(
              fontSize: isMobile ? 18 : 22,
              color: const Color(0xFF80604B),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SCREEN 3: "I LOVE YOU THIIIS MUCH" (Flork Pop-up Card & Penguin)
  // ==========================================
  Widget _buildFlorkLoveScreen(bool isMobile) {
    return Padding(
      key: const ValueKey<int>(3),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: isMobile ? 20 : 28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isMobile ? 12 : 18),
          Container(
            width: isMobile ? 270 : 370,
            height: isMobile ? 210 : 270,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/photos/flork_love_penguin.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildFlorkLoveIllustration(isMobile),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 18 : 26),

          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: _nextStep,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 32 : 44,
                  vertical: isMobile ? 9 : 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9E4B57), Color(0xFF722F37)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2C89A), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF722F37).withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "next",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SCREEN 4: "Hugging you through my phone" (Green Baby Dino Hug)
  // ==========================================
  Widget _buildDinoHugScreen(bool isMobile) {
    return Padding(
      key: const ValueKey<int>(4),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: isMobile ? 20 : 28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            "Hugging you through my phone",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF282522),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 18),

          Container(
            width: isMobile ? 270 : 370,
            height: isMobile ? 210 : 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3D271D).withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/photos/dino_hug_phone.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildDinoHugIllustration(isMobile),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 18 : 24),

          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: _nextStep,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 32 : 44,
                  vertical: isMobile ? 9 : 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9E4B57), Color(0xFF722F37)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2C89A), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF722F37).withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "next",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SCREEN 5: "Flowers for you cutie" (Flork Red Roses & Blushing Chibi)
  // ==========================================
  Widget _buildFlowersCutieScreen(bool isMobile) {
    return Padding(
      key: const ValueKey<int>(5),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: isMobile ? 20 : 28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            "Flowers for you cutie",
            textAlign: TextAlign.center,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 20 : 26,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF282522),
            ),
          ),
          SizedBox(height: isMobile ? 12 : 18),

          Container(
            width: isMobile ? 270 : 370,
            height: isMobile ? 210 : 260,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3D271D).withValues(alpha: 0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/photos/flork_roses_cutie.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => _buildFlorkRosesIllustration(isMobile),
              ),
            ),
          ),

          SizedBox(height: isMobile ? 18 : 24),

          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: _nextStep,
              borderRadius: BorderRadius.circular(24),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 32 : 44,
                  vertical: isMobile ? 9 : 12,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9E4B57), Color(0xFF722F37)],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2C89A), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF722F37).withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  "next",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // SCREEN 6: "Happy Birthday — Make a wish" (Cake, Party Popper & Candle Blow)
  // ==========================================
  Widget _buildMakeAWishCakeScreen(bool isMobile) {
    return Padding(
      key: const ValueKey<int>(6),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 28,
        vertical: isMobile ? 20 : 28,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isMobile ? 6 : 10),
          Text(
            "Happy Birthday",
            textAlign: TextAlign.center,
            style: GoogleFonts.greatVibes(
              fontSize: isMobile ? 38 : 52,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF722F37),
            ),
          ),
          const SizedBox(height: 8),

          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: isMobile ? 270 : 370,
                height: isMobile ? 190 : 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/photos/cake_make_a_wish.jpg',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => _buildCakeIllustration(isMobile),
                  ),
                ),
              ),
              if (_isCandleBlown)
                Positioned(
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF722F37),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFFB69A68), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF722F37).withValues(alpha: 0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Text(
                      "✨ WISH GRANTED! ✨",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: isMobile ? 12 : 18),

          if (!_isCandleBlown) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Make a wish",
                  style: GoogleFonts.caveat(
                    fontSize: isMobile ? 22 : 27,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF4A3228),
                  ),
                ),
                const SizedBox(width: 14),
                InkWell(
                  onTap: _blowCandle,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : 32,
                      vertical: isMobile ? 7 : 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF9E4B57), Color(0xFF722F37)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFE2C89A), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF722F37).withValues(alpha: 0.25),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "Blow",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isMobile ? 14 : 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            Text(
              "“Happy Birthday to my favorite human in the whole world! I love you endlessly, Selvakumar! ❤️”",
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: isMobile ? 15 : 18,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF282522),
              ),
            ),
            const SizedBox(height: 14),
            OutlinedButton(
              onPressed: _nextStep,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF722F37),
                side: const BorderSide(color: Color(0xFF722F37), width: 1.4),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 22 : 30,
                  vertical: isMobile ? 9 : 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text("Replay Surprise ↺"),
            ),
          ],
        ],
      ),
    );
  }

  // =========================================================================
  // CARTOON FALLBACK ILLUSTRATIONS (Prevent any broken cross / 404 image errors)
  // =========================================================================
  Widget _buildGiftBoxIllustration(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE57373), width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🎁", style: TextStyle(fontSize: 64)),
            const SizedBox(height: 8),
            Text(
              "A Special Gift For Mani ♡",
              style: GoogleFonts.caveat(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFC62828),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAngryChickIllustration(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9C4), // Pastel yellow
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFB300), width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("💢", style: TextStyle(fontSize: 22)),
                SizedBox(width: 6),
                Text("🐥🔪", style: TextStyle(fontSize: 54)),
                SizedBox(width: 6),
                Text("⚡", style: TextStyle(fontSize: 20)),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF990000),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "( Ò ‸ Ó ) 🔪",
                style: GoogleFonts.outfit(
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "“HOW DARE YOU SAY NO?!”",
              style: GoogleFonts.caveat(
                fontSize: isMobile ? 15 : 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlorkLoveIllustration(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFB6C1), width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("💖", style: TextStyle(fontSize: 22)),
                SizedBox(width: 8),
                Text("🐧  \\ (•◡•) /  💕", style: TextStyle(fontSize: 26)),
                SizedBox(width: 8),
                Text("💖", style: TextStyle(fontSize: 22)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              "“I LOVE YOU THIIIS MUCH!”",
              style: GoogleFonts.comicNeue(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF8B0000),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "to infinity and beyond ♡",
              style: GoogleFonts.caveat(
                fontSize: isMobile ? 14 : 17,
                color: const Color(0xFFC2185B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDinoHugIllustration(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA5D6A7), width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("🦖📱💕", style: TextStyle(fontSize: 48)),
            const SizedBox(height: 10),
            Text(
              "Hugging you through the phone!",
              style: GoogleFonts.comicNeue(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1B5E20),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "even across miles, I'm holding you tight ♡",
              style: GoogleFonts.caveat(
                fontSize: isMobile ? 14 : 17,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlorkRosesIllustration(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFCC80), width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("💐🌹✨", style: TextStyle(fontSize: 48)),
            const SizedBox(height: 10),
            Text(
              "Flowers for my cutie Mani!",
              style: GoogleFonts.comicNeue(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFE65100),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "you deserve all the flowers in the world ♡",
              style: GoogleFonts.caveat(
                fontSize: isMobile ? 14 : 17,
                color: const Color(0xFFBF360C),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCakeIllustration(bool isMobile) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE082), width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _isCandleBlown ? "🎂✨🎉" : "🎂🕯️✨",
              style: const TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 10),
            Text(
              _isCandleBlown ? "Wish Granted! 💫" : "Make a wish and blow the candle!",
              style: GoogleFonts.comicNeue(
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Red and White Gingham / Buffalo Plaid Checkered Border Painter
class _GinghamBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    const double tileSize = 12.0;

    final rosePaint = Paint()..color = const Color(0xFFD7A6A1); // Soft dusty rose
    final peachPaint = Paint()..color = const Color(0xFFFFF2EB); // Muted peach cream
    final creamPaint = Paint()..color = const Color(0xFFFFF9F1); // Pure cream

    final int cols = (size.width / tileSize).ceil();
    final int rows = (size.height / tileSize).ceil();

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final rect = Rect.fromLTWH(c * tileSize, r * tileSize, tileSize, tileSize);
        if (r % 2 == 0) {
          canvas.drawRect(rect, c % 2 == 0 ? rosePaint : peachPaint);
        } else {
          canvas.drawRect(rect, c % 2 == 0 ? peachPaint : creamPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Graph Paper Grid Pattern Painter
class _GraphPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    const double gridSize = 18.0;

    final linePaint = Paint()
      ..color = const Color(0xFFF1EAE2)
      ..strokeWidth = 0.8;

    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }

    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Hand-drawn Crayon Star in Corner
class _CornerStar extends StatelessWidget {
  const _CornerStar();

  @override
  Widget build(BuildContext context) {
    return Text(
      "★",
      style: TextStyle(
        fontSize: 22,
        color: const Color(0xFFB69A68).withValues(alpha: 0.85), // Antique gold star
        shadows: [
          Shadow(
            color: const Color(0xFF3D271D).withValues(alpha: 0.10),
            blurRadius: 4,
            offset: const Offset(1, 2),
          ),
        ],
      ),
    );
  }
}

/// Full-width Responsive Top Bunting Banner Painter
/// Never overflows because widths are calculated dynamically from canvas size!
class _TopBuntingBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;

    final linePaint = Paint()
      ..color = const Color(0xFF722F37)
      ..strokeWidth = 1.3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = const Color(0xFFFBF0ED)
      ..style = PaintingStyle.fill;

    final bannerW = min(size.width * 0.42, 140.0);

    // Left curved string
    final leftPath = Path();
    leftPath.moveTo(6, 4);
    leftPath.quadraticBezierTo(bannerW * 0.5, size.height * 0.45, bannerW, size.height * 0.75);
    canvas.drawPath(leftPath, linePaint);

    // Left Pennants
    const int count = 4;
    for (int i = 0; i < count; i++) {
      final double t = (i + 0.5) / count;
      final double x = 6 + bannerW * t;
      final double y = 4 + size.height * (0.15 + t * 0.45);

      final p = Path();
      p.moveTo(x - 8, y);
      p.lineTo(x + 8, y);
      p.lineTo(x, y + 15);
      p.close();

      canvas.drawPath(p, fillPaint);
      canvas.drawPath(p, linePaint);
    }

    // Right curved string
    final rightPath = Path();
    rightPath.moveTo(size.width - 6, 4);
    rightPath.quadraticBezierTo(
      size.width - bannerW * 0.5,
      size.height * 0.45,
      size.width - bannerW,
      size.height * 0.75,
    );
    canvas.drawPath(rightPath, linePaint);

    // Right Pennants
    for (int i = 0; i < count; i++) {
      final double t = (i + 0.5) / count;
      final double x = size.width - 6 - bannerW * t;
      final double y = 4 + size.height * (0.15 + t * 0.45);

      final p = Path();
      p.moveTo(x - 8, y);
      p.lineTo(x + 8, y);
      p.lineTo(x, y + 15);
      p.close();

      canvas.drawPath(p, fillPaint);
      canvas.drawPath(p, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Envelope Lid lines painter
class _EnvelopeLidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    final linePaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.5, size.height * 0.52);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Stitched White Heart Painter
class _StitchedHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    final w = size.width;
    final h = size.height;

    final heartPath = Path();
    heartPath.moveTo(w / 2, h * 0.85);
    heartPath.cubicTo(w * 0.1, h * 0.52, 0, h * 0.2, w * 0.28, h * 0.08);
    heartPath.cubicTo(w * 0.44, h * 0.05, w / 2, h * 0.25, w / 2, h * 0.28);
    heartPath.cubicTo(w / 2, h * 0.25, w * 0.56, h * 0.05, w * 0.72, h * 0.08);
    heartPath.cubicTo(w, h * 0.2, w * 0.9, h * 0.52, w / 2, h * 0.85);
    heartPath.close();

    final fillPaint = Paint()
      ..color = const Color(0xFFFFFBF5)
      ..style = PaintingStyle.fill;
    canvas.drawPath(heartPath, fillPaint);

    final stitchPaint = Paint()
      ..color = const Color(0xFFB0A495)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(heartPath, stitchPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ConfettiParticle {
  double x;
  double y;
  double vx;
  double vy;
  double size;
  Color color;

  _ConfettiParticle({
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
    size = max(0.0, size - 0.12);
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  _ConfettiPainter(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty || size.width <= 0 || size.height <= 0) return;
    for (var p in particles) {
      if (p.size <= 0) continue;
      final paint = Paint()..color = p.color;
      canvas.drawCircle(Offset(p.x, p.y), p.size / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

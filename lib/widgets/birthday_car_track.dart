import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/responsive.dart';
import '../utils/theme.dart';

/// Interactive Birthday Car Track Card
/// Inspired by the viral "We are FINALLYYYYYYYYYYYY..." typography car loop trend.
/// Features a yellow/white car driving along text tracks of "HAPPY BIRTHDAY MANIIIIIIII...",
/// a full 360-degree roller-coaster loop-the-loop with the car upside down,
/// and arriving at the finish line with Selvakumar's gym photo, horn SFX, and confetti!
class BirthdayCarTrackCard extends StatefulWidget {
  const BirthdayCarTrackCard({super.key});

  @override
  State<BirthdayCarTrackCard> createState() => _BirthdayCarTrackCardState();
}

class _BirthdayCarTrackCardState extends State<BirthdayCarTrackCard>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 3;

  // Animation controller for the driving car
  late AnimationController _driveController;

  // Car customization: Yellow Car (default matching reference) or White Sports Car
  bool _isWhiteCar = false;

  // Playing state
  bool _isPlaying = true;

  // Sound horn effect state
  bool _isHonking = false;
  Timer? _honkTimer;

  // Particles for smoke exhaust / hearts
  final List<_ExhaustParticle> _particles = [];

  @override
  void initState() {
    super.initState();
    _driveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _driveController.addListener(() {
      _spawnParticle();
      setState(() {});
    });

    _driveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Auto-advance to next slide if playing
        if (_isPlaying) {
          if (_currentPage < _totalPages - 1) {
            Future.delayed(const Duration(milliseconds: 650), () {
              if (mounted && _isPlaying && _currentPage < _totalPages - 1) {
                _goToPage(_currentPage + 1);
              }
            });
          } else {
            // Reached slide 3! Wait 3.5 seconds celebration pause, then automatically loop back to slide 1
            Future.delayed(const Duration(milliseconds: 3500), () {
              if (mounted && _isPlaying) {
                _goToPage(0);
              }
            });
          }
        }
      }
    });

    // Start driving
    _driveController.forward();
  }

  void _spawnParticle() {
    if (_particles.length > 25) {
      _particles.removeAt(0);
    }
    // Update existing particles
    for (final p in _particles) {
      p.age += 0.05;
      p.opacity = math.max(0.0, 1.0 - p.age);
    }
    _particles.removeWhere((p) => p.opacity <= 0.0);
  }

  @override
  void dispose() {
    _honkTimer?.cancel();
    _driveController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _goToPage(int page) {
    if (page >= 0 && page < _totalPages) {
      setState(() {
        _currentPage = page;
      });
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
      _driveController.reset();
      if (_isPlaying) {
        _driveController.forward();
      }
    }
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        if (_driveController.isCompleted) {
          _driveController.reset();
        }
        _driveController.forward();
      } else {
        _driveController.stop();
      }
    });
  }

  void _honkHorn() {
    SystemSound.play(SystemSoundType.click);
    _honkTimer?.cancel();
    setState(() {
      _isHonking = true;
    });
    _honkTimer = Timer(const Duration(milliseconds: 400), () {
      if (mounted) {
        setState(() {
          _isHonking = false;
        });
      }
    });
  }

  void _restartRide() {
    _goToPage(0);
    setState(() {
      _isPlaying = true;
    });
    _driveController.reset();
    _driveController.forward();
  }

  String _formatTime() {
    final progress = _driveController.value;
    final totalSeconds = 4;
    final currentSeconds = (progress * totalSeconds).clamp(0, totalSeconds).toInt();
    return "0:0${currentSeconds.clamp(0, 4)} / 0:04";
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = isMobile ? math.min(screenWidth - 32, 360.0) : 680.0;
    final cardHeight = isMobile ? 440.0 : 500.0;

    return Center(
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF6F0), // Aesthetic cream parchment
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: const Color(0xFFE8DFD1),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
            BoxShadow(
              color: const Color(0xFFD4AF37).withValues(alpha: 0.12),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              // Subtle background paper texture tone
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFFAF6F0),
                        const Color(0xFFF7F0E4),
                      ],
                    ),
                  ),
                ),
              ),

              // Page View for the 3 Interactive Slides
              PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                  _driveController.reset();
                  if (_isPlaying) {
                    _driveController.forward();
                  }
                },
                children: [
                  _buildSlide1(cardWidth, cardHeight, isMobile),
                  _buildSlide2(cardWidth, cardHeight, isMobile),
                  _buildSlide3(cardWidth, cardHeight, isMobile),
                ],
              ),

              // Carousel Navigation Arrows (< and > matching the Instagram reference)
              if (_currentPage > 0)
                Positioned(
                  left: 12,
                  top: cardHeight * 0.44,
                  child: _buildNavArrow(
                    icon: Icons.chevron_left,
                    onTap: () => _goToPage(_currentPage - 1),
                  ),
                ),
              if (_currentPage < _totalPages - 1)
                Positioned(
                  right: 12,
                  top: cardHeight * 0.44,
                  child: _buildNavArrow(
                    icon: Icons.chevron_right,
                    onTap: () => _goToPage(_currentPage + 1),
                  ),
                ),

              // Bottom Video Overlay Bar (Play/Pause, Timer 0:01 / 0:04, dots, sound)
              Positioned(
                bottom: 10,
                left: isMobile ? 6 : 18,
                right: isMobile ? 6 : 18,
                child: Row(
                  children: [
                    // Play/Pause Icon Button
                    InkWell(
                      onTap: _togglePlayPause,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Icon(
                          _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          size: isMobile ? 18 : 22,
                          color: const Color(0xFF4A2835),
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 3 : 6),

                    // Time counter (0:01 / 0:04 matching reference)
                    Text(
                      _formatTime(),
                      style: GoogleFonts.spaceMono(
                        fontSize: isMobile ? 10 : 11.5,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6D4C41),
                      ),
                    ),
                    SizedBox(width: isMobile ? 4 : 10),

                    // Interactive Scrub Progress Bar
                    Expanded(
                      child: SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 2.0,
                          thumbShape: RoundSliderThumbShape(enabledThumbRadius: isMobile ? 4 : 5),
                          overlayShape: RoundSliderOverlayShape(overlayRadius: isMobile ? 8 : 10),
                          activeTrackColor: const Color(0xFF4A2835),
                          inactiveTrackColor: const Color(0xFFE2D8CD),
                          thumbColor: const Color(0xFF4A2835),
                        ),
                        child: Slider(
                          value: _driveController.value,
                          onChanged: (val) {
                            setState(() {
                              _driveController.value = val;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 4 : 8),

                    // Horn Audio Button
                    InkWell(
                      onTap: _honkHorn,
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                        child: Icon(
                          _isHonking ? Icons.volume_up_rounded : Icons.volume_down_rounded,
                          size: isMobile ? 16 : 19,
                          color: _isHonking ? const Color(0xFFD4AF37) : const Color(0xFF6D4C41),
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 2 : 4),

                    // Car Toggle Button (Yellow / White)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isWhiteCar = !_isWhiteCar;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                        child: Icon(
                          Icons.directions_car_rounded,
                          size: isMobile ? 16 : 19,
                          color: _isWhiteCar ? const Color(0xFF78909C) : const Color(0xFFD4AF37),
                        ),
                      ),
                    ),
                    SizedBox(width: isMobile ? 3 : 8),

                    // Slide Dots Indicator (● ○ ○)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(_totalPages, (i) {
                        return Container(
                          width: _currentPage == i ? 14 : 5,
                          height: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 2.0),
                          decoration: BoxDecoration(
                            color: _currentPage == i
                                ? const Color(0xFF4A2835)
                                : const Color(0xFFD7CCC8),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // Elegant subtle Honk notification
              if (_isHonking)
                Positioned(
                  bottom: 50,
                  right: 24,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF321E28),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            "HONK • MANI ❤️",
                            style: GoogleFonts.outfit(
                              fontSize: 10,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFFFD54F),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavArrow({required IconData icon, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.82),
            border: Border.all(
              color: const Color(0xFFE0D7CC),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 24,
            color: const Color(0xFF3E2723),
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // SLIDE 1: The Long Straight / Gentle Curve Track
  // Exactly matching Reference Image 1:
  // "Happy Birthday" (like "We are")
  // "MANIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII..."
  // =========================================================================
  Widget _buildSlide1(double width, double height, bool isMobile) {
    return Stack(
      children: [
        // Top Heading (clean, editorial typography matching reference)
        Positioned(
          top: 36,
          left: 36,
          child: Text(
            "Happy 25th Birthday",
            style: GoogleFonts.cormorantGaramond(
              fontSize: isMobile ? 38 : 48,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
              color: const Color(0xFF381F28),
              height: 1.0,
            ),
          ),
        ),

        // Custom Paint for the curved text track + Driving Car
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _driveController,
            builder: (context, child) {
              return CustomPaint(
                painter: _Slide1TrackPainter(
                  progress: _driveController.value,
                  isMobile: isMobile,
                  isWhiteCar: _isWhiteCar,
                ),
              );
            },
          ),
        ),

        // Dynamic Positioned Car Widget along the path
        _buildCarOnPath(
          pathBuilder: _getSlide1Path,
          size: Size(width, height),
          progress: _driveController.value,
          isMobile: isMobile,
        ),
      ],
    );
  }

  // =========================================================================
  // SLIDE 2: The Rollercoaster Loop-the-Loop!
  // Clean minimal editorial header & 360-degree ribbon loop
  // =========================================================================
  Widget _buildSlide2(double width, double height, bool isMobile) {
    return Stack(
      children: [
        // Top Editorial Title
        Positioned(
          top: 26,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              "Looping Into 25 ✦",
              style: GoogleFonts.cormorantGaramond(
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.2,
                fontStyle: FontStyle.italic,
                color: const Color(0xFF381F28),
              ),
            ),
          ),
        ),

        // Custom Paint for the loop track
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _driveController,
            builder: (context, child) {
              return CustomPaint(
                painter: _Slide2LoopTrackPainter(
                  progress: _driveController.value,
                  isMobile: isMobile,
                ),
              );
            },
          ),
        ),

        // Dynamic Positioned Car Widget looping upside-down
        _buildCarOnPath(
          pathBuilder: _getSlide2Path,
          size: Size(width, height),
          progress: _driveController.value,
          isMobile: isMobile,
        ),
      ],
    );
  }

  // =========================================================================
  // SLIDE 3: The Grand Finish Line & Celebration!
  // Arriving at the destination with pure gold 25th celebration milestone card (NO PHOTO).
  // =========================================================================
  Widget _buildSlide3(double width, double height, bool isMobile) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          isMobile ? 64 : 54,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Editorial Date Tag
            Text(
              "OCTOBER 13, 2026",
              style: AppTheme.monoStyle(
                fontSize: 11,
                letterSpacing: 3.0,
                color: const Color(0xFF4A2835),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),

            // Main Birthday Headline
            Text(
              "Happy 25th Birthday, Selvakumar",
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.5,
                color: const Color(0xFF381F28),
              ),
            ),
            const SizedBox(height: 18),

            // Pure Gold 25th Birthday Milestone Card (NO PHOTO - Pure Aesthetic Elegance)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(isMobile ? 18 : 24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFFBF2),
                    Color(0xFFFFF2DC),
                    Color(0xFFFFFBF2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFD4AF37),
                  width: 1.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.18),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Golden 25th Milestone Seal Emblem
                  Container(
                    width: isMobile ? 74 : 96,
                    height: isMobile ? 90 : 110,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6B0F1A), Color(0xFF381F28)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFFD4AF37),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.workspace_premium,
                          color: Color(0xFFFFD54F),
                          size: 20,
                        ),
                        Text(
                          "25",
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: isMobile ? 28 : 36,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFFFE082),
                            height: 1.0,
                          ),
                        ),
                        Text(
                          "YEARS",
                          style: AppTheme.monoStyle(
                            fontSize: 8,
                            letterSpacing: 1.8,
                            color: Colors.white.withValues(alpha: 0.85),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Love Message & Dedication
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "SELVAKUMAR",
                              style: GoogleFonts.outfit(
                                fontSize: isMobile ? 15 : 18,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                                color: const Color(0xFF381F28),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text("♡", style: TextStyle(color: Color(0xFF6B0F1A), fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "“To my greatest love, my strength, and my forever travel partner across every road of life — Happy 25th Birthday!”",
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: isMobile ? 13.5 : 15.5,
                            fontStyle: FontStyle.italic,
                            height: 1.35,
                            color: const Color(0xFF4E342E),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Mini badge
                        Row(
                          children: [
                            Image.asset(
                              _isWhiteCar
                                  ? 'assets/photos/white_car.png'
                                  : 'assets/photos/yellow_car.png',
                              width: 28,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "13 October 2026  ·  FOREVER",
                              style: AppTheme.monoStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF6B0F1A),
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
            const SizedBox(height: 20),

            // Sleek Replay Journey Button
            OutlinedButton.icon(
              onPressed: _restartRide,
              icon: const Icon(Icons.replay_rounded, size: 16),
              label: Text(
                "Replay Journey",
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF4A2835),
                side: const BorderSide(color: Color(0xFF4A2835), width: 1.2),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================================
  // Helper to place the car widget along the bezier path with rotation!
  // =========================================================================
  Widget _buildCarOnPath({
    required Path Function(Size size) pathBuilder,
    required Size size,
    required double progress,
    required bool isMobile,
  }) {
    final path = pathBuilder(size);
    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return const SizedBox.shrink();

    final metric = metrics.first;
    final totalLength = metric.length;
    final currentDistance = (progress * totalLength).clamp(0.0, totalLength);
    final tangent = metric.getTangentForOffset(currentDistance);

    if (tangent == null) return const SizedBox.shrink();

    final carWidth = isMobile ? 64.0 : 84.0;
    final carHeight = carWidth * 0.45;

    // Slight dynamic suspension bounce
    final bounce = math.sin(progress * math.pi * 16) * 1.5;

    return Positioned(
      left: tangent.position.dx - carWidth / 2,
      top: tangent.position.dy - carHeight * 0.85 + bounce,
      child: Transform.rotate(
        angle: tangent.angle,
        alignment: Alignment.center,
        child: SizedBox(
          width: carWidth,
          height: carHeight,
          child: Image.asset(
            _isWhiteCar ? 'assets/photos/white_car.png' : 'assets/photos/yellow_car.png',
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.amber,
              child: const Icon(Icons.directions_car, size: 28),
            ),
          ),
        ),
      ),
    );
  }

  // Path 1: Gentle downward slope for Slide 1
  Path _getSlide1Path(Size size) {
    final path = Path();
    final startY = size.height * 0.42;
    path.moveTo(size.width * 0.05, startY);
    path.cubicTo(
      size.width * 0.35,
      startY - 8,
      size.width * 0.65,
      startY + 50,
      size.width * 0.95,
      startY + 80,
    );
    return path;
  }

  // Path 2: Rollercoaster ribbon loop-the-loop for Slide 2
  Path _getSlide2Path(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    // Segment 1: Bottom left to center crossing
    path.moveTo(w * 0.08, h * 0.76);
    path.cubicTo(
      w * 0.22,
      h * 0.72,
      w * 0.38,
      h * 0.64,
      w * 0.50,
      h * 0.52,
    );

    // Segment 2: From crossing up to right of apex
    path.cubicTo(
      w * 0.62,
      h * 0.39,
      w * 0.66,
      h * 0.22,
      w * 0.58,
      h * 0.14,
    );

    // Segment 3: Round the apex (top of loop)
    path.cubicTo(
      w * 0.50,
      h * 0.07,
      w * 0.36,
      h * 0.12,
      w * 0.34,
      h * 0.22,
    );

    // Segment 4: Down left through center crossing
    path.cubicTo(
      w * 0.33,
      h * 0.35,
      w * 0.40,
      h * 0.45,
      w * 0.50,
      h * 0.52,
    );

    // Segment 5: Exit from crossing towards bottom right
    path.cubicTo(
      w * 0.60,
      h * 0.59,
      w * 0.78,
      h * 0.70,
      w * 0.92,
      h * 0.82,
    );

    return path;
  }
}

// Particle for smoke exhaust trail
class _ExhaustParticle {
  Offset position;
  double opacity;
  double age;
  _ExhaustParticle({required this.position, required this.opacity}) : age = 0.0;
}

// =============================================================================
// PAINTER FOR SLIDE 1 (Text Track "MANIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII...")
// =============================================================================
class _Slide1TrackPainter extends CustomPainter {
  final double progress;
  final bool isMobile;
  final bool isWhiteCar;

  _Slide1TrackPainter({
    required this.progress,
    required this.isMobile,
    required this.isWhiteCar,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final startY = size.height * 0.42;
    final path = Path();
    path.moveTo(size.width * 0.05, startY);
    path.cubicTo(
      size.width * 0.35,
      startY - 8,
      size.width * 0.65,
      startY + 50,
      size.width * 0.95,
      startY + 80,
    );

    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final totalLen = metric.length;

    // The repeated letters forming the track:
    // "MANIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
    final text = "MANIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII";
    final fontSize = isMobile ? 22.0 : 28.0;
    final charSpacing = isMobile ? 12.0 : 15.0;

    for (int i = 0; i < text.length; i++) {
      final dist = (i * charSpacing) + 12.0;
      if (dist >= totalLen) break;

      final tangent = metric.getTangentForOffset(dist);
      if (tangent == null) continue;

      final char = text[i];
      final textSpan = TextSpan(
        text: char,
        style: GoogleFonts.ebGaramond(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF4A2835), // Deep burgundy charcoal from reference
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(tangent.position.dx, tangent.position.dy);
      canvas.rotate(tangent.angle);
      // Position letter so its baseline rests on the path
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height * 0.75),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _Slide1TrackPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.isWhiteCar != isWhiteCar;
  }
}

// =============================================================================
// PAINTER FOR SLIDE 2 (The 360° Rollercoaster Ribbon Loop with "YYYYYYYY..." / "IIIIIIII...")
// =============================================================================
class _Slide2LoopTrackPainter extends CustomPainter {
  final double progress;
  final bool isMobile;

  _Slide2LoopTrackPainter({
    required this.progress,
    required this.isMobile,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final path = Path();
    path.moveTo(w * 0.08, h * 0.76);
    path.cubicTo(w * 0.22, h * 0.72, w * 0.38, h * 0.64, w * 0.50, h * 0.52);
    path.cubicTo(w * 0.62, h * 0.39, w * 0.66, h * 0.22, w * 0.58, h * 0.14);
    path.cubicTo(w * 0.50, h * 0.07, w * 0.36, h * 0.12, w * 0.34, h * 0.22);
    path.cubicTo(w * 0.33, h * 0.35, w * 0.40, h * 0.45, w * 0.50, h * 0.52);
    path.cubicTo(w * 0.60, h * 0.59, w * 0.78, h * 0.70, w * 0.92, h * 0.82);

    final metrics = path.computeMetrics().toList();
    if (metrics.isEmpty) return;
    final metric = metrics.first;
    final totalLen = metric.length;

    // In Reference Image 2, the loop is completely drawn with 'Y's
    // To celebrate Mani, we alternate "YYYYYYYYYYYYYYYYYYYYYY" and "IIIIIIIIIIII"
    final text = "YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY";
    final fontSize = isMobile ? 18.0 : 22.0;
    final charSpacing = isMobile ? 10.0 : 12.5;

    for (int i = 0; i < text.length; i++) {
      final dist = (i * charSpacing) + 8.0;
      if (dist >= totalLen) break;

      final tangent = metric.getTangentForOffset(dist);
      if (tangent == null) continue;

      final char = text[i];
      final textSpan = TextSpan(
        text: char,
        style: GoogleFonts.ebGaramond(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: const Color(0xFF4A2835),
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(tangent.position.dx, tangent.position.dy);
      canvas.rotate(tangent.angle);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height * 0.75),
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _Slide2LoopTrackPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/story_data.dart';
import '../models/memory.dart';
import '../utils/responsive.dart';
import 'photo_viewer.dart';

/// Clean, Beautiful, and Intensely Romantic Relationship Calendar Hero
/// Features:
/// 1. Selvakumar Gym / Couple / Beach background photo visible through a delicate, luminous frosted glass veil.
/// 2. Interactive Month navigation (< and >) with elegant calligraphic heading.
/// 3. Strict seven-column calendar grid with Sun-Sat alignment.
/// 4. October 13 birthday highlighting with glowing romantic lipstick kiss 💋 aesthetic & burst.
/// 5. Restrained antique-gold indicator dots for dates with existing memories in StoryConfig.memories.
/// 6. Date-specific memory details card showing actual memory title, caption, location, note & photo viewer.
/// 7. Authentic romantic handwritten typography (Caveat + Great Vibes) with luminous shadows.
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

  // Calendar State
  int _currentYear = 2026;
  int _currentMonth = 10; // October
  int? _selectedDay = 13;

  final List<String> _monthNames = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
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

  /// Parses memory date string (e.g., "08 . 14 . 2022") into a DateTime object
  DateTime? _parseMemoryDate(String dateStr) {
    try {
      final parts = dateStr.replaceAll(' ', '').split(RegExp(r'[./\-]'));
      if (parts.length == 3) {
        final m = int.tryParse(parts[0]);
        final d = int.tryParse(parts[1]);
        final y = int.tryParse(parts[2]);
        if (m != null && d != null && y != null) {
          return DateTime(y, m, d);
        }
      }
    } catch (_) {}
    return null;
  }

  /// Finds memories for a specific date
  List<Memory> _getMemoriesForDate(int year, int month, int day) {
    final List<Memory> matches = [];
    for (final memory in StoryConfig.memories) {
      final parsed = _parseMemoryDate(memory.date);
      if (parsed != null &&
          parsed.year == year &&
          parsed.month == month &&
          parsed.day == day) {
        matches.add(memory);
      }
    }
    return matches;
  }

  /// Checks if a date has any recorded memory
  bool _dateHasMemory(int year, int month, int day) {
    return _getMemoriesForDate(year, month, day).isNotEmpty;
  }

  void _previousMonth() {
    setState(() {
      if (_currentMonth == 1) {
        _currentMonth = 12;
        _currentYear--;
      } else {
        _currentMonth--;
      }
      _selectedDay = null; // Reset selected day upon month switch
    });
  }

  void _nextMonth() {
    setState(() {
      if (_currentMonth == 12) {
        _currentMonth = 1;
        _currentYear++;
      } else {
        _currentMonth++;
      }
      _selectedDay = null; // Reset selected day upon month switch
    });
  }

  void _jumpToBirthday() {
    setState(() {
      _currentYear = 2026;
      _currentMonth = 10;
      _selectedDay = 13;
    });
    _triggerKissBurst();
  }

  void _triggerKissBurst() {
    setState(() {
      for (int i = 0; i < 8; i++) {
        _floatingKisses.add(_FloatingKiss(
          x: 120 + _rnd.nextDouble() * 160,
          y: 280 + _rnd.nextDouble() * 100,
          vx: (_rnd.nextDouble() - 0.5) * 4.0,
          vy: -3.0 - _rnd.nextDouble() * 3.5,
          emoji: i % 2 == 0 ? "💋" : "💖",
          size: 18 + _rnd.nextDouble() * 12,
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
    final isBirthdayMonth = (_currentYear == 2026 && _currentMonth == 10);

    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: isMobile ? 380 : 490,
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
              color: const Color(0xFF722F37).withValues(alpha: 0.18),
              blurRadius: 32,
              offset: const Offset(0, 14),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.14),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: Stack(
            children: [
              // 1. Photo Background — Crystal Clear & Translucent Veil
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

              // 2. Delicate ambient lighting gradient so photo colors stay vivid
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.10),
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.28),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),

              // 3. Top Controls: Photo Switcher Pill
              Positioned(
                top: 14,
                right: 14,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPhotoIndex =
                          (_selectedPhotoIndex + 1) % _photos.length;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF9F1).withValues(alpha: 0.90),
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
                            size: 11, color: Color(0xFF722F37)),
                        const SizedBox(width: 4),
                        Text(
                          _selectedPhotoIndex == 0
                              ? "Gym 💪"
                              : _selectedPhotoIndex == 1
                                  ? "Couple ♡"
                                  : "Beach 🌊",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 9.5,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF722F37),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 4. Luminous Frosted Glassmorphic Calendar Card
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 46, 14, 18),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 18,
                    vertical: isMobile ? 14 : 18,
                  ),
                  decoration: BoxDecoration(
                    // Translucent glass so the photo shines through softly
                    color: const Color(0xFFFFFDF9).withValues(alpha: 0.58),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.85),
                      width: 1.5,
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
                      // Badge
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFFB69A68).withValues(alpha: 0.7),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            "SINCE 2022 · OUR RELATIONSHIP CALENDAR",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: isMobile ? 10.5 : 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 2.0,
                              color: const Color(0xFF722F37),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Month Navigation Row with Antique Rose-Gold Gem Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Previous Month Gem Button
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withValues(alpha: 0.7),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF722F37).withValues(alpha: 0.10),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: _previousMonth,
                              icon: const Icon(Icons.chevron_left_rounded, size: 22),
                              color: const Color(0xFF722F37),
                              tooltip: "Previous Month",
                            ),
                          ),

                          // Month & Year Heading in Calligraphic Cursive
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "~ ${_monthNames[_currentMonth - 1]} ~",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.greatVibes(
                                    fontSize: isMobile ? 38 : 46,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF380811),
                                    shadows: [
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.95),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "$_currentYear",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: isMobile ? 16 : 19,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 2.2,
                                    color: const Color(0xFF722F37),
                                    shadows: [
                                      Shadow(
                                        color: Colors.white.withValues(alpha: 0.90),
                                        blurRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Next Month Gem Button
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.85),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFD4AF37).withValues(alpha: 0.7),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF722F37).withValues(alpha: 0.10),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: _nextMonth,
                              icon: const Icon(Icons.chevron_right_rounded, size: 22),
                              color: const Color(0xFF722F37),
                              tooltip: "Next Month",
                            ),
                          ),
                        ],
                      ),

                      // Shortcut pill to jump back to Oct 2026 birthday if navigating away
                      if (!isBirthdayMonth)
                        Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: GestureDetector(
                            onTap: _jumpToBirthday,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF4EE).withValues(alpha: 0.92),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFD7A6A1), width: 0.9),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("🎂", style: TextStyle(fontSize: 11)),
                                  const SizedBox(width: 4),
                                  Text(
                                    "Jump to Oct 13 Birthday",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF722F37),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      const SizedBox(height: 6),

                      // 7-Column Calendar Grid
                      _buildSevenColumnGrid(isMobile),

                      const SizedBox(height: 12),

                      // Date-Specific Memory Details Card or Birthday Banner
                      _buildDateDetailsCard(isMobile),
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

  /// Clean, 7-Column Calendar Grid with accurate weekday calculation
  Widget _buildSevenColumnGrid(bool isMobile) {
    const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final firstDayWeekday = DateTime(_currentYear, _currentMonth, 1).weekday;
    final firstDayOffset = firstDayWeekday % 7; // Sunday = 0
    final totalDays = DateTime(_currentYear, _currentMonth + 1, 0).day;

    // Romantic handwritten numerals (Caveat) with luminous white shadow
    final cellTextStyle = GoogleFonts.caveat(
      fontSize: isMobile ? 22 : 26,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF1E1014),
      shadows: [
        Shadow(
          color: Colors.white.withValues(alpha: 0.95),
          blurRadius: 4,
        ),
      ],
    );

    final headerStyle = GoogleFonts.plusJakartaSans(
      fontSize: isMobile ? 10.5 : 12,
      fontWeight: FontWeight.w800,
      color: const Color(0xFF722F37),
      shadows: [
        Shadow(
          color: Colors.white.withValues(alpha: 0.95),
          blurRadius: 4,
        ),
      ],
    );

    // Calculate total rows needed (4 to 6 rows)
    final totalCells = ((firstDayOffset + totalDays + 6) ~/ 7) * 7;

    return Column(
      children: [
        // Days of week header row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: daysOfWeek.map((day) {
              return Expanded(
                child: Center(
                  child: Text(day, style: headerStyle),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 5),
        Divider(
          color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
          height: 1,
          thickness: 0.8,
        ),
        const SizedBox(height: 6),

        // Grid of dates
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: totalCells,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 5,
            crossAxisSpacing: 4,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final dayNumber = index - firstDayOffset + 1;

            if (dayNumber < 1 || dayNumber > totalDays) {
              return const SizedBox.shrink();
            }

            final isOct13 = (_currentYear == 2026 && _currentMonth == 10 && dayNumber == widget.highlightDay);
            final isSelected = (_selectedDay == dayNumber);
            final hasMemory = _dateHasMemory(_currentYear, _currentMonth, dayNumber);

            return InkWell(
              onTap: () {
                setState(() {
                  _selectedDay = dayNumber;
                });
                if (isOct13) {
                  _triggerKissBurst();
                }
              },
              borderRadius: BorderRadius.circular(20),
              child: Center(
                child: isOct13
                    ? _buildBirthdayCell(dayNumber, isMobile)
                    : _buildStandardCell(
                        dayNumber: dayNumber,
                        isSelected: isSelected,
                        hasMemory: hasMemory,
                        cellTextStyle: cellTextStyle,
                        isMobile: isMobile,
                      ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// Special Oct 13 Birthday Cell with glowing romantic lipstick kiss 💋
  Widget _buildBirthdayCell(int dayNumber, bool isMobile) {
    return AnimatedBuilder(
      animation: _kissPulseController,
      builder: (context, child) {
        final scale = 0.95 + (_kissPulseController.value * 0.08);

        return Transform.scale(
          scale: scale,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Romantic Rose Lipstick Glow Halo
              Container(
                width: isMobile ? 36 : 40,
                height: isMobile ? 36 : 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0E6).withValues(alpha: 0.92),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFFFF2D55),
                    width: 1.8,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF2D55).withValues(alpha: 0.45),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '$dayNumber',
                    style: GoogleFonts.caveat(
                      color: const Color(0xFFC2185B),
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 24 : 29,
                    ),
                  ),
                ),
              ),

              // Iconic Romantic Kiss Stamp 💋
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
    );
  }

  /// Standard Date Cell with memory dot indicator and selected state
  Widget _buildStandardCell({
    required int dayNumber,
    required bool isSelected,
    required bool hasMemory,
    required TextStyle cellTextStyle,
    required bool isMobile,
  }) {
    return Container(
      width: isMobile ? 33 : 37,
      height: isMobile ? 33 : 37,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF722F37).withValues(alpha: 0.90) // Muted Burgundy when selected
            : hasMemory
                ? const Color(0xFFFFF0F3).withValues(alpha: 0.75) // Soft warm rose tint for memories
                : Colors.transparent,
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(color: const Color(0xFFE2C89A), width: 1.5)
            : hasMemory
                ? Border.all(color: const Color(0xFFD7A6A1), width: 1.0)
                : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Day number text in handwritten Caveat script
          Text(
            '$dayNumber',
            style: cellTextStyle.copyWith(
              color: isSelected ? Colors.white : const Color(0xFF1E1014),
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
            ),
          ),

          // Delicate Antique Gold memory indicator dot below numeral
          if (hasMemory && !isSelected)
            Positioned(
              bottom: 2.5,
              child: Container(
                width: 4.5,
                height: 4.5,
                decoration: const BoxDecoration(
                  color: Color(0xFFB69A68), // Antique Gold
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Date-Specific Memory Details Panel or Birthday Banner
  Widget _buildDateDetailsCard(bool isMobile) {
    if (_selectedDay == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE4C3AB), width: 0.8),
        ),
        child: Text(
          "Tap any date to view memories or celebrate moments ♡",
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: isMobile ? 10 : 11,
            color: const Color(0xFF80604B),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final day = _selectedDay!;
    final isOct13 = (_currentYear == 2026 && _currentMonth == 10 && day == widget.highlightDay);
    final memories = _getMemoriesForDate(_currentYear, _currentMonth, day);

    // Case 1: Birthday Date (Oct 13) - Default & Highlight
    if (isOct13) {
      return GestureDetector(
        onTap: _triggerKissBurst,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0F3).withValues(alpha: 0.92),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFFF2D55), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF2D55).withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("💋", style: TextStyle(fontSize: 14)),
                    const SizedBox(width: 6),
                    Text(
                      "OCTOBER 13 · SELVAKUMAR'S 24TH BIRTHDAY",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: isMobile ? 10 : 11.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: const Color(0xFF722F37),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text("🎂", style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Celebrating 24 years of the sweetest soul! Tap for birthday kisses 💋",
                textAlign: TextAlign.center,
                style: GoogleFonts.cormorantGaramond(
                  fontSize: isMobile ? 14 : 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF282522),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Case 2: Actual Recorded Memory Exists for this Date
    if (memories.isNotEmpty) {
      final memory = memories.first;
      final memoryIndex = StoryConfig.memories.indexOf(memory);

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF9F1).withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFB69A68), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF722F37).withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Memory Title & Category
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_rounded, size: 13, color: Color(0xFFB69A68)),
                  const SizedBox(width: 6),
                  Text(
                    memory.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 11 : 12,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF722F37),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF4EE),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFD7A6A1), width: 0.8),
                    ),
                    child: Text(
                      memory.category.toUpperCase(),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 8.5,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF80604B),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),

            // Date & Location
            Text(
              "${memory.date} · 📍 ${memory.location}",
              style: GoogleFonts.plusJakartaSans(
                fontSize: isMobile ? 9.5 : 10,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF80604B),
              ),
            ),
            const SizedBox(height: 4),

            // Caption
            Text(
              "“${memory.caption}”",
              textAlign: TextAlign.center,
              style: GoogleFonts.cormorantGaramond(
                fontSize: isMobile ? 13.5 : 15,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF282522),
              ),
            ),

            if (memory.handwrittenNote != null) ...[
              const SizedBox(height: 3),
              Text(
                "~ ${memory.handwrittenNote} ~",
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                  fontSize: isMobile ? 15 : 17,
                  color: const Color(0xFFC2185B),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],

            const SizedBox(height: 6),

            // View Photo Action Button
            InkWell(
              onTap: () {
                if (memoryIndex >= 0) {
                  PhotoViewerDialog.show(context, StoryConfig.memories, memoryIndex);
                }
              },
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF722F37),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.photo_library_outlined, size: 11, color: Colors.white),
                    const SizedBox(width: 5),
                    Text(
                      "VIEW PHOTO IN ARCHIVE",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Case 3: Date has no recorded memory (Delicate romantic whisper)
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE4C3AB).withValues(alpha: 0.6), width: 0.8),
      ),
      child: Text(
        "${_monthNames[_currentMonth - 1]} $day · A quiet day of loving you forever ♡",
        textAlign: TextAlign.center,
        style: GoogleFonts.caveat(
          fontSize: isMobile ? 14 : 16,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF722F37),
        ),
      ),
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

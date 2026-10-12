import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class FightAndLovePledgeSection extends StatefulWidget {
  const FightAndLovePledgeSection({super.key});

  @override
  State<FightAndLovePledgeSection> createState() => _FightAndLovePledgeSectionState();
}

class _FightAndLovePledgeSectionState extends State<FightAndLovePledgeSection>
    with SingleTickerProviderStateMixin {
  int _fightClickCount = 0;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  final List<String> _fightScenarios = [
    "😤 'Why did you reply after 3 minutes?!' → FAKE BREAKUP #482 💔",
    "🍫 'You ate the last bite of my favorite food!' → FAKE BREAKUP #631 💔",
    "😴 'You fell asleep while talking!' → FAKE BREAKUP #850 💔",
    "🧐 'Who were you texting?' → FAKE BREAKUP #999 💔",
    "🥹 5 Minutes Later: 'Hey babe, did you eat? I miss you...' 🫂❤️",
    "💖 FINAL VERDICT: 10,000+ Fights & 1,000+ Breakups... STILL I CHOOSE YOU! ♾️",
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.96, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onFightSimulate() {
    setState(() {
      _fightClickCount = (_fightClickCount + 1) % _fightScenarios.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 90,
        horizontal: isMobile ? 16 : 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF3B070C), // Deep Crimson Wine
                  Color(0xFF1F0306), // Midnight Mahogany
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFFFD700).withValues(alpha: 0.8),
                width: 2.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6B0F1A).withValues(alpha: 0.5),
                  blurRadius: 30,
                  spreadRadius: 2,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 32 : 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Pill Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFFFFD700), width: 1.2),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text("🥊", style: TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Text(
                            "OUR FIGHT & LOVE CONTRACT",
                            style: GoogleFonts.montserrat(
                              fontSize: isMobile ? 11 : 13,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                              color: const Color(0xFFFFD700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Main Big Title
                  Text(
                    "10,000+ FIGHTS.\nENDLESS BREAKUPS.\nSTILL I CHOOSE YOU.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cinzel(
                      fontSize: isMobile ? 26 : 38,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Handwritten Subtitle
                  Text(
                    "“I want to daily fight with u, for the rest of my life!” ❤️",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.caveat(
                      fontSize: isMobile ? 24 : 32,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFF8A80),
                    ),
                  ),
                  const SizedBox(height: 36),

                  // 4 Stat Box Cards Grid
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.count(
                        crossAxisCount: isMobile ? 2 : 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: isMobile ? 0.88 : 1.05,
                        children: [
                          _buildStatCard("10,000+", "Fights Fought", "🥊", "and still counting!"),
                          _buildStatCard("1,000+", "Fake Breakups", "💔", "lasted 5 mins max"),
                          _buildStatCard("1 Everlasting", "Choice Made", "❤️", "STILL I CHOOSE YOU"),
                          _buildStatCard("Forever", "Daily Fight Partner", "🤼", "I want to fight with u!"),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 36),

                  // Interactive Simulator Card
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(isMobile ? 18 : 24),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.35),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                          width: 1.2,
                        ),
                      ),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.flash_on, color: Color(0xFFFFD700), size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  "DAILY FIGHT SIMULATOR",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              _fightScenarios[_fightClickCount],
                              key: ValueKey(_fightClickCount),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cormorantGaramond(
                                fontSize: isMobile ? 18 : 23,
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: const Color(0xFFFFD700),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton(
                            onPressed: _onFightSimulate,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFC62828),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 16 : 36,
                                vertical: isMobile ? 12 : 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(color: Color(0xFFFFD700), width: 1.2),
                              ),
                              elevation: 8,
                            ),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("🥊 ", style: TextStyle(fontSize: 18)),
                                  Text(
                                    isMobile ? "Daily Fight & Hug Simulator ♡" : "Trigger Daily Fight & Reconciliation",
                                    style: GoogleFonts.montserrat(
                                      fontSize: isMobile ? 12.5 : 15,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Golden Quote Promise
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B0F1A).withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: const Border(
                        left: BorderSide(color: Color(0xFFFFD700), width: 4),
                      ),
                    ),
                    child: Text(
                      "“No matter how many times we fight or threateningly declare breakups... my heart belongs only to you. I will choose you in every argument, after every fight, today, tomorrow, and forever.”",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.warmPaper,
                        height: 1.5,
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

  Widget _buildStatCard(String value, String label, String emoji, String note) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFFD700).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(emoji, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 6),
              Text(
                value,
                style: GoogleFonts.cinzel(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFFFFD700),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                note,
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                  fontSize: 13,
                  color: const Color(0xFFFF8A80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

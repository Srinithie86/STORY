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
  int? _expandedReasonIndex;
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

  final List<Map<String, String>> _fightMoments = [
    {
      "moment": "MOMENT 01",
      "tag": "The 3-Minute Crisis",
      "icon": "⏳",
      "quote": "“Why did you reply after 3 minutes?!”",
      "subtext": "Official reason for fake breakup #482. Resolved in 4 minutes with forehead kisses.",
    },
    {
      "moment": "MOMENT 02",
      "tag": "The Last Bite Tragedy",
      "icon": "🍫",
      "quote": "“You ate the last bite of my favorite food!”",
      "subtext": "Heartbreak #631. A culinary betrayal forgiven only after you offered an entire dessert.",
    },
    {
      "moment": "MOMENT 03",
      "tag": "Sleepy Midnight Call",
      "icon": "🌙",
      "quote": "“You fell asleep while we were talking!”",
      "subtext": "Accusation #850. Only to wake up the next morning missing your sleepy voice immediately.",
    },
    {
      "moment": "MOMENT 04",
      "tag": "The Suspicious Glance",
      "icon": "👀",
      "quote": "“Who were you texting with that smile?”",
      "subtext": "Case #999. The dramatic interrogation that always ends with both of us laughing.",
    },
    {
      "moment": "MOMENT 05",
      "tag": "The 5-Minute Surrender",
      "icon": "🕊️",
      "quote": "“Hey babe... did you eat? I miss you.”",
      "subtext": "Every fake breakup expires precisely 5 minutes later because we can't stay mad.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.98, end: 1.02).animate(
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

  void _toggleReason(int index) {
    setState(() {
      if (_expandedReasonIndex == index) {
        _expandedReasonIndex = null;
      } else {
        _expandedReasonIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 80,
        horizontal: isMobile ? 14 : 28,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: Column(
            children: [
              // ==========================================
              // SECTION 1: OUR FIGHTS — SOFT & REALISTIC
              // ==========================================
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.softCream, // Warm soft cream
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: AppTheme.dustyRose.withValues(alpha: 0.55),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.mutedBurgundy.withValues(alpha: 0.08),
                      blurRadius: 32,
                      spreadRadius: 2,
                      offset: const Offset(0, 14),
                    ),
                    BoxShadow(
                      color: AppTheme.antiqueGold.withValues(alpha: 0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 18 : 36,
                    vertical: isMobile ? 28 : 42,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Editorial Tag Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6.5),
                        decoration: BoxDecoration(
                          color: AppTheme.softBlush,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: AppTheme.dustyRose.withValues(alpha: 0.8),
                            width: 1.0,
                          ),
                        ),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("🕊️", style: TextStyle(fontSize: 14)),
                              const SizedBox(width: 8),
                              Text(
                                "LITTLE MOMENTS · OUR SILLY FIGHTS",
                                style: GoogleFonts.montserrat(
                                  fontSize: isMobile ? 10.5 : 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2.0,
                                  color: AppTheme.mutedBurgundy,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Main Heading
                      Text(
                        "10,000+ SILLY FIGHTS.\nENDLESS FAKE BREAKUPS.\nSTILL, I CHOOSE YOU.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: isMobile ? 26 : 38,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          color: AppTheme.charcoalText,
                          height: 1.22,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Gentle Subtitle
                      Text(
                        "“I want to daily fight with you, for the rest of my life!” ♡",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.caveat(
                          fontSize: isMobile ? 22 : 28,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.mutedBurgundy,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 4 Stat Box Cards
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.count(
                            crossAxisCount: isMobile ? 2 : 4,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: isMobile ? 0.95 : 1.08,
                            children: [
                              _buildStatCard("10,000+", "Fights Fought", "🕊️", "and still counting!"),
                              _buildStatCard("1,000+", "Fake Breakups", "⏳", "lasted 5 mins max"),
                              _buildStatCard("1 Everlasting", "Choice Made", "🤍", "STILL I CHOOSE YOU"),
                              _buildStatCard("Forever", "Daily Partner", "✨", "I want to fight with u!"),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 32),

                      // Realistic Fight Reasons Accordion List
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            "THE CHRONICLES OF OUR DRAMA",
                            style: GoogleFonts.montserrat(
                              fontSize: isMobile ? 10 : 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.2,
                              color: AppTheme.mutedBurgundy.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _fightMoments.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = _fightMoments[index];
                          final isExpanded = _expandedReasonIndex == index;
                          return _buildReasonCard(item, index, isExpanded, isMobile);
                        },
                      ),
                      const SizedBox(height: 28),

                      // Interactive Daily Fight Simulator Card
                      ScaleTransition(
                        scale: _pulseAnimation,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isMobile ? 18 : 24),
                          decoration: BoxDecoration(
                            color: AppTheme.warmIvory,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppTheme.antiqueGold.withValues(alpha: 0.6),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.favorite_outline, color: AppTheme.mutedBurgundy, size: 18),
                                    const SizedBox(width: 8),
                                    Text(
                                      "INTERACTIVE FIGHT & RECONCILIATION SIMULATOR",
                                      style: GoogleFonts.montserrat(
                                        fontSize: isMobile ? 10.5 : 12,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.8,
                                        color: AppTheme.mutedBurgundy,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 14),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 350),
                                transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: child),
                                child: Text(
                                  _fightScenarios[_fightClickCount],
                                  key: ValueKey(_fightClickCount),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cormorantGaramond(
                                    fontSize: isMobile ? 19 : 23,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    color: AppTheme.charcoalText,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 18),
                              ElevatedButton(
                                onPressed: _onFightSimulate,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.mutedBurgundy,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 20 : 36,
                                    vertical: isMobile ? 13 : 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(
                                      color: AppTheme.antiqueGold.withValues(alpha: 0.8),
                                      width: 1.2,
                                    ),
                                  ),
                                  elevation: 4,
                                ),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text("🕊️ ", style: TextStyle(fontSize: 16)),
                                      Text(
                                        isMobile
                                            ? "Daily Fight & Hug Simulator ♡"
                                            : "Trigger Daily Fight & Reconciliation",
                                        style: GoogleFonts.montserrat(
                                          fontSize: isMobile ? 12.5 : 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
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
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // ==========================================
              // SECTION 2: LIFE CONTRACT — ELEGANT RELATIONSHIP AGREEMENT
              // ==========================================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFCF9F2), // Warm natural parchment paper
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppTheme.antiqueGold.withValues(alpha: 0.65),
                    width: 1.6,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 36,
                      offset: const Offset(0, 16),
                    ),
                    BoxShadow(
                      color: AppTheme.antiqueGold.withValues(alpha: 0.12),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 48,
                    vertical: isMobile ? 32 : 48,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Ornate Vintage Header Ornament
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: isMobile ? 30 : 60,
                              height: 1,
                              color: AppTheme.antiqueGold.withValues(alpha: 0.5),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                "✦  L I F E   C O N T R A C T  ✦",
                                style: GoogleFonts.cormorantGaramond(
                                  fontSize: isMobile ? 12 : 14,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 3.5,
                                  color: AppTheme.mutedBurgundy,
                                ),
                              ),
                            ),
                            Container(
                              width: isMobile ? 30 : 60,
                              height: 1,
                              color: AppTheme.antiqueGold.withValues(alpha: 0.5),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        "The Forever Relationship Agreement",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: isMobile ? 26 : 34,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: AppTheme.charcoalText,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        "A covenant written with genuine affection, mutual patience, and infinite love.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: isMobile ? 12 : 13.5,
                          color: AppTheme.warmBrown,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Numbered Clauses
                      _buildContractClause(
                        clauseNumber: "CLAUSE 01",
                        title: "The Unconditional Choice",
                        promise:
                            "In every argument, heated silence, or silly dispute — I choose you. After every storm, my heart will always return safely home to you.",
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 14),

                      _buildContractClause(
                        clauseNumber: "CLAUSE 02",
                        title: "The Daily Fight Partner",
                        promise:
                            "I promise to be your dedicated daily fight partner for the rest of my life — teasing you, laughing with you, and never staying mad past bedtime.",
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 14),

                      _buildContractClause(
                        clauseNumber: "CLAUSE 03",
                        title: "The 5-Minute Reconciliation Rule",
                        promise:
                            "No matter how dramatically we declare a fake breakup, it will automatically expire in exactly five minutes with: “Hey babe, did you eat? I miss you...”",
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 14),

                      _buildContractClause(
                        clauseNumber: "CLAUSE 04",
                        title: "The Everlasting Choice",
                        promise:
                            "10,000+ fights, endless fake breakups, but one unchanging truth: My heart belongs only to you, today, tomorrow, and across a hundred lifetimes.",
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 28),

                      // Golden Quote Promise Highlight
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
                        decoration: BoxDecoration(
                          color: AppTheme.softBlush,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppTheme.antiqueGold.withValues(alpha: 0.6),
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          "“No matter how many times we fight or threateningly declare breakups... my heart belongs only to you. I will choose you in every argument, after every fight, today, tomorrow, and forever.”",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cormorantGaramond(
                            fontSize: isMobile ? 18 : 21,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic,
                            color: AppTheme.charcoalText,
                            height: 1.55,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Signatures & Official Seal
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 480) {
                            return Column(
                              children: [
                                _buildSignatureBlock("Srinithi", "Party of the First Part ♡"),
                                const SizedBox(height: 20),
                                _buildSignatureBlock("Selvakumar", "Party of the Second Part ♡"),
                                const SizedBox(height: 20),
                                _buildSealBadge(),
                              ],
                            );
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildSignatureBlock("Srinithi", "Party of the First Part ♡"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: _buildSealBadge(),
                              ),
                              Expanded(
                                child: _buildSignatureBlock("Selvakumar", "Party of the Second Part ♡"),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, String icon, String note) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.warmIvory,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.dustyRose.withValues(alpha: 0.45),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(icon, style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 6),
              Text(
                value,
                style: GoogleFonts.cinzel(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.mutedBurgundy,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.charcoalText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                note,
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                  fontSize: 12.5,
                  color: AppTheme.warmBrown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReasonCard(
    Map<String, String> item,
    int index,
    bool isExpanded,
    bool isMobile,
  ) {
    return InkWell(
      onTap: () => _toggleReason(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isExpanded ? AppTheme.softBlush : AppTheme.warmIvory,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded ? AppTheme.dustyRose : AppTheme.dustyRose.withValues(alpha: 0.35),
            width: isExpanded ? 1.4 : 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(item["icon"]!, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${item["moment"]!} · ${item["tag"]!}",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: isMobile ? 12 : 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.charcoalText,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: AppTheme.mutedBurgundy,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              item["quote"]!,
              style: GoogleFonts.cormorantGaramond(
                fontSize: isMobile ? 15.5 : 17,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                color: AppTheme.mutedBurgundy,
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  item["subtext"]!,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 11.5 : 13,
                    color: AppTheme.warmBrown,
                    height: 1.45,
                  ),
                ),
              ),
              crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 250),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractClause({
    required String clauseNumber,
    required String title,
    required String promise,
    required bool isMobile,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.warmIvory,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.antiqueGold.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                clauseNumber,
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.8,
                  color: AppTheme.antiqueGold,
                ),
              ),
              const SizedBox(width: 8),
              Text("·", style: TextStyle(color: AppTheme.antiqueGold, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.charcoalText,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            promise,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 12 : 13.5,
              color: AppTheme.warmBrown,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureBlock(String name, String role) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          name,
          style: GoogleFonts.greatVibes(
            fontSize: 34,
            color: AppTheme.mutedBurgundy,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          width: 130,
          height: 1,
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: AppTheme.antiqueGold.withValues(alpha: 0.5),
        ),
        Text(
          role,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: AppTheme.warmBrown,
          ),
        ),
      ],
    );
  }

  Widget _buildSealBadge() {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.softBlush,
        border: Border.all(
          color: AppTheme.antiqueGold,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.antiqueGold.withValues(alpha: 0.15),
            blurRadius: 10,
          ),
        ],
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("♾️", style: TextStyle(fontSize: 18)),
            Text(
              "FOREVER",
              style: GoogleFonts.montserrat(
                fontSize: 8,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: AppTheme.mutedBurgundy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

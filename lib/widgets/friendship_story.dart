import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class FriendshipStory extends StatelessWidget {
  const FriendshipStory({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final stages = [
      {
        "badge": "SINCE 2022",
        "stage": "FRIENDS",
        "note": "two paths cross quietly",
        "detail": "Sharing notes, quiet lunches & effortless conversations."
      },
      {
        "badge": "EARLY DAYS",
        "stage": "CONVERSATIONS",
        "note": "talking for hours",
        "detail": "Late night messages that made every evening brighter."
      },
      {
        "badge": "BONDING",
        "stage": "LAUGHTER",
        "note": "inside jokes",
        "detail": "Knowing every mood before a single word was spoken."
      },
      {
        "badge": "JOURNEY",
        "stage": "MEMORIES",
        "note": "collecting moments",
        "detail": "Every photo, coffee cup, and walk saved like a treasure."
      },
      {
        "badge": "REALIZATION",
        "stage": "FEELINGS",
        "note": "something changed",
        "detail": "Realizing that friendship had quietly grown into love."
      },
      {
        "badge": "FOREVER",
        "stage": "LOVE",
        "note": "forever begins",
        "detail": "Choosing each other yesterday, today, and for all tomorrows."
      },
    ];

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.contentWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                "THE EVOLUTION  ·  SINCE 2022",
                style: AppTheme.monoStyle(
                  fontSize: 11,
                  letterSpacing: 2.5,
                  color: AppTheme.deepBurgundy,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "From quiet friendship to forever.",
                style: AppTheme.serifStyle(
                  fontSize: isMobile ? 30 : 42,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.darkCharcoal,
                ),
              ),
              const SizedBox(height: 48),

              // Stages Layout
              isMobile
                  ? Column(
                      children: List.generate(stages.length, (index) {
                        return _buildStageCard(stages[index], index, isMobile);
                      }),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.15,
                        crossAxisSpacing: 24,
                        mainAxisSpacing: 24,
                      ),
                      itemCount: stages.length,
                      itemBuilder: (context, index) {
                        return _buildStageCard(stages[index], index, isMobile);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageCard(Map<String, String> item, int index, bool isMobile) {
    final isLast = index == 5;

    return Container(
      margin: isMobile ? const EdgeInsets.only(bottom: 24) : EdgeInsets.zero,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: isLast ? const Color(0xFF6B0F1A) : AppTheme.warmPaper,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isLast ? const Color(0xFFD4AF37) : AppTheme.warmTaupe,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:  0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item["badge"]!,
                style: AppTheme.monoStyle(
                  fontSize: 10.5,
                  letterSpacing: 1.5,
                  color: isLast ? const Color(0xFFFFD54F) : AppTheme.deepBurgundy,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "✦",
                style: TextStyle(
                  fontSize: 12,
                  color: isLast ? const Color(0xFFFFD54F) : AppTheme.deepBurgundy.withValues(alpha:  0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            item["stage"]!,
            style: AppTheme.serifStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: isLast ? AppTheme.warmPaper : AppTheme.darkCharcoal,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "“${item['note']}”",
            style: AppTheme.handwrittenStyle(
              fontSize: 20,
              color: isLast ? const Color(0xFFFFD54F) : AppTheme.deepBurgundy,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            item["detail"]!,
            style: AppTheme.serifStyle(
              fontSize: 15,
              color: isLast ? AppTheme.warmTaupe : AppTheme.darkCharcoal.withValues(alpha:  0.8),
            ),
          ),
        ],
      ),
    );
  }
}

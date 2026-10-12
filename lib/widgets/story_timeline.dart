import 'package:flutter/material.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class StoryTimeline extends StatelessWidget {
  const StoryTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final chapters = StoryConfig.timelineChapters;

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
              // Section Title
              Text(
                "OUR TIMELINE",
                style: AppTheme.monoStyle(
                  fontSize: 11,
                  letterSpacing: 2.5,
                  color: const Color(0xFFFFD54F),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Milestones along our shared path.",
                style: AppTheme.serifStyle(
                  fontSize: isMobile ? 28 : 40,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFFFDFBF7),
                ),
              ),
              const SizedBox(height: 48),

              // Timeline List with connecting lines
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  final chapter = chapters[index];
                  final isLast = index == chapters.length - 1;

                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Timeline Node & Line
                        SizedBox(
                          width: 48,
                          child: Column(
                            children: [
                              Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFFFD54F),
                                  border: Border.all(
                                    color: AppTheme.primaryBackground,
                                    width: 2,
                                  ),
                                ),
                              ),
                              if (!isLast)
                                Expanded(
                                  child: Container(
                                    width: 1,
                                    color: AppTheme.warmTaupe.withValues(alpha:  0.5),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        // Timeline Content Card
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 36),
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppTheme.warmPaper,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: AppTheme.warmTaupe,
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
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        chapter.stage,
                                        style: AppTheme.monoStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.deepBurgundy,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Text(
                                        chapter.date,
                                        style: AppTheme.monoStyle(
                                          fontSize: 11,
                                          color: AppTheme.mutedGray,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  chapter.title,
                                  style: AppTheme.serifStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme.darkCharcoal,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  chapter.description,
                                  style: AppTheme.serifStyle(
                                    fontSize: 16,
                                    color: AppTheme.darkCharcoal
                                        .withValues(alpha:  0.8),
                                  ),
                                ),
                                if (chapter.note != null) ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    "“${chapter.note}”",
                                    style: AppTheme.handwrittenStyle(
                                      fontSize: 18,
                                      color: AppTheme.deepBurgundy,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

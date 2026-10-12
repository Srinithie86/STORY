import 'package:flutter/material.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'memory_card.dart';
import 'photo_viewer.dart';

class MemoryArchive extends StatelessWidget {
  const MemoryArchive({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final memories = StoryConfig.memories;

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
              // Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "THE ARCHIVE",
                          style: AppTheme.monoStyle(
                            fontSize: 11,
                            letterSpacing: 2.5,
                            color: AppTheme.deepBurgundy,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Moments I want to remember forever.",
                          style: AppTheme.serifStyle(
                            fontSize: isMobile ? 24 : 40,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isMobile)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "SINCE 2022  ·  ${memories.length} MOMENTS",
                        style: AppTheme.monoStyle(
                          fontSize: 11,
                          letterSpacing: 1.5,
                          color: AppTheme.mutedGray,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 48),

              // Grid Layout
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                  crossAxisSpacing: 28,
                  mainAxisSpacing: 32,
                  childAspectRatio: isMobile ? 0.82 : (isTablet ? 0.85 : 0.84),
                ),
                itemCount: memories.length,
                itemBuilder: (context, index) {
                  return MemoryCard(
                    memory: memories[index],
                    onTap: () {
                      PhotoViewerDialog.show(context, memories, index);
                    },
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

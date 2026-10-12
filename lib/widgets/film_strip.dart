import 'package:flutter/material.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'photo_viewer.dart';

class FilmStrip extends StatelessWidget {
  const FilmStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final memories = StoryConfig.memories;

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 90,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "THE FILM",
                  style: AppTheme.monoStyle(
                    fontSize: 11,
                    letterSpacing: 2.5,
                    color: AppTheme.deepBurgundy,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Some moments need no caption.",
                  style: AppTheme.serifStyle(
                    fontSize: isMobile ? 28 : 40,
                    color: AppTheme.darkCharcoal,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),

          // Horizontal Film Contact Sheet
          SizedBox(
            height: isMobile ? 320 : 380,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: memories.length,
              itemBuilder: (context, index) {
                final item = memories[index];
                final frameNum = (index + 1).toString().padLeft(3, '0');

                return GestureDetector(
                  onTap: () {
                    PhotoViewerDialog.show(context, memories, index);
                  },
                  child: Container(
                    width: isMobile ? 240 : 300,
                    margin: const EdgeInsets.only(right: 24),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.charcoalLight,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: AppTheme.warmTaupe.withValues(alpha:  0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:  0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Film Sprocket Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                "CINEMATIC MEMORIES",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.monoStyle(
                                  fontSize: 9.5,
                                  letterSpacing: 1.0,
                                  color: const Color(0xFFFFD54F),
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Row(
                              children: List.generate(4, (_) {
                                return Container(
                                  width: 8,
                                  height: 5,
                                  margin: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.darkCharcoal,
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Film Photo Container
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.asset(
                              item.imagePath,
                              fit: BoxFit.cover,
                              cacheWidth: 500,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppTheme.darkCharcoal,
                                  child: Center(
                                    child: Text(
                                      "FRAME $frameNum",
                                      style: AppTheme.monoStyle(
                                        fontSize: 11,
                                        color: AppTheme.warmTaupe,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Film Sprocket Footer
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "FRAME $frameNum",
                              style: AppTheme.monoStyle(
                                fontSize: 10,
                                color: AppTheme.warmTaupe,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                item.date,
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.monoStyle(
                                  fontSize: 10,
                                  color: AppTheme.warmTaupe.withValues(alpha:  0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

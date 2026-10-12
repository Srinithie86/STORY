import 'package:flutter/material.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class SecretMemoryPage extends StatelessWidget {
  const SecretMemoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final notes = StoryConfig.secretNotes;

    return Scaffold(
      backgroundColor: AppTheme.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.warmPaper),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "SECRET ARCHIVE ✦",
          style: AppTheme.monoStyle(
            fontSize: 12,
            letterSpacing: 2.0,
            color: const Color(0xFFFFD54F),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: isMobile ? 40 : 60,
            horizontal: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "THINGS I NEVER TOLD YOU.",
                    style: AppTheme.monoStyle(
                      fontSize: 11,
                      letterSpacing: 2.5,
                      color: AppTheme.warmTaupe.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "The quiet thoughts saved only for you.",
                    style: AppTheme.serifStyle(
                      fontSize: isMobile ? 28 : 38,
                      color: AppTheme.warmPaper,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Secret Notes Cards
                  Column(
                    children: List.generate(notes.length, (index) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          color: AppTheme.warmPaper,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppTheme.warmTaupe,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "SECRET ${(index + 1).toString().padLeft(3, '0')}",
                                  style: AppTheme.monoStyle(
                                    fontSize: 10,
                                    color: AppTheme.deepBurgundy,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const Text("✦",
                                    style: TextStyle(
                                        color: Color(0xFFFFD54F), fontSize: 10)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "“${notes[index]}”",
                              style: AppTheme.serifStyle(
                                fontSize: isMobile ? 18 : 22,
                                color: AppTheme.darkCharcoal,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 32),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        "← RETURN TO OUR STORY",
                        style: AppTheme.monoStyle(
                          fontSize: 11,
                          letterSpacing: 2.0,
                          color: const Color(0xFFFFD54F),
                          fontWeight: FontWeight.w700,
                        ),
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
}

import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class StoryTransition extends StatelessWidget {
  const StoryTransition({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final steps = [
      {"text": "WE WERE FRIENDS.", "isHighlight": false},
      {"text": "↓", "isArrow": true},
      {"text": "WE TALKED.", "isHighlight": false},
      {"text": "↓", "isArrow": true},
      {"text": "WE GOT CLOSER.", "isHighlight": false},
      {"text": "↓", "isArrow": true},
      {"text": "SOMEWHERE IN BETWEEN…", "isHighlight": true},
      {"text": "↓", "isArrow": true},
      {"text": "WE FELL IN LOVE.", "isHighlight": false, "isFinal": true},
    ];

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 80 : 120,
        horizontal: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: steps.map((step) {
          final isArrow = step["isArrow"] == true;
          final isHighlight = step["isHighlight"] == true;
          final isFinal = step["isFinal"] == true;
          final text = step["text"] as String;

          if (isArrow) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 18.0),
              child: Text(
                text,
                style: AppTheme.monoStyle(
                  fontSize: 16,
                  color: AppTheme.warmTaupe.withValues(alpha:  0.4),
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: AppTheme.serifStyle(
                fontSize: isMobile
                    ? (isFinal ? 32 : (isHighlight ? 26 : 22))
                    : (isFinal ? 48 : (isHighlight ? 38 : 30)),
                fontWeight: isFinal
                    ? FontWeight.w600
                    : (isHighlight ? FontWeight.w500 : FontWeight.w400),
                fontStyle: isHighlight ? FontStyle.italic : FontStyle.normal,
                color: isFinal
                    ? AppTheme.warmPaper
                    : (isHighlight ? const Color(0xFFFFD54F) : AppTheme.warmTaupe),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

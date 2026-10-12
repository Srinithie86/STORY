import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class NavBar extends StatelessWidget {
  final Function(String sectionKey) onNavSelected;
  final VoidCallback onOpenSecret;

  const NavBar({
    super.key,
    required this.onNavSelected,
    required this.onOpenSecret,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryBackground.withValues(alpha:  0.95),
        border: const Border(
          bottom: BorderSide(
            color: AppTheme.warmTaupe,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Text(
                    "SELVAKUMAR & SRINITHI",
                    style: AppTheme.monoStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.0,
                      color: AppTheme.darkCharcoal,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "·",
                    style: AppTheme.handwrittenStyle(
                      fontSize: 20,
                      color: AppTheme.deepBurgundy,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "SINCE 2022",
                    style: AppTheme.monoStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppTheme.deepBurgundy,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!isMobile)
            Row(
              children: [
                _navItem("STORY", () => onNavSelected("story")),
                _navItem("ARCHIVE", () => onNavSelected("archive")),
                _navItem("FILM", () => onNavSelected("film")),
                _navItem("LETTER", () => onNavSelected("letter")),
                _navItem("TIMELINE", () => onNavSelected("timeline")),
                _navItem("FOREVER", () => onNavSelected("forever")),
                const SizedBox(width: 16),
                InkWell(
                  onTap: onOpenSecret,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.darkMaroonAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 13,
                          color: Color(0xFFFFD54F),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          "SECRET",
                          style: AppTheme.monoStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else
            PopupMenuButton<String>(
              icon: const Icon(
                Icons.menu,
                color: AppTheme.darkCharcoal,
                size: 22,
              ),
              color: AppTheme.warmPaper,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color: AppTheme.warmTaupe),
              ),
              onSelected: (val) {
                if (val == "secret") {
                  onOpenSecret();
                } else {
                  onNavSelected(val);
                }
              },
              itemBuilder: (context) => [
                _menuItem("story", "OUR STORY"),
                _menuItem("archive", "MEMORY ARCHIVE"),
                _menuItem("film", "THE FILM"),
                _menuItem("letter", "LOVE LETTER"),
                _menuItem("timeline", "TIMELINE"),
                _menuItem("forever", "FOREVER ARCHIVE"),
                _menuItem("secret", "SECRET PAGE ♡"),
              ],
            ),
        ],
      ),
    );
  }

  Widget _navItem(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: InkWell(
        onTap: onTap,
        hoverColor: Colors.transparent,
        child: Text(
          label,
          style: AppTheme.monoStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
            color: AppTheme.darkCharcoal,
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> _menuItem(String value, String title) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        title,
        style: AppTheme.monoStyle(
          fontSize: 12,
          color: value == "secret" ? AppTheme.deepBurgundy : AppTheme.darkCharcoal,
        ),
      ),
    );
  }
}

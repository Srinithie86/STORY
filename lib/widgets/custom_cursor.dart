import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/theme.dart';

class CustomCursorWrapper extends StatefulWidget {
  final Widget child;
  const CustomCursorWrapper({super.key, required this.child});

  @override
  State<CustomCursorWrapper> createState() => _CustomCursorWrapperState();
}

class _CustomCursorWrapperState extends State<CustomCursorWrapper> {
  Offset _pointerPosition = Offset.zero;
  final bool _isHoveringInteractive = false;
  bool _isPointerActive = false;

  @override
  Widget build(BuildContext context) {
    // Only show custom pointer effect on Web/Desktop when pointer is active
    if (kIsWeb == false &&
        (defaultTargetPlatform != TargetPlatform.macOS &&
            defaultTargetPlatform != TargetPlatform.windows &&
            defaultTargetPlatform != TargetPlatform.linux)) {
      return widget.child;
    }

    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onHover: (event) {
        setState(() {
          _pointerPosition = event.position;
          _isPointerActive = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isPointerActive = false;
        });
      },
      child: Stack(
        children: [
          widget.child,
          if (_isPointerActive)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 60),
              curve: Curves.easeOutCubic,
              left: _pointerPosition.dx - (_isHoveringInteractive ? 18 : 8),
              top: _pointerPosition.dy - (_isHoveringInteractive ? 18 : 8),
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isHoveringInteractive ? 36 : 16,
                  height: _isHoveringInteractive ? 36 : 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.deepBurgundy.withValues(alpha: _isHoveringInteractive ? 0.2 : 0.4),
                    border: Border.all(
                      color: AppTheme.deepBurgundy.withValues(alpha: _isHoveringInteractive ? 0.8 : 0.6),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

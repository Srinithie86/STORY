import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/memory.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class PhotoViewerDialog extends StatefulWidget {
  final List<Memory> memories;
  final int initialIndex;

  const PhotoViewerDialog({
    super.key,
    required this.memories,
    required this.initialIndex,
  });

  static void show(BuildContext context, List<Memory> memories, int initialIndex) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (context) => PhotoViewerDialog(
        memories: memories,
        initialIndex: initialIndex,
      ),
    );
  }

  @override
  State<PhotoViewerDialog> createState() => _PhotoViewerDialogState();
}

class _PhotoViewerDialogState extends State<PhotoViewerDialog> {
  late int _currentIndex;
  late PageController _pageController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentIndex < widget.memories.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _prev() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return KeyboardListener(
      focusNode: _focusNode,
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            _next();
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            _prev();
          } else if (event.logicalKey == LogicalKeyboardKey.escape) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              // Page View
              PageView.builder(
                controller: _pageController,
                itemCount: widget.memories.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = widget.memories[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          child: Center(
                            child: Hero(
                              tag: 'memory-photo-${item.id}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.asset(
                                  item.imagePath,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 400,
                                      height: 300,
                                      color: AppTheme.charcoalLight,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.photo_outlined,
                                            size: 48,
                                            color: AppTheme.warmTaupe,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            "PHOTO TO BE ADDED",
                                            style: AppTheme.monoStyle(
                                              fontSize: 12,
                                              color: AppTheme.warmTaupe,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Caption & metadata
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Text(
                              item.title,
                              style: AppTheme.serifStyle(
                                fontSize: isMobile ? 22 : 28,
                                color: AppTheme.warmPaper,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "“${item.caption}”",
                              textAlign: TextAlign.center,
                              style: AppTheme.handwrittenStyle(
                                fontSize: isMobile ? 18 : 22,
                                color: AppTheme.mutedRose,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "${item.date}  ·  ${item.location}",
                              style: AppTheme.monoStyle(
                                fontSize: 11,
                                color: AppTheme.warmTaupe,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),

              // Close button
              Positioned(
                top: 20,
                right: 24,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.warmPaper, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              // Counter label
              Positioned(
                top: 28,
                left: 28,
                child: Text(
                  "${(_currentIndex + 1).toString().padLeft(2, '0')} / ${widget.memories.length.toString().padLeft(2, '0')}",
                  style: AppTheme.monoStyle(
                    fontSize: 13,
                    color: AppTheme.warmPaper,
                    letterSpacing: 2.0,
                  ),
                ),
              ),

              // Navigation arrows
              if (_currentIndex > 0)
                Positioned(
                  left: isMobile ? 10 : 32,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_left,
                        color: AppTheme.warmPaper,
                        size: 40,
                      ),
                      onPressed: _prev,
                    ),
                  ),
                ),

              if (_currentIndex < widget.memories.length - 1)
                Positioned(
                  right: isMobile ? 10 : 32,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.chevron_right,
                        color: AppTheme.warmPaper,
                        size: 40,
                      ),
                      onPressed: _next,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/memory.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

class MemoryCard extends StatefulWidget {
  final Memory memory;
  final VoidCallback onTap;

  const MemoryCard({
    super.key,
    required this.memory,
    required this.onTap,
  });

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
          decoration: BoxDecoration(
            color: AppTheme.warmPaper,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _isHovered ? AppTheme.deepBurgundy : AppTheme.warmTaupe,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.darkCharcoal.withValues(alpha: _isHovered ? 0.08 : 0.03),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Photo Header
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(3)),
                child: AspectRatio(
                  aspectRatio: 16 / 10,
                  child: Hero(
                    tag: 'memory-photo-${widget.memory.id}',
                    child: Image.asset(
                      widget.memory.imagePath,
                      fit: BoxFit.cover,
                      cacheWidth: 600,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppTheme.softBeige,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.image_outlined,
                                color: AppTheme.mutedGray,
                                size: 36,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "PHOTO TO BE ADDED",
                                style: AppTheme.monoStyle(
                                  fontSize: 10,
                                  color: AppTheme.mutedGray,
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

              // Card Content (Flexible & Overflow Safe)
              Expanded(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "${widget.memory.category.toUpperCase()}  ·  ♡",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.monoStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                                color: AppTheme.deepBurgundy,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.memory.date,
                            style: AppTheme.monoStyle(
                              fontSize: 10.5,
                              color: AppTheme.mutedGray,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.memory.title,
                        style: AppTheme.serifStyle(
                          fontSize: isMobile ? 20 : 22,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.darkCharcoal,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "“${widget.memory.caption}”",
                        style: AppTheme.handwrittenStyle(
                          fontSize: 18,
                          color: AppTheme.deepBurgundy,
                        ),
                      ),
                      if (widget.memory.handwrittenNote != null) ...[
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "✍  ",
                              style: TextStyle(fontSize: 12),
                            ),
                            Expanded(
                              child: Text(
                                widget.memory.handwrittenNote!,
                                style: AppTheme.handwrittenStyle(
                                  fontSize: 15,
                                  color: AppTheme.darkCharcoal.withValues(alpha: 0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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
}

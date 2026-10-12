import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../utils/theme.dart';

class BackgroundVideoPlayer extends StatefulWidget {
  final Widget child;
  final List<String> videoPaths;
  final double overlayOpacity;

  const BackgroundVideoPlayer({
    super.key,
    required this.child,
    this.videoPaths = const [
      "assets/videos/video_01.mp4",
      "assets/videos/video_02.mp4",
    ],
    this.overlayOpacity = 0.30,
  });

  @override
  State<BackgroundVideoPlayer> createState() => _BackgroundVideoPlayerState();
}

class _BackgroundVideoPlayerState extends State<BackgroundVideoPlayer> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Defer video decoding slightly so the page and photos paint immediately with zero delay
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _initVideo(0);
        }
      });
    });
  }

  Future<void> _initVideo(int index) async {
    if (widget.videoPaths.isEmpty) return;
    for (int i = index; i < widget.videoPaths.length; i++) {
      try {
        final controller = VideoPlayerController.asset(widget.videoPaths[i]);
        await controller.initialize();
        await controller.setLooping(true);
        await controller.setVolume(0.0); // Muted for ambient background
        await controller.play();

        if (mounted) {
          setState(() {
            _controller = controller;
            _isInitialized = true;
          });
          return;
        } else {
          await controller.dispose();
          return;
        }
      } catch (e) {
        debugPrint("Background video ${widget.videoPaths[i]} playback fallback: $e");
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;

    return Stack(
      children: [
        // 1. Ambient Background Video Layer (or warm background fallback)
        Positioned.fill(
          child: RepaintBoundary(
            child: _isInitialized && controller != null && controller.value.isInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller.value.size.width,
                        height: controller.value.size.height,
                        child: VideoPlayer(controller),
                      ),
                    ),
                  )
                : Container(color: AppTheme.primaryBackground),
          ),
        ),

        // 2. Soft Tint Overlay so content is always readable
        Positioned.fill(
          child: Container(
            color: const Color(0xFFFAF7F2).withValues(alpha: widget.overlayOpacity),
          ),
        ),

        // 3. Main Application Content Child (Isolated in its own paint boundary for silky 60fps scrolling)
        Positioned.fill(
          child: RepaintBoundary(
            child: widget.child,
          ),
        ),
      ],
    );
  }
}

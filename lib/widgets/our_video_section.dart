import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';

/// Interactive Video Section showcasing real DJI drone road trip videos
/// with poster thumbnails, clean playback controls, and road trip photos.
class OurVideoSection extends StatefulWidget {
  const OurVideoSection({super.key});

  @override
  State<OurVideoSection> createState() => _OurVideoSectionState();
}

class _OurVideoSectionState extends State<OurVideoSection> {
  VideoPlayerController? _controller;
  int _activeVideoIndex = 0;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _isMuted = false;

  final List<Map<String, String>> _videos = [
    {
      "title": "OUR CAR ROAD TRIP 🚗💨",
      "path": "assets/videos/DJI_20250524162939_0013_D.MP4",
      "note": "sitting on top of our car together amidst the hills & tea gardens",
      "thumb": "assets/photos/video_thumb_roadtrip.png",
      "tag": "VALPARAI MEMORY"
    },
    {
      "title": "TEA ESTATES FROM THE SKY ⛰️🚁",
      "path": "assets/videos/DJI_20250524155353_0003_D.MP4",
      "note": "flying high above the green valleys and mist",
      "thumb": "assets/photos/video_thumb_hills.png",
      "tag": "DRONE AERIAL"
    },
    {
      "title": "CINEMATIC MOMENTS TOGETHER 🛣️✨",
      "path": "assets/videos/DJI_20250524163540_0026_D.MP4",
      "note": "driving forever through life with my favorite person",
      "thumb": "assets/photos/video_thumb_cinematic.png",
      "tag": "FOREVER RIDE"
    },
  ];

  @override
  void initState() {
    super.initState();
    // Videos load strictly on demand when user presses play, keeping page reload instantaneous!
  }

  Future<void> _loadVideo(int index, {bool autoPlay = false}) async {
    setState(() {
      _isInitialized = false;
    });

    _controller?.dispose();
    _controller = null;

    try {
      final controller = VideoPlayerController.asset(_videos[index]["path"]!);
      await controller.initialize();
      await controller.setLooping(true);
      if (mounted) {
        setState(() {
          _controller = controller;
          _isInitialized = true;
          _isPlaying = autoPlay;
        });
        if (autoPlay) {
          await controller.play();
        }
      } else {
        await controller.dispose();
      }
    } catch (e) {
      debugPrint("Video load info: $e");
      if (mounted) {
        setState(() {
          _isInitialized = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlay() {
    final controller = _controller;
    if (!_isInitialized || controller == null) return;
    setState(() {
      if (controller.value.isPlaying) {
        controller.pause();
        _isPlaying = false;
      } else {
        controller.play();
        _isPlaying = true;
      }
    });
  }

  void _toggleMute() {
    final controller = _controller;
    if (!_isInitialized || controller == null) return;
    setState(() {
      _isMuted = !_isMuted;
      controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 50 : 80,
        horizontal: 20,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Section Tag Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.deepBurgundy.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppTheme.deepBurgundy.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("🚁", style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 6),
                    Text(
                      "DJI DRONE & CAR ROAD TRIPS",
                      style: AppTheme.monoStyle(
                        fontSize: 11,
                        letterSpacing: 2.2,
                        color: AppTheme.deepBurgundy,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "Our Cinematic Journey Together",
                textAlign: TextAlign.center,
                style: AppTheme.serifStyle(
                  fontSize: isMobile ? 26 : 38,
                  color: AppTheme.darkCharcoal,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),

              Text(
                "Captured from the sky & roads of Valparai with Mani at the controls ♡",
                textAlign: TextAlign.center,
                style: GoogleFonts.ebGaramond(
                  fontSize: isMobile ? 15 : 18,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.mutedGray,
                ),
              ),
              const SizedBox(height: 28),

              // Roadside Stone Wall Photo Showcase (Real Photo Attached by User!)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFD4AF37).withValues(alpha: 0.6),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: AspectRatio(
                        aspectRatio: isMobile ? 16 / 10 : 16 / 9,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/photos/white_car_drone_selfie.jpg',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: const Color(0xFFEFEBE9),
                                child: const Center(
                                  child: Icon(Icons.photo_camera, size: 40, color: Colors.grey),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.75),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("📸", style: TextStyle(fontSize: 12)),
                                    const SizedBox(width: 6),
                                    Text(
                                      "Mani & Srinithi by our car with drone remote",
                                      style: GoogleFonts.outfit(
                                        fontSize: isMobile ? 10 : 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        "“Sitting on the roadside stone wall by our car in matching whites — Mani flying the drone & capturing our favorite world.”",
                        style: GoogleFonts.caveat(
                          fontSize: isMobile ? 16 : 19,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4A2835),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Video Selector Tabs (SingleChildScrollView to never overflow!)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_videos.length, (index) {
                    final isSelected = _activeVideoIndex == index;
                    final videoData = _videos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: ChoiceChip(
                        label: Text(
                          videoData["tag"]!,
                          style: AppTheme.monoStyle(
                            fontSize: 10.5,
                            color: isSelected ? Colors.white : AppTheme.deepBurgundy,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppTheme.deepBurgundy,
                        backgroundColor: AppTheme.warmPaper,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: isSelected
                                ? AppTheme.deepBurgundy
                                : const Color(0xFFD4AF37).withValues(alpha: 0.5),
                          ),
                        ),
                        onSelected: (selected) {
                          if (selected && _activeVideoIndex != index) {
                            setState(() {
                              _activeVideoIndex = index;
                            });
                            _loadVideo(index);
                          }
                        },
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),

              // Video Player Card Frame
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF141218), // Deep Cinematic Obsidian
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    // Video Viewport with Poster Thumbnail fallback
                    Builder(
                      builder: (context) {
                        final controller = _controller;
                        final hasController = _isInitialized && controller != null;
                        final currentThumb = _videos[_activeVideoIndex]["thumb"]!;

                        return ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: AspectRatio(
                            aspectRatio: hasController ? controller.value.aspectRatio : 16 / 9,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Video or Poster image
                                if (hasController && _isPlaying)
                                  VideoPlayer(controller)
                                else
                                  Image.asset(
                                    currentThumb,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: Colors.black,
                                      child: const Center(
                                        child: Icon(
                                          Icons.movie_creation_outlined,
                                          color: Color(0xFFFFD54F),
                                          size: 48,
                                        ),
                                      ),
                                    ),
                                  ),

                                // Dark gradient scrim when paused
                                if (!_isPlaying)
                                  Container(
                                    color: Colors.black.withValues(alpha: 0.35),
                                  ),

                                // Play / Pause Button Overlay
                                GestureDetector(
                                  onTap: () {
                                    if (!hasController) {
                                      _loadVideo(_activeVideoIndex, autoPlay: true);
                                    } else {
                                      _togglePlay();
                                    }
                                  },
                                  child: Container(
                                    width: 68,
                                    height: 68,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFFFFD54F),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.4),
                                          blurRadius: 16,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                      color: const Color(0xFF3E2723),
                                      size: 42,
                                    ),
                                  ),
                                ),

                                // Mute/Unmute Button
                                if (hasController)
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: GestureDetector(
                                      onTap: _toggleMute,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black.withValues(alpha: 0.65),
                                        ),
                                        child: Icon(
                                          _isMuted ? Icons.volume_off : Icons.volume_up,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 14),

                    // Title & Note Below Video
                    Text(
                      _videos[_activeVideoIndex]["title"]!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: isMobile ? 15 : 18,
                        color: const Color(0xFFFFD54F),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      "“${_videos[_activeVideoIndex]['note']}”",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.ebGaramond(
                        fontSize: isMobile ? 14 : 17,
                        fontStyle: FontStyle.italic,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

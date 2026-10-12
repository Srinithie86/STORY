import 'package:flutter/material.dart';
import '../services/audio_service.dart';
import '../data/story_data.dart';
import '../utils/theme.dart';
import '../utils/responsive.dart';
import 'south_indian_decorations.dart';

class MusicPlayerSection extends StatefulWidget {
  const MusicPlayerSection({super.key});

  @override
  State<MusicPlayerSection> createState() => _MusicPlayerSectionState();
}

class _MusicPlayerSectionState extends State<MusicPlayerSection>
    with TickerProviderStateMixin {
  final AudioService _audioService = AudioService();
  late AnimationController _rotationController;
  late AnimationController _equalizerController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    _equalizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _audioService.audioStateNotifier.addListener(() {
      if (_audioService.audioStateNotifier.value == AudioState.playing) {
        _rotationController.repeat();
      } else {
        _rotationController.stop();
      }
    });
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _equalizerController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: Colors.transparent,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 48 : 90,
        horizontal: isMobile ? 12 : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: ZariBorderContainer(
            backgroundColor: AppTheme.primaryBackground.withValues(alpha: 0.90),
            zariColor: const Color(0xFFD4AF37),
            padding: EdgeInsets.all(isMobile ? 16 : 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("🪷 ", style: TextStyle(fontSize: 14)),
                    Text(
                      "OUR SONG",
                      style: AppTheme.monoStyle(
                        fontSize: 12,
                        letterSpacing: 2.5,
                        color: const Color(0xFFFFD54F),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text("♫", style: TextStyle(color: Color(0xFFFFD54F), fontSize: 14)),
                  ],
                ),
                const SizedBox(height: 24),

                // Vinyl Disc Graphic with Gold Glow
                RotationTransition(
                  turns: _rotationController,
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.darkCharcoal,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFD4AF37).withValues(alpha:  0.35),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Concentric grooves
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFD4AF37).withValues(alpha:  0.25),
                              width: 8,
                            ),
                          ),
                        ),
                        // Center Label
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF6B0F1A),
                          ),
                          child: const Center(
                            child: Text(
                              "♡",
                              style: TextStyle(
                                color: Color(0xFFFFD54F),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Track metadata
                Text(
                  StoryConfig.songTitle,
                  style: AppTheme.serifStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  StoryConfig.songArtist,
                  style: AppTheme.handwrittenStyle(
                    fontSize: 18,
                    color: AppTheme.mutedRose,
                  ),
                ),
                const SizedBox(height: 24),

                // ValueNotifiers for audio playback state & progress slider
                ValueListenableBuilder<AudioState>(
                  valueListenable: _audioService.audioStateNotifier,
                  builder: (context, state, child) {
                    return ValueListenableBuilder<Duration>(
                      valueListenable: _audioService.positionNotifier,
                      builder: (context, position, child) {
                        return ValueListenableBuilder<Duration>(
                          valueListenable: _audioService.durationNotifier,
                          builder: (context, duration, child) {
                            final maxSeconds = duration.inSeconds > 0
                                ? duration.inSeconds.toDouble()
                                : 100.0;
                            final currentSeconds = position.inSeconds
                                .toDouble()
                                .clamp(0.0, maxSeconds);

                            return Column(
                              children: [
                                SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 3,
                                    activeTrackColor: AppTheme.deepBurgundy,
                                    inactiveTrackColor: AppTheme.warmTaupe,
                                    thumbColor: AppTheme.deepBurgundy,
                                    thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6),
                                    overlayShape: const RoundSliderOverlayShape(
                                        overlayRadius: 14),
                                  ),
                                  child: Slider(
                                    value: currentSeconds,
                                    min: 0.0,
                                    max: maxSeconds,
                                    onChanged: (val) {
                                      _audioService.seek(
                                          Duration(seconds: val.toInt()));
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 16),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          _formatDuration(position),
                                          style: AppTheme.monoStyle(
                                            fontSize: 11,
                                            color: AppTheme.mutedGray,
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Text(
                                          state == AudioState.playing
                                              ? "♥ playing for you"
                                              : "press play",
                                          style: AppTheme.handwrittenStyle(
                                            fontSize: 16,
                                            color: AppTheme.deepBurgundy,
                                          ),
                                        ),
                                        const SizedBox(width: 24),
                                        Text(
                                          _formatDuration(duration),
                                          style: AppTheme.monoStyle(
                                            fontSize: 11,
                                            color: AppTheme.mutedGray,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Play / Pause Button
                                InkWell(
                                  onTap: () {
                                    _audioService.playOrPause();
                                  },
                                  borderRadius: BorderRadius.circular(40),
                                  child: Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppTheme.darkCharcoal,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.darkCharcoal
                                              .withValues(alpha: 0.15),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      state == AudioState.playing
                                          ? Icons.pause
                                          : Icons.play_arrow_rounded,
                                      color: AppTheme.warmPaper,
                                      size: 30,
                                    ),
                                  ),
                                ),

                                if (state == AudioState.error) ...[
                                  const SizedBox(height: 16),
                                  Text(
                                    "OUR SONG WILL LIVE HERE ♫",
                                    style: AppTheme.monoStyle(
                                      fontSize: 11,
                                      color: AppTheme.deepBurgundy,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

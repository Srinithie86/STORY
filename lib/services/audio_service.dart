import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/story_data.dart';

enum AudioState { stopped, playing, paused, error, uninitialized }

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;
  AudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  final ValueNotifier<AudioState> audioStateNotifier =
      ValueNotifier<AudioState>(AudioState.uninitialized);
  final ValueNotifier<Duration> positionNotifier =
      ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<Duration> durationNotifier =
      ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<String?> errorMessageNotifier =
      ValueNotifier<String?>(null);

  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    _player.onPlayerStateChanged.listen((state) {
      switch (state) {
        case PlayerState.playing:
          audioStateNotifier.value = AudioState.playing;
          break;
        case PlayerState.paused:
          audioStateNotifier.value = AudioState.paused;
          break;
        case PlayerState.stopped:
        case PlayerState.completed:
          audioStateNotifier.value = AudioState.stopped;
          break;
        default:
          break;
      }
    });

    _player.onPositionChanged.listen((pos) {
      positionNotifier.value = pos;
    });

    _player.onDurationChanged.listen((dur) {
      durationNotifier.value = dur;
    });
  }

  Future<void> playOrPause() async {
    try {
      await init();
      if (audioStateNotifier.value == AudioState.playing) {
        await _player.pause();
      } else {
        // Strip assets/ prefix if present for AssetSource in audioplayers
        String assetPath = StoryConfig.songPath;
        if (assetPath.startsWith("assets/")) {
          assetPath = assetPath.replaceFirst("assets/", "");
        }
        await _player.play(AssetSource(assetPath));
      }
    } catch (e) {
      if (kDebugMode) {
        print("Audio playback error: $e");
      }
      audioStateNotifier.value = AudioState.error;
      errorMessageNotifier.value = "OUR SONG WILL LIVE HERE ♫";
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (_) {}
  }

  void dispose() {
    _player.dispose();
  }
}

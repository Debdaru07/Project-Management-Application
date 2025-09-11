import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimationInfo {
  final List<Effect> effectsBuilder;
  final int delay;

  AnimationInfo({required this.effectsBuilder, this.delay = 0});
}

class AnimationEffectConstants {
  static Map<String, AnimationInfo> usualAnimationEffects = {
    'summaryCardAnimation': AnimationInfo(
      effectsBuilder: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: Duration(milliseconds: 100),
          duration: Duration(milliseconds: 400),
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: Duration(milliseconds: 100),
          duration: Duration(milliseconds: 400),
          begin: Offset(0.0, 20.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'leadRowAnimation': AnimationInfo(
      effectsBuilder: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: Duration(milliseconds: 100),
          duration: Duration(milliseconds: 400),
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: Duration(milliseconds: 100),
          duration: Duration(milliseconds: 400),
          begin: Offset(-20.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
    'buttonTapAnimation': AnimationInfo(
      effectsBuilder: [
        ScaleEffect(
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 100),
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
        ),
      ],
    ),
    'pageChangeAnimation': AnimationInfo(
      effectsBuilder: [
        FadeEffect(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 400),
          begin: 0.0,
          end: 1.0,
        ),
        MoveEffect(
          curve: Curves.easeOut,
          duration: Duration(milliseconds: 400),
          begin: Offset(50.0, 0.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };
}

import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybird/components/background.dart';
import 'package:flappybird/components/bird.dart';

class FlappyBirdGame extends FlameGame with TapDetector{
  late Bird bird;
  late Background background;

  @override
  FutureOr<void> onLoad() {
    bird = Bird();
    add(bird);

    background = Background(size);
    add(background);

  }

  @override
  void onTap() {
    bird.flap();
  }
}
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappybird/constants/constants.dart';
import 'package:flappybird/game.dart';

class Ground extends SpriteComponent with HasGameRef<FlappyBirdGame>, CollisionCallbacks{
  Ground() : super();

  @override
  FutureOr<void> onLoad() async{
    size = Vector2(2*gameRef.size.x, groundConst);
    position = Vector2(0, gameRef.size.y-groundConst);
    sprite = await Sprite.load("ground.png");
    
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    position.x -= groundScrolling * dt;

    if(position.x + size.x / 2 <= 0){
      position.x = 0;
    }
  }
}
import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappybird/constants/constants.dart';
import 'package:flappybird/game.dart';

class Pipe extends SpriteComponent with CollisionCallbacks, HasGameRef<FlappyBirdGame>{
  final bool isTopPipe;
  Pipe(Vector2 size, Vector2 position, {required this.isTopPipe}) :
        super(position: position, size: size);

  bool scored = false;

  @override
  FutureOr<void> onLoad() async{
    sprite = await Sprite.load(isTopPipe? "top_pole.png" : "bottom_pole.png");
    add(RectangleHitbox());
  }

  @override
  void update(double dt){
    position.x -= groundScrolling * dt;

    if(!scored && gameRef.bird.position.x > position.x + size.x){
      scored = true;

      if(isTopPipe){
        gameRef.incrementScore();
      }
    }

    if(position.x + size.x <= 0){
      removeFromParent();
    }
  }
}
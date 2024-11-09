import 'dart:math';

import 'package:flame/components.dart';
import 'package:flappybird/components/pipe.dart';
import 'package:flappybird/constants/constants.dart';
import 'package:flappybird/game.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame>{
  double pipeSpawnTimer = 0;

  @override
  void update(double dt){
   pipeSpawnTimer += dt;
   const double pipeInterval = 2;

   if(pipeSpawnTimer > pipeInterval){
    pipeSpawnTimer=0;
    spawnPipe();
   }
    }

    void spawnPipe(){
    final double screenHeight = gameRef.size.y;


    final double maxPipeHeight =
        screenHeight - groundConst - pipeGap - minPipeHeight;
    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight-minPipeHeight);
    final double topPipeHeight =
        screenHeight - groundConst - bottomPipeHeight - pipeGap;


    final bottomPipe = Pipe(
        Vector2(pipeWidth,bottomPipeHeight),
        Vector2(gameRef.size.x, screenHeight-groundConst-bottomPipeHeight),
        isTopPipe: false);
    
    final topPipe = Pipe(
        Vector2(pipeWidth,topPipeHeight),
        Vector2(gameRef.size.x, 0)
        , isTopPipe: true);

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
    }
  }
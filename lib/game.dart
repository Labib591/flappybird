import 'dart:async';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappybird/components/background.dart';
import 'package:flappybird/components/bird.dart';
import 'package:flappybird/components/ground.dart';
import 'package:flappybird/components/pipe_manager.dart';
import 'package:flappybird/components/score.dart';
import 'package:flappybird/constants/constants.dart';
import 'package:flutter/material.dart';

import 'components/pipe.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection{
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;


  int score = 0;
  int highScore = 0;

  void incrementScore(){
    score+=1;
  }

  @override
  FutureOr<void> onLoad() {

    background = Background(size);
    add(background);

    bird = Bird();
    add(bird);

    ground = Ground();
    add(ground);

    pipeManager = PipeManager();
    add(pipeManager);

    scoreText = ScoreText();
    add(scoreText);

  }

  @override
  void onTap() {
    bird.flap();
  }

  bool isGameover = false;

  void gameOver(){
    if(isGameover) return;

    isGameover = true;
    pauseEngine();

    if(score > highScore){
      highScore = score;
    };

    showDialog(
        context: buildContext!,
        builder: (context) => AlertDialog(
          title: Column(
            children: [
              const Text("Game Over"),
              Text("Score : $score"),
              Text("Highest Score : $highScore"),
            ],
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
              resetGame();
            },
                child: const Text("Restart"))
          ],
        ));
  }

  void resetGame(){
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity =0;
    isGameover = false;
    children.whereType<Pipe>().forEach((Pipe pipe) => pipe.removeFromParent());
    score = 0;
    resumeEngine();
  }
}
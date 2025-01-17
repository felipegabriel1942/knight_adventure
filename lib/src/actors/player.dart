import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:knight_adventure/knight_adventure.dart';

enum PlayerState { idle }

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<KnightAdventure>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;

  double horizontalMovement = 0;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();

  Player({super.position});

  @override
  FutureOr<void> onLoad() {
    // anchor = Anchor.center;
    debugMode = true;

    final spriteSheet = SpriteSheet(
      image: game.images.fromCache('knight.png'),
      srcSize: Vector2.all(32.0),
    );

    idleAnimation = SpriteAnimation.fromFrameData(
      spriteSheet.image,
      SpriteAnimationData([
        spriteSheet.createFrameData(0, 0, stepTime: 0.1),
        spriteSheet.createFrameData(0, 1, stepTime: 0.1),
        spriteSheet.createFrameData(0, 2, stepTime: 0.1),
        spriteSheet.createFrameData(0, 3, stepTime: 0.1),
      ]),
    );

    animations = {
      PlayerState.idle: idleAnimation,
    };

    current = PlayerState.idle;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    velocity.x = horizontalMovement * moveSpeed;
    position.x += velocity.x * dt;
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    horizontalMovement = 0;

    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);

    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);

    horizontalMovement += isLeftKeyPressed ? -1 : 0;
    horizontalMovement += isRightKeyPressed ? 1 : 0;

    return super.onKeyEvent(event, keysPressed);
  }
}

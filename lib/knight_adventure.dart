import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:knight_adventure/src/actors/player.dart';
import 'package:knight_adventure/src/levels/level.dart';

class KnightAdventure extends FlameGame with HasKeyboardHandlerComponents {
  late final CameraComponent cam;
  late final Player player;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();

    player = Player();
    final world = Level(player: player);

    camera = CameraComponent.withFixedResolution(
      width: 320,
      height: 160,
      world: world,
    );

    camera.viewfinder.anchor = const Anchor(0.2, 0.6);

    camera.follow(player);

    addAll([camera, world]);

    return super.onLoad();
  }

  @override
  Color backgroundColor() => const Color(0xFF211F30);
}

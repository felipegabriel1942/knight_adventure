import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:knight_adventure/knight_adventure.dart';
import 'package:knight_adventure/src/actors/player.dart';

class Level extends World with HasGameRef<KnightAdventure> {
  final Player player;

  late TiledComponent level;

  Level({required this.player});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      'Level-02.tmx',
      Vector2.all(16),
    );

    add(level);

    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>('Spawnpoints');

    if (spawnPointsLayer != null) {
      for (final spawnPoint in spawnPointsLayer.objects) {
        switch (spawnPoint.class_) {
          case 'Player':
            player.position = Vector2(spawnPoint.x, spawnPoint.y);
            add(player);
            break;
          default:
            break;
        }
      }
    }

    return super.onLoad();
  }
}

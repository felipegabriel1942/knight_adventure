import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:knight_adventure/knight_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  // await Flame.device.fullScreen();
  // await Flame.device.setLandscape();

  KnightAdventure game = KnightAdventure();

  runApp(GameWidget(game: kDebugMode ? game : KnightAdventure()));
}

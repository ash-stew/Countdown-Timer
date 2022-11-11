import 'dart:math';
import 'package:flutter/material.dart';

class Shared {
  static Color getRandomColor() {
    List colors = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.blue,
      Colors.amber,
      Colors.purple,
      Colors.cyan,
      Colors.limeAccent
    ];
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    Color randomColor = colors[randomIndex];

    return randomColor;
  }
}

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

Future<ui.Image> loadUiImage(String imageAssetPath) async {
  final ByteData data = await rootBundle.load(imageAssetPath);
  final Completer<ui.Image> completer = Completer();
  ui.decodeImageFromList(Uint8List.view(data.buffer), (ui.Image img) {
    return completer.complete(img);
  });
  return completer.future;
}

enum BugColor {
  red,
  orange,
  yellow,
  green,
  blue,
  purple,
}

enum BugShapes {
  triangle1,
  triangle2,
  triangle3,
  triangle4,
  square1,
  square2,
  square3,
  square4,
  circle1,
  circle2,
  circle3,
  circle4,
  star1,
  star2,
  star3,
  star4,
}

enum BugEyes {
  little,
  big,
}

class Bug {
  final BugColor color;
  final BugShapes shapes;
  final BugEyes eyes;
  final ({double x, double y}) position;

  Bug(this.color, this.shapes, this.eyes, this.position);
}

Map<BugColor, Offset> colors = {
  BugColor.red: Offset.zero,
  BugColor.orange: const Offset(39, 0),
  BugColor.yellow: const Offset(39, 78),
  BugColor.green: const Offset(39, 39),
  BugColor.blue: const Offset(0, 39),
  BugColor.purple: const Offset(0, 78),
};
Map<BugShapes, Offset> shapes = {
  BugShapes.star4: const Offset(78, 0),
  BugShapes.star3: const Offset(78, 39),
  BugShapes.star2: const Offset(78, 78),
  BugShapes.star1: const Offset(78, 117),
  BugShapes.triangle4: const Offset(117, 117),
  BugShapes.triangle3: const Offset(117, 156),
  BugShapes.triangle2: const Offset(156, 0),
  BugShapes.triangle1: const Offset(156, 39),
  BugShapes.circle4: const Offset(78, 156),
  BugShapes.circle3: const Offset(117, 0),
  BugShapes.circle2: const Offset(117, 39),
  BugShapes.circle1: const Offset(117, 78),
  BugShapes.square4: const Offset(0, 117),
  BugShapes.square3: const Offset(39, 117),
  BugShapes.square2: const Offset(39, 156),
  BugShapes.square1: const Offset(0, 156),
};
Map<BugEyes, Offset> eyes = {
  BugEyes.little: const Offset(156, 78),
  BugEyes.big: const Offset(156, 117),
};

class RugPainter extends CustomPainter {
  RugPainter(this.bugs) {
    loadUiImage('images/spritesheet.png').then((value) {
      image = value;
      initialized.complete();
    });
  }
  final List<Bug> bugs;
  late ui.Image image;
  Completer<void> initialized = Completer();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawAtlas(
      image,
      bugs
          .expand(
            (bug) => List.filled(
              3,
              RSTransform.fromComponents(
                rotation: 0,
                scale: 5,
                anchorX: 0,
                anchorY: 0,
                translateX: bug.position.x * size.width,
                translateY: bug.position.y * size.height,
              ),
            ),
          )
          .toList(),
      bugs
          .expand((bug) => [
                colors[bug.color]! & const Size(39, 39),
                shapes[bug.shapes]! & const Size(39, 39),
                eyes[bug.eyes]! & const Size(39, 39)
              ])
          .toList(),
      null,
      null,
      null,
      Paint()..isAntiAlias = false,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

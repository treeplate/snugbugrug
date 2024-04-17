import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snugbugrug/images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Random r = Random();
  late List<Bug> rug = [
    Bug(
      BugColor.red,
      BugShapes.triangle1,
      BugEyes.big,
      (x: 0, y: 0),
    ),
    Bug(
      BugColor.red,
      BugShapes.square2,
      BugEyes.little,
      (x: 0, y: .25),
    ),
    Bug(
      BugColor.red,
      BugShapes.star3,
      BugEyes.little,
      (x: 0, y: .5),
    ),
    Bug(
      BugColor.red,
      BugShapes.circle4,
      BugEyes.big,
      (x: 0, y: .75),
    ),
    Bug(
      BugColor.orange,
      BugShapes.square1,
      BugEyes.big,
      (x: 1 / 6, y: 0),
    ),
    Bug(
      BugColor.orange,
      BugShapes.triangle2,
      BugEyes.little,
      (x: 1 / 6, y: .25),
    ),
    Bug(
      BugColor.orange,
      BugShapes.star3,
      BugEyes.little,
      (x: 1 / 6, y: .5),
    ),
    Bug(
      BugColor.orange,
      BugShapes.circle4,
      BugEyes.big,
      (x: 1 / 6, y: .75),
    ),
    Bug(
      BugColor.yellow,
      BugShapes.square1,
      BugEyes.little,
      (x: 1 / 3, y: 0),
    ),
    Bug(
      BugColor.yellow,
      BugShapes.star2,
      BugEyes.big,
      (x: 1 / 3, y: .25),
    ),
    Bug(
      BugColor.yellow,
      BugShapes.circle3,
      BugEyes.little,
      (x: 1 / 3, y: .5),
    ),
    Bug(
      BugColor.yellow,
      BugShapes.triangle4,
      BugEyes.big,
      (x: 1 / 3, y: .75),
    ),
    Bug(
      BugColor.green,
      BugShapes.circle1,
      BugEyes.little,
      (x: .5, y: 0),
    ),
    Bug(
      BugColor.green,
      BugShapes.triangle2,
      BugEyes.big,
      (x: .5, y: .25),
    ),
    Bug(
      BugColor.green,
      BugShapes.square3,
      BugEyes.little,
      (x: .5, y: .5),
    ),
    Bug(
      BugColor.green,
      BugShapes.star4,
      BugEyes.big,
      (x: .5, y: .75),
    ),
    Bug(
      BugColor.blue,
      BugShapes.star1,
      BugEyes.big,
      (x: 2 / 3, y: 0),
    ),
    Bug(
      BugColor.blue,
      BugShapes.circle2,
      BugEyes.little,
      (x: 2 / 3, y: .25),
    ),
    Bug(
      BugColor.blue,
      BugShapes.square3,
      BugEyes.big,
      (x: 2 / 3, y: .5),
    ),
    Bug(
      BugColor.blue,
      BugShapes.triangle4,
      BugEyes.little,
      (x: 2 / 3, y: .75),
    ),
    Bug(
      BugColor.purple,
      BugShapes.star1,
      BugEyes.big,
      (x: 5 / 6, y: 0),
    ),
    Bug(
      BugColor.purple,
      BugShapes.circle2,
      BugEyes.big,
      (x: 5 / 6, y: .25),
    ),
    Bug(
      BugColor.purple,
      BugShapes.triangle3,
      BugEyes.little,
      (x: 5 / 6, y: .5),
    ),
    Bug(
      BugColor.purple,
      BugShapes.square4,
      BugEyes.little,
      (x: 5 / 6, y: .75),
    ),
  ];
  RugPainter? rugPainter;
  @override
  void initState() {
    super.initState();
    RugPainter rugPainter = RugPainter(rug);
    () async {
      await rugPainter.initialized.future;
      setState(() {
        this.rugPainter = rugPainter;
      });
    }();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (rugPainter != null)
              LayoutBuilder(builder: (context, constraints) {
                return CustomPaint(
                  painter: rugPainter,
                  size: const Size(1170, 780),
                );
              })
            else
              const Placeholder(),
          ],
        ),
      ),
    );
  }
}

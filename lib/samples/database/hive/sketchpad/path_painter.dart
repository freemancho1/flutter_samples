import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/colored_path.dart';

class PathPainter extends CustomPainter {
  final ColoredPath path;
  const PathPainter({required this.path});

  @override
  void paint(Canvas canvas, Size size) =>
      canvas.drawPath(path.path, path.paint);

  @override
  bool shouldRepaint(PathPainter oldDelegate) => true;
}
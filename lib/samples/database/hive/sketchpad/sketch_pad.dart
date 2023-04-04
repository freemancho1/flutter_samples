import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/hive_config.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/buttons.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/colored_path.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/drawing_area.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/path_painter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SketchPad extends StatefulWidget {
  const SketchPad({Key? key}) : super(key: key);

  @override
  State<SketchPad> createState() => _SketchPadState();
}

class _SketchPadState extends State<SketchPad> {
  final Box _box = Hive.box(HiveCfg.tableSketchPadName);
  int colorIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Sketch Pad'),),
    body: Column(
      children: [
        _drawingPad(),
        _colorPicker(),
      ],
    ),
  );

  Widget _drawingPad() => Expanded(
    child: Stack(
      children: [
        ValueListenableBuilder(
          valueListenable: _box.listenable(),
          builder: (context, box, _) => _buildPathsFromBox(context, box),
        ),
        DrawingArea(colorIndex: colorIndex),
        const Positioned(top: 8, right: 8, child: Text('powered by Freeman')),
      ],
    ),
  );

  Widget _buildPathsFromBox(BuildContext context, Box box) {
    Iterable<ColoredPath> paths = box.values.whereType<ColoredPath>();
    return Stack(
      children: [ for (ColoredPath path in paths)
        CustomPaint(size: Size.infinite, painter: PathPainter(path: path),)
      ],
    );
  }

  Widget _colorPicker() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i=0; i<ColoredPath.colors.length; i++)
            _makeColorCircle(i),
          const ClearButton(),
          const UndoButton(),
        ],
      )
    ],
  );

  Widget _makeColorCircle(int colorIdx) {
    bool selected = colorIndex == colorIdx;
    return GestureDetector(
      onTap: () => setState(() => colorIndex = colorIdx),
      /// ClipOval - 사각형의 기본 위젯을 원형으로 자름.(원형 위젯을 만듬)
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          width: selected ? 48 : 32,
          height: selected ? 48 : 32,
          color: ColoredPath.colors[colorIdx],
        ),
      ),
    );
  }
}

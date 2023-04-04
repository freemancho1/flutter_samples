import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/hive_config.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/colored_path.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/path_painter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DrawingArea extends StatefulWidget {
  final int colorIndex;
  const DrawingArea({super.key, required this.colorIndex});

  @override
  State<DrawingArea> createState() => _DrawingAreaState();
}

class _DrawingAreaState extends State<DrawingArea> {
  late ColoredPath path;
  final Box box = Hive.box(HiveCfg.tableSketchPadName);

  @override
  void initState() {
    super.initState();
    path = ColoredPath(widget.colorIndex);
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    /// 사용자가 화면을 터치하여 드레그를 시작할 때 호출
    onPanStart: (details) {
      /// 새로운 패스를 하나 생성하고
      path = ColoredPath(widget.colorIndex);
      _addPoint(details.globalPosition);
    },
    /// 사용자가 화면을 터치하고 이동할 때 호출
    onPanUpdate: (details) => _addPoint(details.globalPosition),
    onPanEnd: (details) {
      /// 드레그가 완료되면 해당 패스를 하이브에 저장
      box.add(path);
      /// 새로운 패스 초기화
      setState(() => path = ColoredPath(widget.colorIndex));
    },
    child: CustomPaint(size: Size.infinite, painter: PathPainter(path: path),),
  );

  void _addPoint(Offset point) {
    /// 해당 위치(시작점)을 저장하기 위해 renderBox를 호출해
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    /// 글로벌 포지션을 로컨 포지션으로 변경해 새로운 패스에 경로를 추가함.
    setState(() => path.addPoint(renderBox.globalToLocal(point)));
  }
}

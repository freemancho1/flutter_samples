import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/hive_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ColoredPath {
  static const List<Color> colors = [
    Colors.black, Colors.red, Colors.green, Colors.blue, Colors.amber,
  ];
  static List<Paint>? _paints;
  final int colorIndex;
  final path = Path();
  List<Offset> points = [];

  ColoredPath(this.colorIndex);

  /// Paint 클래스의 _paints 데이터를 리턴하는 getter함수 paint 선언.
  Paint get paint {
    _paints = _paints ?? [];
    for (Color color in colors) {
      _paints!.add(
        Paint()
            ..strokeCap = StrokeCap.round
            ..isAntiAlias = true
            ..color = color
            ..strokeWidth = 3
            ..style = PaintingStyle.stroke,
      );
    }
    /// 색상 인덱스(colorIndex)을 받으면 해당 인덱스의 _paints를 리턴
    return _paints![colorIndex];
  }

  void addPoint(Offset point) {
    if (points.isEmpty) {
      /// 경과지가 없는 경우 해당 위치(point)로 이동
      path.moveTo(point.dx, point.dy);
    } else {
      /// 경과지가 있는 경우는 해당 위치까지 선으로 그림을 그림
      path.lineTo(point.dx, point.dy);
    }
    /// 마지막 포인트 저장
    points.add(point);
  }
}

class ColoredPathAdapter extends TypeAdapter<ColoredPath> {
  @override
  /// Hive Table ID와 중복되지 않게 처리
  final int typeId = HiveCfg.tableColoredPathId;

  @override
  ColoredPath read(BinaryReader reader) {
    ColoredPath path = ColoredPath(reader.readByte());
    int length = reader.readUint32();
    for (int i=0; i<length; i++) {
      path.addPoint(Offset(reader.readDouble(), reader.readDouble()));
    }
    return path;
  }

  @override
  void write(BinaryWriter writer, ColoredPath obj) {
    writer.writeByte(obj.colorIndex);
    writer.writeUint32(obj.points.length);
    for (Offset point in obj.points) {
      writer.writeDouble(point.dx);
      writer.writeDouble(point.dy);
    }
  }
}
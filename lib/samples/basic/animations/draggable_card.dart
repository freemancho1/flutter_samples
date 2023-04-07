import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class DraggableCard extends StatefulWidget {
  final Widget child = const FlutterLogo(size: 64,);
  const DraggableCard({super.key});

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {

  final Duration duration = const Duration(seconds: 1);
  late AnimationController _ac;
  late Animation<Alignment> _animation;

  /// 초기값이 Alignment.center이긴 하지만,
  /// 드래그될 때 이동한 값으로 어차피 변경되니 그때 초기화
  late Alignment _dragAlignment;

  void _runAnimation(Offset pixelsPerSecond, Size size) {
    _animation = _ac.drive(AlignmentTween(
      begin: _dragAlignment, end: Alignment.center
    ));

    final unitsPerSecondX = pixelsPerSecond.dx / size.width;
    final unitsPerSecondY = pixelsPerSecond.dy / size.height;
    final unitsPerSecond = Offset(unitsPerSecondX, unitsPerSecondY);
    final unitVelocity = unitsPerSecond.distance;

    const spring = SpringDescription(
      mass: 30, stiffness: 1, damping: 1
    );
    final simulation = SpringSimulation(spring, 0, 1, -unitVelocity);
    _ac.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(vsync: this, duration: duration)
        ..addListener(() => setState(() => _dragAlignment = _animation.value));
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  /// Align - 자식 위젯의 위치와 크기를 지정
  /// alignment - Alignment (-1,-1)[왼쪽상단] ~ Alignment(1,1)[오른쪽하단]
  /// widthFactor/heightFactor - 자식위젯 크기 지정(0~1)
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanDown: (details) => _ac.stop(),
      onPanUpdate: (details) => setState(() {
        _dragAlignment += Alignment(
          details.delta.dx / (size.width / 2),
          details.delta.dy / (size.height / 2)
        );
      }),
      onPanEnd: (details) => _runAnimation(details.velocity.pixelsPerSecond, size),
      child: Align(child: Card(child: widget.child,),),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class DraggableCard extends StatefulWidget {
  final Widget child = const FlutterLogo(size: 64,);
  const DraggableCard({super.key});

  @override
  State<DraggableCard> createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    /// 아래 mixin을 넣어야 AnimationController를 사용할 수 있음.
    with SingleTickerProviderStateMixin {

  final Duration duration = const Duration(seconds: 1);
  late AnimationController _ac;
  late Animation<Alignment> _animation;

  /// 위젯을 드레그할 때 움직이도록 위치를 지정하는 Alignment 추가(처음 중앙)
  Alignment _dragAlignment = Alignment.center;

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
    _ac = AnimationController(vsync: this)
        ..addListener(() => setState(() => _dragAlignment = _animation.value));
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    /// 위젯의 터치를 제어할 GestureDetector
    /// 거의 모든 터치를 제어할 수 있음.
    /// onPan* : 사용자가 화면을 클릭해 드래그하는 과정을 제어
    /// - onPanDown, onPanStart, onPanUpdate, onPanEnd, onPanCancel
    return Scaffold(
      appBar: AppBar(title: const Text('Draggable Card'),),
      body: GestureDetector(
        onPanDown: (details) {
          _ac.stop();
          debugPrint('onPanDown');
        },
        onPanUpdate: (details) => setState(() {
          debugPrint('onPanUpdate');
          _dragAlignment += Alignment(
            /// 현재좌표 / (위젯크기 /2) = Align에서 사용하는 좌
            details.delta.dx / (size.width / 2),
            details.delta.dy / (size.height / 2)
          );
        }),
        onPanEnd: (details) {
          _runAnimation(details.velocity.pixelsPerSecond, size);
          debugPrint('onPanEnd');
        },
        /// Align - 자식 위젯의 위치와 크기를 지정
        /// alignment - Alignment (-1,-1)[왼쪽상단] ~ Alignment(1,1)[오른쪽하단]
        /// widthFactor/heightFactor - 자식위젯 크기 지정(0~1)
        child: Align(child: Card(child: widget.child,),),
        // child: Align(child: widget.child,),
      ),
    );
  }
}

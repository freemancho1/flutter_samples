import 'package:flutter/material.dart';

class AnimationControllerApp extends StatefulWidget {
  const AnimationControllerApp({Key? key}) : super(key: key);

  @override
  State<AnimationControllerApp> createState() => _AnimationControllerAppState();
}

class _AnimationControllerAppState extends State<AnimationControllerApp>
    with SingleTickerProviderStateMixin {

  final Duration duration = const Duration(seconds: 1);
  /// 애니메이션은 AnimationController의 value 속성에 따라 진행하며,
  /// 이 값은 0~1의 값을 가진다.
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();
    /// 여기서 사용할 애니메이션 컨트롤러 (vsync: this)
    /// vsync는 AnimationController가 실행되는 화면이 다시 그려질 때 애니메이션을
    /// 동기화 하기위해 사용하며, 인수로 TickerProvider를 사용함,
    /// TickerProvider의 구현체는 SingleTickerProviderStateMixin
    /// 따라서 본 클래스에 with로 추가해줌.
    controller = AnimationController(vsync: this, duration: duration)
        /// AnimationController의 객체인 controller의 값이
        /// 0(dismissed)과 1(completed)사이를 오가면서 변경될 때
        /// 그 값을 갱신해주고, 이게 갱신되면서 위젯의 텍스트가 변경되는 애니메이션이 표현
        ..addListener(() {setState(() {});})
        /// 애니메이션 상태별로 수행할 작업 적용
        ..addStatusListener((status) {
          if (status == AnimationStatus.dismissed) {
            /// 애니메이션 시작 전 수행할 작업
            debugPrint('dismissed');
          } else if (status == AnimationStatus.forward) {
            /// 정방향 실행시 수행(애니메이션 종료시점까지 한번만 수행함)할 작업
            debugPrint('forward');
          } else if (status == AnimationStatus.completed) {
            /// 애니메이션이 정상적으로 종료된 경우 수행할 작업
            debugPrint('completed');
          } else { /// AnimationStatus.reverse
            /// 애니메이션이 역방향으로 진행할 때 수행할 작업(1회 실행)
            debugPrint('reverse');
          }
        });
  }

  @override
  void dispose() {
    /// initState()에서 초기화한 것들(컨트롤러 등)은,
    /// 위젯이 종료될 때 반드시 반납해야 함.
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Animation Controller')),
    body: Center(
      child: Column(
        /// 위/아래 간격 최소(컬럼이니 위/아래 간격이 mainAxis)
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ConstrainedBox는 자식 위젯의 크기를 제약하는 위젯으로
          /// 자식 위젯의 최대, 최소 크기를 지정할 수 있음.
          ConstrainedBox(
            /// 아래 코드에서 최대 크기만 200이 넘지 않도록 제한하고 있음.
            constraints: const BoxConstraints(
              /// minWidth: 100, minHeight: 100,
              /// maxWidth: 200, /// maxHeight: 200,
            ),
            /// 이 Text 위젯을 폭이 200을 넘지 못함(위 코드 영향)
            child: Text(
              /// double 값을 소수점 이하 2자리까지 정확도로 문자열로 반환(반올림함)
              /// 기존 double값은 유지됨.
              (1 + controller.value).toStringAsFixed(2),
              style: Theme.of(context).textTheme.displaySmall,
              textScaleFactor: 1 + controller.value,
            ),
          ),
          ElevatedButton(
            /// AnimationStatus의 종류
            /// dismissed - 시작되기 직전 상태
            /// forward - 애니메이션이 시작되어 정방향으로 진행중인 상태
            /// reverse - 역방향으로 진행중인 상태
            /// completed - 종료된 상태
            /// dismissed > forword > completed > reverse > dismissed 반복
            onPressed: () => controller.status == AnimationStatus.completed
                ? controller.reverse() : controller.forward(),
            child: const Text('Animate'),
          ),
        ],
      ),
    ),
  );
}

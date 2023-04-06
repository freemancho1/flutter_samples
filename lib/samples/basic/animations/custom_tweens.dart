import 'package:flutter/material.dart';

class CustomTweensApp extends StatefulWidget {
  const CustomTweensApp({Key? key}) : super(key: key);

  @override
  State<CustomTweensApp> createState() => _CustomTweensAppState();
}

class _CustomTweensAppState extends State<CustomTweensApp>
    with SingleTickerProviderStateMixin {

  final Duration duration = const Duration(seconds: 10);
  final String message = _message;
  late final AnimationController ac;
  late final Animation<String> animation;

  @override
  void initState() {
    super.initState();
    ac = AnimationController(vsync: this, duration: duration);
    animation = TypewriterTween(end: message).animate(ac);
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Custom Tween'),
      actions: [
        MaterialButton(
          textColor: Colors.white,
          onPressed: () => (ac.status == AnimationStatus.completed)
                /// 역방향으로 돌고 다 돌면 애니메이션 갱신
              ? ac.reverse().whenComplete(() => setState(() {}))
                /// 정방향으로 돌고 다 돌면 애니메이션 갱신
              : ac.forward().whenComplete(() => setState(() {})),
          child: Text(
            ac.status == AnimationStatus.completed ? 'Delete' : 'Write'
          ),
        )
      ],
    ),
    body: SafeArea(
      child: Container(
        /// 부모 클래스에서의 상대적 위치
        alignment: Alignment.bottomCenter,
        /// 하나의 자식위젯으로 스크롤 만들기
        /// 자식으로 Column을 써서 여러개의 자식을 사용할 수 있음.
        child: SingleChildScrollView(
          child: Column(
            /// 아래서부터
            mainAxisAlignment: MainAxisAlignment.end,
            /// 폭 전체
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 자식이 Padding 하나인데 굳이 Column을 사용한 이유는
              /// mainAxisAlignment, crossAxisAlignment를 이용하기 위함.
              Container(
                padding: const EdgeInsets.all(8),
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, _) => Text(
                    animation.value,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

/// 사용자정의 Tween클래스
class TypewriterTween extends Tween<String> {
  TypewriterTween({String begin='', String end=''})
      : super(begin: begin, end: end);

  /// 함수인자로 들어온 t값은 0~1사의 값으로 애니메이션의 duration의 백분률임.
  @override
  String lerp(double t) {
    var cutoff = (end!.length * t).round();
    /// 전체시간의 백분률 만큼의 문자를 리턴함.
    return end!.substring(0, cutoff);
  }
}


const String _message = '''
Sed ut perspiciatis, unde omnis iste natus error sit voluptatem accusantium
doloremque laudantium, totam rem aperiam eaque ipsa, quae ab illo inventore
veritatis et quasi architecto beatae vitae dicta sunt, explicabo. Nemo enim
ipsam voluptatem, quia voluptas sit, aspernatur aut odit aut fugit, sed quia
consequuntur magni dolores eos, qui ratione voluptatem sequi nesciunt, neque
porro quisquam est, qui dolorem ipsum, quia dolor sit amet consectetur
adipisci[ng] velit, sed quia non-numquam [do] eius modi tempora inci[di]dunt, ut
labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam,
quis nostrum[d] exercitationem ullam corporis suscipit laboriosam, nisi ut
aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit, qui in
ea voluptate velit esse, quam nihil molestiae consequatur, vel illum, qui
dolorem eum fugiat, quo voluptas nulla pariatur?
''';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AnimationAppBar extends StatefulWidget {
  const AnimationAppBar({Key? key}) : super(key: key);

  @override
  State<AnimationAppBar> createState() => _AnimationAppBarState();
}

class _AnimationAppBarState extends State<AnimationAppBar> {
  bool _isShowAppBar = true;
  late ScrollController _sc;

  @override
  void initState() {
    super.initState();
    _sc = ScrollController()
      ..addListener(() {
        setState(() {
          /// 사용자가 배열을 움직이는 방향 또는 상태(3가지)
          /// 1. idle    - 움직이지 않음
          /// 2. forward - 아래쪽(증가하는 방향)으로 이동
          /// 3. reverse - 위쪽(축소하는 방향)으로 이동
          ScrollDirection sd = _sc.position.userScrollDirection;
          if (sd == ScrollDirection.reverse) {
            _isShowAppBar = false;
          } else if (sd == ScrollDirection.forward) {
            _isShowAppBar = true;
          }
        });
      });
  }

  @override
  void dispose() {
    /// 일반적으로 initState()에서 생성한 오브젝트는 위젯이 종료될 때, 제거해야 함.
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _appBar(),
        body: _body(),
      );

  /// 앱바는 'Widget'을 리턴하면 안되고, 'PreferredSize'를 리턴해야 함.
  PreferredSize _appBar() => PreferredSize(
        /// 앱바이기 때문에 폭은 전체폭으로 고정이고,
        /// 일반적으로 높이만 결정하며, 기본값은 kToolbarHeight에 정의되어 있음.
        preferredSize: const Size.fromHeight(kToolbarHeight),

        /// 앱바 생성시 SafeArea로 감싸면, 앱바는 물론 앱바가 사라진 다음 body 부분도,
        /// 상단 상태창으로 올라가지 않음.
        child: SafeArea(
          /// AnimatedCrossFade 위젯은 두개의 위젯을 조건에 따라 표시해주는 역할을 함.
          child: AnimatedCrossFade(
            firstChild: AppBar(
              title: const Text('Animation AppBar'),

              /// leading 부분을 사용하지 않아도 기본적으로 뒤로가기 아이콘은 생성되지만,
              /// 아이콘이나 기능을 바꾸기 위해서 사용한다.
              /// 아이콘 변경 시 기본 기능인 뒤로가기 기능도 자체적으로 구현해야 함.
              leading: Builder(
                builder: (context) => IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded)),
              ),
            ),

            /// 부모가 허용한 크기만큼 공간을 만듬(기본값: w=h=0, 따라서 없어짐)
            secondChild: const SizedBox.shrink(),
            crossFadeState: _isShowAppBar
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,

            /// 애니메이션 변경 시간
            duration: const Duration(milliseconds: 500),
          ),
        ),
      );

  /// 분리된 리스트뷰 생성
  /// 일반적인 리스트뷰는 하위 위젯을 [children]을 이용해 생성하지만
  /// separated 리스트뷰는 하위 위젯과 분리선을 만드는 빌더를 제공함.
  Widget _body() => ListView.separated(
        controller: _sc,
        itemBuilder: (context, index) => Container(
          height: 50,
          color: index.isOdd ? Colors.white : Colors.blue[100],
          child: Center(
            child: Text(index.toString()),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
        itemCount: 100,
      );
}

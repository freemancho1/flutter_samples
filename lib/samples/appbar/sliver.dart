import 'package:flutter/material.dart';
import 'package:flutter_samples/system/config.dart';

class FreeSliverAppBar extends StatefulWidget {
  const FreeSliverAppBar({Key? key}) : super(key: key);

  @override
  State<FreeSliverAppBar> createState() => _SliverAppBarState();
}

class _SliverAppBarState extends State<FreeSliverAppBar> {
  bool _pinned = true;
  bool _snap = true;
  bool _floating = true;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: CustomScrollView(
      slivers: [
        /// AppBar 영역
        SliverAppBar(
          /// 앱바가 작아지면 아래 FlexibleSpaceBar의 title과 겹침(상단 고정)
          /// title: const Text('Title'),
          expandedHeight: SystemCfg.appBarExpandedHeight,
          flexibleSpace: FlexibleSpaceBar(
            /// 확장된 앱바의 타이틀(축소 시에도 앱바의 제목으로 유지됨)
            title: const Text('Sliver AppBar'),
            /// 확장된 앱바의 제목 크기(축소 시와 비교했을 때의 배율)
            expandedTitleScale: 2,
            /// centerTitle: true,
            /// titlePadding: const EdgeInsets.only(left: 0, bottom: 0),
            /// 확장된 앱바의 바탕에 적용될 위젯
            /// (일반적으로 Stack을 이용해 여러 겹으로 생성함)
            background: Stack(
              children: [
                Positioned.fill(child: Image.network(
                  'https://www.kdn.com/korean/img/main_renew/img_main_section01_01.jpg',
                  fit: BoxFit.cover,
                )),
                Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('AAA'), Text('BBB'), Text('CCC'),
                  ],
                )),
              ],
            ),
          ),
          /// 앱바가 고정되는지 여부(기본값 false, 경우에 따라 살아짐)
          pinned: _pinned,
          /// 중간 크기의 앱바 표시 여부(기본값 false, 끈기는 듯한 애니매이션)
          snap: _snap,
          /// 자연스러운 애니매이션 효과(기본값 false, true가 더 자연스러움)
          floating: _floating,
        ),
        /// 확장된 앱바 이하 화면 아래까지의 영역을 그리는 위젯
        /// SliverFillRemaining(
        ///     child: LayoutBuilder(
        ///         builder: (context, constraints) {
        ///             bool isMinimized =
        ///                 constraints.biggest.height == kToolbarHeight +
        ///                     (MediaQuery.of(context).padding.top);
        ///             return Center(
        ///                 child: Text(
        ///                     isMinimized ? 'Minimized' : 'Not Minimized'
        ///                 ),
        ///             );
        ///         },
        ///     ),
        /// ),
        /// Body 영역(단일 바디 부분)
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 30,
            child: Center(
              child: Text('SliverToBoxAdapter'),
            )
          ),
        ),
        /// Body 영역(리스트 형태)
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Container(
              height: 80,
              color: index.isOdd ? Colors.white : Colors.blueGrey[50],
              child: Center(
                child: Text(index.toString(), textScaleFactor: 3,),
              ),
            ),
            childCount: 100,
          ),
        )
      ],
    ),
    /// 여기는 스크롤 영역이 아니고, Scaffold 영역의 가장 하단(위 body와 형제간)
    bottomNavigationBar: BottomAppBar(
      /// 하위 위젯의 갯 수가 많아 한 화면에 다 나오지 않을 경우 스크롤을 만듬.
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        scrollDirection: Axis.horizontal,
        child: OverflowBar(
          /// 아이템 간격
          spacing: 8,
          /// overflow icon의 위치
          overflowAlignment: OverflowBarAlignment.end,
          /// overflow icon과 메뉴 사이의 간격
          overflowSpacing: 16,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              /// 다 표시하면 옆으로 스크롤 됨.
              children: [
                // _makeSwitchWidget('pinned'),
                // _makeSwitchWidget('pinned'),
                // _makeSwitchWidget('pinned'),
                _makeSwitchWidget('pinned'),
                _makeSwitchWidget('snap'),
                _makeSwitchWidget('floating'),
              ],
            )
          ],
        ),
      ),
    ),
  );

  Widget _makeSwitchWidget(String name) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(name),
      Switch(
        value: (name == 'pinned') ? _pinned :
               (name == 'snap') ? _snap : _floating,
        onChanged: (value) {
          setState(() {
            if (name == 'pinned') {
              _pinned = value;
            } else if (name == 'snap') {
              _snap = value;
              if (value) {
                _floating = value;
              }
            } else {
              _floating = value;
              if (!value) {
                _snap = value;
              }
            }
          });
        },
      )
    ],
  );
}

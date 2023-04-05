import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_samples/samples/basic/animations/animated_container.dart';
import 'package:flutter_samples/samples/basic/animations/page_route_builder.dart';
import 'package:flutter_samples/samples/database/hive/contacts/contacts_app.dart';
import 'package:flutter_samples/samples/database/hive/etc/counter.dart';
import 'package:flutter_samples/samples/database/hive/etc/favorite_book.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/sketch_pad.dart';
import 'package:flutter_samples/samples/product/calculator/calculator_app.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_samples/samples/basic/appbar/animation.dart';
import 'package:flutter_samples/samples/basic/appbar/sliver.dart';
import 'package:flutter_samples/samples/database/hive/todo/todo_app.dart';

import 'package:flutter_samples/samples/utils/geo/get_position/get_location.dart';

class MenuItem {
  final String title;
  final String description;
  final List<String> subTitles;
  final String routeName;
  final WidgetBuilder builder;

  const MenuItem(
      {required this.title,
      required this.description,
      required this.subTitles,
      required this.routeName,
      required this.builder});
}

class MenuGroup {
  final String title;
  final String subTitle;
  final Icon icon;
  final List<MenuItem> menuItems;

  const MenuGroup({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.menuItems,
  });
}

final List<MenuGroup> menus = [
  MenuGroup(
    title: 'AppBar',
    subTitle: '숨김 애니메이션, 펼치기, 앞/뒤 아이콘 처리 등을 확인할 수 있음.',
    icon: const Icon(Icons.add_alert_rounded),
    menuItems: [
      MenuItem(
        title: '숨김 애니메이션 적용 앱바',
        description: '리스트의 위치와 상관없이 단순히 상하 움직임만을 감지해 '
            '앱바를 숨기거나 표시하는 애니메이션으로 구현',
        subTitles: [
          'ScrollController을 이용해 리스트뷰의 이동방향을 체크',
          'PreferredSize 위젯을 이용한 AppBar 구현 함수',
          'AnimatedCrossFade 사용법',
          'ListView.separated()의 빌더를 이용해 아이템과 분리자를 만드는 방법',
          'leading 부분 아이콘 및 액션 변경하는 방법',
        ],
        routeName: 'appbar/animation',
        builder: (context) => const AnimationAppBar(),
      ),
      MenuItem(
        title: '확장 앱바',
        description: '앱바를 CustomScrollView안에 넣어 처음에 크게 보이게 하다 '
            '바디에 있는 리스트의 스크롤에 따라 작아지거나 없어질 수 있는 앱바.',
        subTitles: [
          'CustomScrollView 안에서 아래 위젯을 구현하는 방법 확인',
          '- SliverAppBar와 FlexibleSpaceBar 구현',
          '- SliverFillRemaining(앱바 이하부분 전체 구현)',
          '- SliverToBaxAdapter(바디 단일 박스 영역)',
          '- SliverList(바디 리스트 영역)',
          'BottomAppBar로 구현한 bottomNavigationBar',
          '- SingleChildScrollView와 OverflowBar'
        ],
        routeName: 'appbar/sliver',
        builder: (context) => const FreeSliverAppBar(),
      ),
    ]
  ),
  MenuGroup(
      title: 'Animations',
      subTitle: '다양한 애니메이션 효과를 확인할 수 있음.',
      icon: const Icon(MdiIcons.animationPlay),
      menuItems: [
        MenuItem(
          title: '컨테이너 박스 애니메이션',
          description: '버튼을 클릭하면 박스의 이미지가 변하는 애니메이션 구현',
          subTitles: [
            'Random 색상 만들기',
            'AnimatedContainer 사용법',
          ],
          routeName: 'animation/animated_container',
          builder: (context) => const AnimatedContainerApp(),
        ),
        MenuItem(
          title: '페이지 이동 애니메이션',
          description: '위/아래로 이동하는 애니메이션으로 페이지 이동',
          subTitles: [
            'PageRouteBuilder<SlideTransition>',
            'Tween',
            'CurveTween',
          ],
          routeName: 'animation/page_route_builder',
          builder: (context) => const PageRouteBuilderApp(),
        ),
      ]
  ),
  MenuGroup(
    title: 'Hive',
    subTitle: 'Todo, Contacts, Counter & Favorite book 등',
    icon: const Icon(MdiIcons.databaseSync),
    menuItems: [
      MenuItem(
        title: '카운터',
        description: '증가 또는 감소되는 값을 프로그램에서 직접 표시하는 방식이 아닌, '
            '이를 하이브에 저장한 후 하이브의 변화를 감지해 변화가 생기면 값을 표시함',
        subTitles: [
          '하이브 초기화',
          '메인에서 오픈된 박스를 별칭으로 사용',
          'ValueListenableBuilder를 이용해 하이브 테이블 상태변화 체크',
          '테이블 읽어고 수정하는 방법(단, 조건은 없음)',
          'FloatingActionButton 2개 사용',
          'Material Design Icons 사용법',
        ],
        routeName: 'hive/etc/counter',
        builder: (context) => const Counter(),
      ),
      MenuItem(
        title: '좋아하는 책 선택',
        description: '책 리스트에서 좋아하는 책에 하트를 주는 간단한 앱이지만, '
            '데이터를 파일에 저장하거나 파일에 저장된 데이터를 복구하는 기능 json '
            '형식으로 구현되어 있음.',
        subTitles: [
          'AppBar actions 사용법',
          'ValueListenableBuilder를 이용해 하이브 테이블 상태변화 체크',
          'containsKey를 이용해 하이브 DB 값 확인',
          'ScaffoldMessenger를 이용한 SnackBar 구현',
          '하이브 데이터를 toMap()을 이용해 Map<K,V> 데이터 만들기',
          '파일 처리를 위한 AndroidManifest.xml에 권한 주기',
          'Map<K,V> 데이터를 json으로 변환하고 이를 파일로 저장',
          '하이브 DB를 모두 지우기',
          '파일을 Map<K,V>형 json으로 읽기',
          '여러 레코드의 데이터를 하이브에 일괄 저장'
        ],
        routeName: 'hive/etc/favorite_book',
        builder: (context) => const FavoriteBook(),
      ),
      MenuItem(
        title: '할일 목록',
        description: '간단한 할일 목록 관리 프로그램으로 하이브 관련 다양한 내용을 '
            '제공함',
        subTitles: [
          '하이브 초기화 및 아답터 등록',
          'hive_generator와 build_runner를 이용해 테이블 생성',
          '상태정보 저장 및 테이블 저장/수정',
          'ValueListenableBuilder를 이용해 하이브 테이블 상태변화 체크',
          '테이블을 리스트로 변경해서 관'
          '테이블 읽어고 삭제하는 방법(단, 조건은 없음)',
          '다이얼로그 생성',
          '카드 위젯과 카드 리스트 생성',
          '간단한 데이터 입력 폼 처리',
          'Material Design Icons 사용법',
        ],
        routeName: 'hive/todos',
        builder: (context) => const TodoApp(),
      ),
      MenuItem(
        title: '연락처',
        description: '다양한 형태의 입력 폼을 활용해 연락처를 관리하는 앱',
        subTitles: [
          'enum 형태의 데이터를 하이브 테이블로 생성',
          '테이블을 리스트뷰 빌더를 이용해 관리',
          'InkWel(GestureDetector와 유사) 사용',
          'async 함수에서 context를 사용할 때 발생하는 경고 제공',
          'GlobalKey를 이용해 폼 제어',
          '다양한 형태의 입력 폼',
          'enum 데이터를 활용한 드롭다운 버튼 만들기',
          '폼 submit',
        ],
        routeName: 'hive/contacts',
        builder: (context) => const ContactsApp(),
      ),
      MenuItem(
        title: '미니 그림판',
        description: '5가지 색상을 선택해 선을 그릴 수 있도록 하는 간단한 그림판.',
        subTitles: [
          '사용자정의 하이브 아답터 생성',
          'GestureDetector의 다양한 옵션 소개',
          'ClipOval - 모든 위젯을 원형으로 변환',
          '하이브 데이터 상태를 모니터링해 아이콘 활성/비활성',
        ],
        routeName: 'hive/sketch_pad',
        builder: (context) => const SketchPad(),
      ),
    ]
  ),
  MenuGroup(
    title: 'Geo Data',
    subTitle: '현재 위치정보 가져오기 등 다양한 지리정보 처리 관련 내용이 포함된다.',
    icon: const Icon(MdiIcons.mapMarkerRadius),
    menuItems: [
      MenuItem(
        title: '현재 위치정보 가져오기',
        description: '간단히 현재 위치정보를 읽어 옴',
        subTitles: [
          'Geo 데이터를 처리하기 위한 권한 획득',
          'FutureBuilder를 이용한 Future<T> 리턴함수 상태 모니터링',
          'desiredAccuracy 인수 옵션 설명',
        ],
        routeName: 'utils/geo/get_position',
        builder: (context) => const GeoLocation(),
      ),
    ]
  ),
  MenuGroup(
      title: 'Products',
      subTitle: '꽤 쓸만한 앱',
      icon: const Icon(MdiIcons.packageVariantClosed),
      menuItems: [
        MenuItem(
          title: '계산기',
          description: '공학용 전자 계산',
          subTitles: [
            'ConsumerWidget',
            'LayoutGrid',
            'NamedAreaGridPlacement',
            'AutoSizeText',
            'ElevatedButton vs OutlinedButton',
            'StateNotifier',
            'Parser & evaluate',
            'object.copyWith',
            'ProviderScope'
          ],
          routeName: 'product/calculator',
          builder: (context) => const ProviderScope(child: CalculatorApp()),
        ),
      ]
  ),
];

import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/etc/counter.dart';
import 'package:flutter_samples/samples/database/hive/etc/favorite_book.dart';
import 'package:flutter_samples/samples/database/hive/sketchpad/sketch_pad.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_samples/samples/appbar/animation.dart';
import 'package:flutter_samples/samples/appbar/sliver.dart';
import 'package:flutter_samples/samples/database/hive/todo/todo_app.dart';

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
      ]),
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
      ]),
];

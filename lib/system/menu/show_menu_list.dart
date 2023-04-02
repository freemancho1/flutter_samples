import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_samples/system/config.dart';
import 'package:flutter_samples/system/menu/menu.dart';
import 'package:flutter_samples/system/menu/menu_config.dart';

class ShowMenuList extends StatelessWidget {
  const ShowMenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar(
        pinned: true,
        snap: true,
        floating: true,
        expandedHeight: SystemCfg.appBarExpandedHeight,
        flexibleSpace: FlexibleSpaceBar(
          title: const Text('Flutter Samples'),
          centerTitle: true,
          expandedTitleScale: 1.5,
          background: Image.asset(
            'assets/samples.jpg',
            fit: BoxFit.fill,
          ),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _MakeMenuGroup(menuGroup: menus[index]),
          childCount: menus.length,
        ),
      )
    ],
  );

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //   appBar: AppBar(
  //     title: const Text('Flutter Samples'),
  //   ),
  //   body: ListView(
  /// children 사용 예: .map() 함수 사용.
  //     children: [
  //       ...menus.map((menu) => _MakeMenuGroup(menuGroup: menu)),
  //     ],
  //   ),
  // );
}

class _MakeMenuGroup extends StatelessWidget {
  final MenuGroup menuGroup;
  const _MakeMenuGroup({required this.menuGroup});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top:8, left: 8, right: 8),
    child: ExpansionTile(
      title: Text(menuGroup.title, style: MenuCfg.groupTitleStyle,),
      subtitle: Text(menuGroup.subTitle, style: MenuCfg.groupSubTitleStyle,),
      /// 펼쳐졌을 때 텍스트 색상
      textColor: MenuCfg.activeTextColor,
      /// 접혔을 때 텍스트와 아이콘의 색상
      collapsedTextColor: MenuCfg.textColor,
      collapsedIconColor: MenuCfg.textColor,
      leading: menuGroup.icon,
      /// 뒤쪽 아이콘 변경
      /// (변경시 해당 타일이 접혔거나 펼쳐졌는지 확인해서 변경해줄 필요가 있는데,
      /// 현재 그 상태를 체크하는 법을 모름)
      /// trailing: const Icon(Icons.radio_button_checked),
      /// 최초 펼침 여부
      initiallyExpanded: MenuCfg.groupInitExpanded,
      backgroundColor: MenuCfg.groupBgColor,
      collapsedBackgroundColor: MenuCfg.groupBgColor,
      children: [
        ...menuGroup.menuItems.map((item) => _MakeMenuItem(menuItem: item)),
        const SizedBox(height: 15,),
      ],
    ),
  );
}

class _MakeMenuItem extends StatelessWidget {
  final MenuItem menuItem;
  const _MakeMenuItem({required this.menuItem});

  @override
  Widget build(BuildContext context) {
    int subTitleNumber = 1;
    return Container(
      width: MenuCfg.itemWidth,
      /// decoration을 이용하지 않을 경우 SizedBox를 이용하는 것을 추천함.
      decoration: const BoxDecoration(
        /// color: Colors.blue,
        /// border: Border(
        ///     top: BorderSide(width: 1, color: Colors.grey),
        ///     bottom: BorderSide(width: 1, color: Colors.grey)
        /// )
      ),
      child: Padding(
        padding: MenuCfg.itemPadding,
        child: ListTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(menuItem.title, style: MenuCfg.itemTitleStyle,),
              Text(
                menuItem.description,
                style: MenuCfg.itemSubTitleStyle2,
                maxLines: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...menuItem.subTitles.map((subTitle) => Text(
                      '${subTitleNumber++}. $subTitle',
                      style: MenuCfg.itemSubTitleStyle2,
                      maxLines: 1,
                    )),
                  ],
                ),
              ),
            ],
          ),
          onTap: () => context.go('/${menuItem.routeName}'),
        ),
      ),
    );
  }
}



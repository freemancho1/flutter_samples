import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_samples/samples/database/hive/todo/todo.dart';
import 'package:flutter_samples/samples/database/hive/hive_config.dart';

import 'package:flutter_samples/system/utils/animation.dart';
import 'package:flutter_samples/system/utils/text.dart';
import 'package:flutter_samples/system/menu/menu.dart';
import 'package:flutter_samples/system/menu/show_menu_list.dart';

void main() async {
  await Hive.initFlutter();

  /// 하이브 테이블아답터 등록
  Hive.registerAdapter(TodoAdapter());

  runApp(const FlutterSamples());
}

class FlutterSamples extends StatelessWidget {
  const FlutterSamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Flutter Samples',
    theme: ThemeData(primarySwatch: Colors.deepOrange),
    /// 하이브를 사용할 경우, main()에서 아답터 등록하고,
    /// 메인 MaterialApp에서 테이블을 다 오픈해 주는 것이 좋음
    /// 이 앱에서는 HomePage가 메인에 해당하기 때문에 그곳에서 진행함.
    routerConfig: flutterSampleRouters,
    debugShowCheckedModeBanner: false,
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: FutureBuilder(
      future: Future.wait([
        Hive.openBox(HiveCfg.tableTodoSettingsName),
        Hive.openBox<Todo>(HiveCfg.tableTodoName),
        Hive.openBox<int>(HiveCfg.tableCounterName),
      ]),
      builder: (context, snapshot) =>
        (snapshot.error != null)
          ? const MakeLoadingMessage(message: 'Hive error...')
          : (snapshot.connectionState == ConnectionState.done)
            ? const ShowMenuList()
            : const MakeLoadingIcon(message: 'Opening Hive DB...'),
    ),
  );
}

final flutterSampleRouters = GoRouter(
  routes: [ GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
    routes: [
      for (MenuGroup group in menus)
        for (MenuItem item in group.menuItems)
          GoRoute(
            path: item.routeName,
            builder: (context, state) => item.builder(context)
          ),
    ]
  )]
);

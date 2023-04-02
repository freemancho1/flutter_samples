import 'package:hive/hive.dart';

import '../hive_config.dart';

/// '파일명.g.dart'는 hive_generator와 build_runner을 이용해 만드는 파일로,
/// 아래 명령을 pubspec.yaml 파일이 있는 디렉토리(일반적으로 루트)에서 실행하면 됨.
/// flutter packages pub run build_runner build
/// 이렇게 하면 아답터와 읽고 쓰는 함수 등을 자동으로 만들어 줌.
part 'todo.g.dart';

@HiveType(typeId: HiveCfg.tableTodoId)
class Todo extends HiveObject {

  @HiveField(0)
  late String title;

  @HiveField(1)
  late DateTime created;

  @HiveField(2)
  bool done = false;

}
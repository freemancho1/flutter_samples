import 'package:hive_flutter/hive_flutter.dart';

import '../hive_config.dart';

part 'todo.g.dart';

@HiveType(typeId: HiveCfg.tableTodoId)
class Todo extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime created;
  @HiveField(2)
  bool done = false;
}
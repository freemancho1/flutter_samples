class HiveCfg {
  /// 하이브에서 테이블이 여러개인 경우, 이 처럼 한곳에서 테이블 ID를 관리하는 것을 추천함.
  static const tableTodoId = 0;
  static const tableTodoName = 'todos';
  static const tableTodoSettingsName = 'todo_settings';
}

/// 아래 enum은 사용하지 않지만, 사용법의 좋은 예이니 남겨둠.
enum HiveTable {
  todo(1, 'todos'),
  todoSettings(0, 'todo_settings');

  /// hiveId = 0은, 테이블을 만들지 않고, box만 만드는 형테로
  /// 다양한 형태의 데이터를 Map<K, V>형식으로 입력할 수 있다.
  final int hiveId;
  final String boxName;
  const HiveTable(this.hiveId, this.boxName);
  /// 사용법
  /// HiveTable.todo.hiveId
}
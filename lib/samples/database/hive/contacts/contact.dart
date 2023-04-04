import 'package:hive_flutter/hive_flutter.dart';

import '../hive_config.dart';

/// '파일명.g.dart'는 hive_generator와 build_runner을 이용해 만드는 파일로,
/// 아래 명령을 pubspec.yaml 파일이 있는 디렉토리(일반적으로 루트)에서 실행하면 됨.
/// flutter packages pub run build_runner build
/// 이렇게 하면 아답터와 읽고 쓰는 함수 등을 자동으로 만들어 줌.
part 'contact.g.dart';

@HiveType(typeId: HiveCfg.tableRelationshipId)
enum Relationship {
  @HiveField(0)
  family,
  @HiveField(1)
  friend,
}

@HiveType(typeId: HiveCfg.tableContactId)
class Contact {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int age;

  @HiveField(2)
  late Relationship relationship;

  @HiveField(3)
  late String phoneNumber;

  Contact(this.name, this.age, this.phoneNumber, this.relationship);
}

const Map<Relationship, String> relationships = {
  Relationship.family: 'Family',
  Relationship.friend: 'Friend',
};
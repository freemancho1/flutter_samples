import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/contacts/contact.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../hive_config.dart';

class ContactList extends StatelessWidget {
  ContactList({Key? key}) : super(key: key);
  final Box<Contact> contactBox = Hive.box<Contact>(HiveCfg.tableContactName);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
    valueListenable: contactBox.listenable(),
    builder: (context, box, _) => (box.values.isEmpty)
      ? const Center(child: Text('No Contacts'),)
      : _MakeContactList(box: box)
  );
}

class _MakeContactList extends StatelessWidget {
  final Box<Contact> box;
  const _MakeContactList({required this.box});

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: box.length,
    itemBuilder: (context, index) {
      Contact contact = box.getAt(index)!;
      /// String relationship = contact.relationship!;
      /// 위와같이 하면 문자값이 아닌 'Relationship.family' 등이 오며,
      /// 이는 문자열이 아니기 때문에 오류가 발생함.
      String relationship = relationships[contact.relationship]!;
      /// GestureDetector보다는 기능이 더 없지만,
      /// InkWell은 제스쳐를 받으면서, 기본적인 애니메이션 효과가 있다.
      return InkWell(
        onLongPress: () => showDialog(
          context: context,
          /// 다이알로그 외부를 터치했을 때, 다이알로그가 닫히는지 여부
          /// true - 닫힘, false - 닫히지 않음(모달)
          barrierDismissible: true,
          builder: (_) => AlertDialog(
            content: Text('"${contact.name}" 연락처를 삭제하시겠습니까?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('No')
              ),
              TextButton(
                /// DB에서 값을 삭제해야하기 때문에 끝날때 까지 대기
                onPressed: () {
                  /// async 함수를 별도로 만들어 실행함
                  /// 그럼 아래 context는 async에 영향을 받지 않음.
                  _deleteContact(index);
                  /// 아래와 같이 async 함수에서 context를 사용하면,
                  /// 메모리 누수등이 날 수 있어 경고를 보낸다.
                  Navigator.of(context).pop();
                },
                child: const Text('Delete'),
              )
            ],
          )
        ),
        hoverColor: Colors.orange,
        /// 액션에 반응할때 색상이 변함,
        /// 안에있는 카드가 변경되는것이 아니기 때문에 card의 패딩에만 적용됨
        highlightColor: Colors.green,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDivider(),
                Text(contact.name),
                _buildDivider(),
                Text(contact.phoneNumber),
                _buildDivider(),
                Text('Age: ${contact.age}'),
                _buildDivider(),
                Text('Relationship: $relationship'),
                _buildDivider(),
              ],
            ),
          ),
        ),
      );
    },
  );

  /// 이렇게 해도 정상적으로 처리가 되지만(되는것 처럼 보이지만),
  /// 정상적인 처리를 위해서는 아래와 같이 하길 추천함
  /// 정확하게 보면 아래 deleteAt 함수에 키보드를 올려리면
  /// Future<T> 형식의 리턴값을 보내면 다 await를 사용해야 함
  /// void _deleteContact(int index) {
  ///   box.deleteAt(index);
  /// }
  ///
  /// 아래 함수의 경우는
  /// _deleteContact 자체는 void를 리턴하기 때문에 호출 시 await를
  /// 사용하지 않지만 함수에서 수행되는 함수 중
  /// deleteAt이 Future<void>형을 리턴하기 때문에 async ~ await를
  /// 사용해야 함.
  void _deleteContact(int index) async {
    await box.deleteAt(index);
  }

  Widget _buildDivider() => const SizedBox(height: 5,);
}

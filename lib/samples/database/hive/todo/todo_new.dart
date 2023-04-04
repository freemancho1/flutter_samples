import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/hive_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'todo.dart';

class TodoNewDialog extends StatefulWidget {
  const TodoNewDialog({Key? key}) : super(key: key);

  @override
  State<TodoNewDialog> createState() => _TodoNewDialogState();
}

class _TodoNewDialogState extends State<TodoNewDialog> {
  final TextEditingController _tc = TextEditingController();

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('New Todo'),
        content: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: TextField(
            controller: _tc,
            decoration: const InputDecoration(
                icon: Icon(Icons.today),
                border: UnderlineInputBorder(),
                hintText: 'Enter a New Task'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_tc.text.isNotEmpty) {
                Todo todo = Todo()
                  ..name = _tc.text
                  ..created = DateTime.now();

                /// 신규생성: .add()
                /// 업데이트: .save()
                Hive.box<Todo>(HiveCfg.tableTodoName).add(todo);
              }

              /// 상위 컨텍스트에서 해당 위젯을 제거함.
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      );
}

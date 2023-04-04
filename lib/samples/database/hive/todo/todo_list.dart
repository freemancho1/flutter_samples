import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/todo/config.dart';
import 'package:flutter_samples/samples/database/hive/todo/todo.dart';
import 'package:flutter_samples/system/utils/text.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  const TodoList({Key? key, required this.todos}) : super(key: key);

  @override
  Widget build(BuildContext context) => (todos.isEmpty)
      ? const MakeLoadingMessage(message: 'Nothing todo, Great!!')

      /// 일반 리스트뷰를 이용하는 경우
      : ListView(
          children: [...todos.map((todo) => _MakeTodo(todo: todo))],
        );

  /// ListView.builder를 이용하는 경우
  /// ListView.builder(
  ///   itemCount: todos.length,
  ///   itemBuilder: (context, index) => _MakeTodo(todo: todos[index])
  /// )
}

class _MakeTodo extends StatelessWidget {
  final Todo todo;
  const _MakeTodo({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        /// Card 전체 배경화면
        /// color: Colors.orange,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8, right: 0),
          child: Row(
            children: [_textWidget(), _actionWidget(context)],
          ),
        ),
      );

  Widget _textWidget() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.name,
              style: TodoCfg.titleStyle(todo.done),
            ),
            Text(
              TodoCfg.dateFormat.format(todo.created),
              style: TodoCfg.dateTimeStyle,
            )
          ],
        ),
      );

  Widget _actionWidget(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(todo.done ? Icons.clear : Icons.check),
            color: Colors.orange,
            iconSize: 16,
            onPressed: () {
              todo.done = !todo.done;
              todo.save();
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            color: Colors.orange,
            iconSize: 16,
            onPressed: () => showDialog(
              context: context,
              builder: (context) => _DeleteAlertDialog(todo: todo),
            ),
          )
        ],
      );
}

class _DeleteAlertDialog extends StatelessWidget {
  final Todo todo;
  const _DeleteAlertDialog({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Delete'),
        content: const Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: Text('Are you sure delete it?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              todo.delete();
              Navigator.of(context).pop();
            },
            child: const Text('Ok'),
          )
        ],
      );
}

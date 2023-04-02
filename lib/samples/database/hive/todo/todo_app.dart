import 'package:flutter/material.dart';
import 'package:flutter_samples/samples/database/hive/todo/todo.dart';
import 'package:flutter_samples/samples/database/hive/todo/todo_list.dart';
import 'package:flutter_samples/samples/database/hive/todo/todo_new.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_samples/samples/database/hive/hive_config.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  late bool reversed;

  @override
  void initState() {
    super.initState();
    reversed = Hive.box(HiveCfg.tableTodoSettingsName)
      .get('reversed', defaultValue: true) as bool;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: _appBar(),
    body: _body(),
    floatingActionButton: _floatingActionButton(),
  );

  AppBar _appBar() => AppBar(
    title: const Text('Todos', style: TextStyle(color: Colors.white),),
    /// 뒤쪽 아이콘
    actions: [
      IconButton(
        icon: Icon(
          reversed ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
          size: 32,
          color: Colors.amberAccent,
        ),
        onPressed: () {
          setState(() {
            reversed = !reversed;
            Hive.box(HiveCfg.tableTodoSettingsName)
                .put('reversed', reversed);
          });
        },
      )
    ],
  );

  Widget _body() => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8,),
          Expanded(
            child: ValueListenableBuilder<Box<Todo>>(
              valueListenable:
                Hive.box<Todo>(HiveCfg.tableTodoName).listenable(),
              builder: (context, boxTodos, _) {
                List<Todo> todos = boxTodos.values.toList().cast<Todo>();
                if (reversed) {
                  todos = todos.reversed.toList();
                }
                return TodoList(todos: todos);
              },
            ),
          )
        ],
      ),
    ),
  );

  Widget _floatingActionButton() => FloatingActionButton(
    onPressed: () => showDialog(
        context: context,
        builder: (context) => const TodoNewDialog()
    ),
    child: const Icon(Icons.add),
  );
}

import 'package:flutter/material.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  TodoList({Key key, this.items}) : super(key: key);

  final List<TodoItem> items;

  @override
  Widget build(BuildContext context) => Center(
            child: Column(children: items)
          );
}

  

import 'package:flutter/material.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
          child: ListView(
        children: <Widget>[TodoItem(), TodoItem()],
      ));
}

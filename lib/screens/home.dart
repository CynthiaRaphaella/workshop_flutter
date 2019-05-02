import 'package:flutter/material.dart';
import 'package:workshop_flutter/widgets/todo_item.dart';
import 'package:workshop_flutter/widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  final List<TodoItem> items = new List(); 
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("To do!")),
        body: TodoList(items: widget.items),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() { widget.items.add(new TodoItem()); }),
          child: Icon(Icons.add),
        ),
      );
}

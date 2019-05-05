import 'package:flutter/material.dart';
import 'package:workshop_flutter/data/item.dart';
import 'package:workshop_flutter/screens/new_todo.dart';
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
          onPressed: () => _createNewTodo(),
          child: Icon(Icons.add),
        ),
      );

    _createNewTodo() async {
      final result = await Navigator.of(context).push(
                new MaterialPageRoute(builder: (context) => new NewTodo())
              );
      setState(() {
        widget.items.add(new TodoItem(item: result, callback: _toggleTodo));
      });
  }

  _toggleTodo(Item todo, bool isChecked) {
    setState(() {
      todo.state = isChecked;
    });
  }
}

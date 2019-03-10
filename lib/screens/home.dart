import 'package:flutter/material.dart';
import 'package:workshop_flutter/widgets/todo_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("To do!")),
        body: TodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () => print('New todo'),
          child: Icon(Icons.add),
        ),
      );
}

import 'package:flutter/material.dart';
import 'package:workshop_flutter/data/item.dart';
import 'package:workshop_flutter/screens/new_todo.dart';
import 'package:workshop_flutter/widgets/todo_list.dart';
import 'package:workshop_flutter/data/item_repository.dart';

class HomeScreen extends StatelessWidget {
  final ItemRepository itemRepository;

  HomeScreen({this.itemRepository});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("To do!")),
        body: TodoList(itemRepository: itemRepository),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _createNewTodo(context),
          child: Icon(Icons.add),
        ),
      );

  _createNewTodo(BuildContext context) async {
    final Item result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context) => new NewTodo()));
    if (result != null) {
      await itemRepository.create(result);
    }
  }
}

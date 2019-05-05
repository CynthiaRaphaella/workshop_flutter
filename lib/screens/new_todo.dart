import 'package:flutter/material.dart';
import 'package:workshop_flutter/data/item.dart';


class NewTodo extends StatelessWidget {
  final controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create todo'),
      content: TextField(
        controller: controller,
        autofocus: true
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text('Add', key: new Key("Add")),
          onPressed: () {
            final todo = new Item(description: controller.value.text);
            controller.clear();

            Navigator.of(context).pop(todo);
          },
        ),
      ],
    );
  }
}
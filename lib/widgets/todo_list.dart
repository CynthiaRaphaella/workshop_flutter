import 'package:flutter/material.dart';
import 'package:workshop_flutter/data/item.dart';
import 'package:workshop_flutter/data/item_repository.dart';
import 'todo_item.dart';

class TodoList extends StatelessWidget {
  final ItemRepository itemRepository;

  TodoList({this.itemRepository});

  @override
  Widget build(BuildContext context) => StreamBuilder<List<Item>>(
        stream: itemRepository.read(),
        builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              return ListView(
                  children: snapshot.data
                      .map((item) =>
                          TodoItem(itemRepository: itemRepository, item: item))
                      .toList());
          }
        },
      );
}

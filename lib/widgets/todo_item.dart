import 'package:flutter/material.dart';
import 'package:workshop_flutter/data/item.dart';
import 'package:workshop_flutter/data/item_repository.dart';

class TodoItem extends StatelessWidget {
  final Item item;
  final ItemRepository itemRepository;

  TodoItem({this.itemRepository, this.item});

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: item.state ? 0.5 : 1.0,
        child: Card(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (v) => _changeCheckBox(v),
                value: item.state,
              ),
              Text(item.description,
                  style: TextStyle(
                      fontStyle:
                          item.state ? FontStyle.italic : FontStyle.normal))
            ],
          ),
        ),
      );

  _changeCheckBox(bool newValue) {
    item.state = newValue;
    itemRepository.update(item);
  }
}

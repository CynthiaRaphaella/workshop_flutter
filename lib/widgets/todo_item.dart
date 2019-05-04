import 'package:flutter/material.dart';
import 'package:workshop_flutter/data/item.dart';

class TodoItem extends StatefulWidget {
  final Item item;
  final void Function(Item, bool) callback;
  const TodoItem({Key key, this.item, this.callback}) : super(key: key);
  @override
  State<StatefulWidget> createState() => TodoItemState();
}

class TodoItemState extends State<TodoItem> {
  final int _animationDuration = 500;
  double _opacityLevel = 1.0;
  FontStyle _fontStyle = FontStyle.normal;

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        duration: Duration(milliseconds: _animationDuration),
        opacity: _opacityLevel,
        child: Card(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (v) => _changeCheckBox(v),
                value: widget.item.state,
              ),
              Text(
                widget.item.description,
                style: TextStyle(fontStyle: _fontStyle),
              )
            ],
          ),
        ),
      );

  _changeCheckBox(bool newValue) {
    setState(() {
      widget.callback(widget.item, newValue);
      _changeFontStyle();
      _changeOpacity();
    });
  }

  _changeOpacity() {
    setState(() => _opacityLevel = _opacityLevel == 0.5 ? 1.0 : 0.5);
  }

  _changeFontStyle() {
    setState(() => _fontStyle =
        _fontStyle == FontStyle.normal ? FontStyle.italic : FontStyle.normal);
  }
}
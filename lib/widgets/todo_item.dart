import 'package:flutter/material.dart';
import 'package:workshop_flutter/data/item.dart';

class TodoItem extends StatefulWidget {
  final Item item;
  const TodoItem({Key key, this.item}) : super(key: key);
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
      widget.item.state = newValue;
      _changeFontStyle();
      _changeOpacity();
    });
  }

  _changeOpacity() {
    _opacityLevel = _opacityLevel == 0.5 ? 1.0 : 0.5;
  }

  _changeFontStyle() {
    _fontStyle = _fontStyle == FontStyle.normal ? FontStyle.italic : FontStyle.normal;
  }
}
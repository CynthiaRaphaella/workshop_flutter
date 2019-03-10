import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
          child: Row(
            children: <Widget>[
              Checkbox(
                onChanged: (value) => print(value),
                value: true,
              ),
              Text(
                'Texto',
              )
            ],
          )
    );
}
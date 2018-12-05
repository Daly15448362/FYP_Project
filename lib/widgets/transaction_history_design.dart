import 'package:flutter/material.dart';
import 'package:fyp_project/headings/label.dart';

class TransactionDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            child: new Divider(
              color: Colors.grey,
            )),
        new Padding(
          padding: const EdgeInsets.all(6.0),
          child: new Text(labels
              .of(context)
              .history),
        ),
        new Expanded(
            child: new Divider(
              color: Colors.grey,
            )),
      ],
    );
  }
}
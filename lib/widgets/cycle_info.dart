import 'package:flutter/material.dart';
import 'package:fyp_project/headings/label.dart';

class NewCycleInfo extends StatefulWidget {
  @override
  _NewCycleInfoState createState() => new _NewCycleInfoState();
}

class _NewCycleInfoState extends State<NewCycleInfo> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text(labels.of(context).beginNewCycle),
      content: new TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          labelText: labels.of(context).budget,
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: new Text(labels.of(context).cancel.toUpperCase()),
        ),
        new FlatButton(
          onPressed: () =>
              Navigator.of(context).pop(double.parse(_controller.value.text)),
          child: new Text(labels.of(context).confirm.toUpperCase()),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fyp_project/headings/label.dart';

class ChangeBudgetInfo extends StatefulWidget {
  final double previousBudget;

  const ChangeBudgetInfo({Key key, this.previousBudget}) : super(key: key);

  @override
  _ChangeBudgetInfoState createState() => new _ChangeBudgetInfoState();
}

class _ChangeBudgetInfoState extends State<ChangeBudgetInfo> {
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
      title: new Text(labels.of(context).changeBudget),
      content: new TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
            labelText: labels.of(context).budget,
            hintText: widget.previousBudget?.toStringAsFixed(2) ?? ''),
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

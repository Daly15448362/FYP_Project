import 'package:flutter/material.dart';
import 'package:fyp_project/monetary/transaction.dart';
import 'package:fyp_project/headings/label.dart';

class InputTransaction extends StatefulWidget {
  final Function(Transaction) onClick;

  const InputTransaction({Key key, this.onClick}) : super(key: key);

  @override
  _InputTransactionState createState() => new _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  TextEditingController _inputController;

  @override
  void initState() {
    super.initState();
    _inputController = new TextEditingController();
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: new TextField(
                controller: _inputController,
                keyboardType: TextInputType.number,
                decoration: new InputDecoration(
                  labelText: labels
                      .of(context)
                      .newExpense,
                ),
              ),
            ),
          ),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: new SizedBox(
                height: 56.0,
                child: new RaisedButton(
                  padding: new EdgeInsets.all(0.0),
                  child: new Text(
                    labels
                        .of(context)
                        .add
                        .toUpperCase(),
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.black),
                  ),
                  onPressed: () {
                    try {
                      double value = double.parse(_inputController.value.text);
                      DateTime dateTime = new DateTime.now();
                      widget.onClick(new Transaction(value, dateTime));
                      _inputController.clear();
                      FocusScope.of(context).requestFocus(new FocusNode());
                    } catch (FormatException) {}
                  },
                  shape: new BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

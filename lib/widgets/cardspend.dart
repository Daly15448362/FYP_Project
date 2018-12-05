import 'package:flutter/material.dart';
import 'package:fyp_project/headings/label.dart';
import 'package:fyp_project/monetary/currency.dart';

class CardSpend extends StatelessWidget {
  final double leftToSpend;
  final Currency currency;

  const CardSpend({Key key, this.leftToSpend, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14.0)),
      ),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(14.0),
              child: new Text(
                valueWithCurrency(leftToSpend, currency),
                style: Theme
                    .of(context)
                    .textTheme
                    .display3,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(labels
                  .of(context)
                  .leftToSpend),
            ),
          ],
        ),
      ),
    );
  }
}
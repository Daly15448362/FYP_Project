import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fyp_project/monetary/currency.dart';
import 'package:fyp_project/monetary/transaction.dart';

class TransactionHistory extends StatelessWidget {
  final Transaction transaction;
  final Currency currency;

  const TransactionHistory({Key key, this.transaction, this.currency})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Card(
      shape: new BeveledRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: new ListTile(
        title: new Text(valueWithCurrency(transaction.value, currency)),
        trailing: new Text(new DateFormat(
            'EEEE, d MMMM', Localizations.localeOf(context).toString())
            .format(transaction.dateTime)),
      ),
    );
  }
}
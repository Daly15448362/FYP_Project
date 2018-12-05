import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fyp_project/headings/label.dart';
import 'package:fyp_project/monetary/currency.dart';
import 'package:fyp_project/monetary/transaction.dart';
import 'package:fyp_project/database/databasestorage.dart';
import 'package:fyp_project/widgets/cardspend.dart';
import 'package:fyp_project/widgets/chg_budget_info.dart';
import 'package:fyp_project/widgets/transaction_history.dart';
import 'package:fyp_project/widgets/transaction_history_design.dart';
import 'package:fyp_project/widgets/input_transaction.dart';
import 'package:fyp_project/widgets//minor_value_card.dart';
import 'package:fyp_project/widgets/cycle_info.dart';

class MainPage extends StatefulWidget {
  final DatabaseService databaseService;

  MainPage({Key key, this.databaseService}) : super(key: key);

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double startBudget = 0.0;
  List<Transaction> transactions = [];
  Currency currency;

  double get spent => transactions.fold(0.0, (sum, expense) => sum + expense.value);

  double get leftToSpend => startBudget - spent;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    _loadTransactions();
    this.currency = widget.databaseService.getCurrency();
    this.startBudget = widget.databaseService.getStartingBudget() ?? 0.0;
  }

  _loadTransactions() {
    widget.databaseService.getCurrentTransactions().then((result) =>
        setState(() =>
        transactions = result
          ..sort((ex1, ex2) => ex1.dateTime.compareTo(ex2.dateTime))));
  }

  _addTransaction(Transaction transaction) {
    widget.databaseService.addTransaction(transaction);
    setState(() {
      transactions.insert(0, transaction);
    });
  }

  _openCurrencyDialog() async {
    Currency currency = await showDialog(
        context: context,
        builder: (context) {
          return new SimpleDialog(
            title: new Text(labels
                .of(context)
                .chooseCurrency),
            children: Currency.currencies
                .map(
                  (currency) =>
              new SimpleDialogOption(
                onPressed: () => Navigator.of(context).pop(currency),
                child: new ListTile(
                  selected: currency == this.currency,
                  title: new Text(currency.getName(context)),
                ),
              ),
            )
                .toList(),
          );
        });
    if (currency != null) {
      widget.databaseService.saveCurrency(currency);
      setState(() {
        this.currency = currency;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        key: new Key("app_bar"),
        centerTitle: true,
        title: new Text(labels
            .of(context)
            .appTitle),
        actions: <Widget>[
          new PopupMenuButton<String>(
            onSelected: (val) {
              switch (val) {
                case 'CURRENCY':
                  _openCurrencyDialog();
                  break;
                case 'NEW_CYCLE':
                  _openNewCycleDialog();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              new PopupMenuItem<String>(
                value: 'NEW_CYCLE',
                child: new Text(labels
                    .of(context)
                    .beginNewCycle),
              ),
              new PopupMenuItem<String>(
                value: 'CURRENCY',
                child: new Text(labels
                    .of(context)
                    .changeCurrency),
              ),
            ],
          ),
        ],
      ),
      body: new SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(16.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new CardSpend(
                leftToSpend: leftToSpend,
                currency: currency,
              ),
              new InputTransaction(
                onClick: _addTransaction,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                    child: new GestureDetector(
                      onTap: _openChangeBudgetInfo,
                      child: new MinorValueCard(
                        value: startBudget,
                        label: labels
                            .of(context)
                            .startingBudget,
                        currency: currency,
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new MinorValueCard(
                      value: spent,
                      label: labels
                          .of(context)
                          .sumOfExpenses,
                      currency: currency,
                    ),
                  ),
                ],
              ),
              new TransactionDesign(),
              new Column(
                children: transactions
                    .map((transaction) =>
                new TransactionHistory(
                  transaction: transaction,
                  currency: currency,
                ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _openChangeBudgetInfo() async {
    double newBudget = await showDialog<double>(
      context: context,
      builder: (context) => new ChangeBudgetInfo(previousBudget: startBudget),
    );
    if (newBudget != null) {
      await widget.databaseService.saveStartingBudget(newBudget, reset: false);
      setState(() {
        this.startBudget = newBudget;
      });
    }
  }

  void _openNewCycleDialog({bool reset = true}) async {
    double newBudget = await showDialog<double>(
      context: context,
      builder: (context) => new NewCycleInfo(),
    );
    if (newBudget != null) {
      await widget.databaseService.saveStartingBudget(newBudget, reset: true);
      setState(() {
        this.startBudget = newBudget;
        if (reset) {
          this.transactions = [];
        }
      });
    }
  }
}

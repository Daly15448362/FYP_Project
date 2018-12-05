import 'package:flutter/material.dart';
import 'package:fyp_project/headings/label.dart';

typedef String NameGetter(BuildContext context);

class Currency {
  final String symbol;
  final bool Leftapp;
  final NameGetter getName;
  final String name;

  Currency._(this.symbol, this.name, this.Leftapp, this.getName);

  static Currency eur =
      new Currency._("€", "EUR", false, (context) => labels.of(context).currencyEUR);

  static List<Currency> currencies = [

    Currency.eur,

  ];

  @override
  String toString() => name;

  static Currency fromString(String name) {
    switch (name) {
      case "EUR":
        return eur;
      default:
        return eur;
    }
  }
}

String valueWithCurrency(double amount, Currency currency) {
  String value = amount < 0 ? "-" : "";
  String prefix = currency.Leftapp ? currency.symbol : "";
  String stringValue = amount.abs().toStringAsFixed(2);
  String suffix = currency.Leftapp ? "" : " ${currency.symbol}";
  return value + prefix + stringValue + suffix;
}

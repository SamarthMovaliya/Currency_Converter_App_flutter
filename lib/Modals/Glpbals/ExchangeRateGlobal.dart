import 'package:flutter/material.dart';

class ExchangeRate {
  String date;
  String baseCurrency;
  Map rates;

  ExchangeRate({
    required this.date,
    required this.baseCurrency,
    required this.rates,
  });

  factory ExchangeRate.fromMap({required Map data}) {
    return ExchangeRate(
      date: data['time_last_update_utc'],
      baseCurrency: data['base_code'],
      rates: data['conversion_rates'],
    );
  }
}

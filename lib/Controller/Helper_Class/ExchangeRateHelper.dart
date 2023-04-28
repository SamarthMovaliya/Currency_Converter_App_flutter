import 'dart:convert';
import 'package:currency_converter_app_api/Modals/Glpbals/CurrencyGlobal.dart';
import 'package:currency_converter_app_api/Modals/Glpbals/ExchangeRateGlobal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExchangeRateHelper {
  ExchangeRateHelper._();

  static final ExchangeRateHelper exchangeRateHelper = ExchangeRateHelper._();

  fetchAllData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://v6.exchangerate-api.com/v6/270d160e138305ffea658454/latest/USD'),
    );

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);
      ExchangeRate allData = ExchangeRate.fromMap(data: decodedData);
      return allData;
    }
  }
}

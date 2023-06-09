import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Modals/Glpbals/CurrencyGlobal.dart';

class apiHelper {
  apiHelper._();

  static final apiHelper api = apiHelper._();

  fetchCurrencyData({dynamic From, dynamic To, dynamic amount = 1}) async {
    http.Response res = await http.get(Uri.parse(
        'https://api.exchangerate.host/convert?from=$From&to=$To&amount=${amount}'));
    print(res.body);
    if (res.statusCode == 200) {
      Map decodeCode = jsonDecode(res.body);
      global allData = global.fromMap(data: decodeCode);
      return allData;
    }
  }
}

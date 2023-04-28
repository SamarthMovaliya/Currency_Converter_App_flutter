import 'package:currency_converter_app_api/Modals/Glpbals/Modals/FromModal.dart';
import 'package:flutter/material.dart';

class FromProvider extends ChangeNotifier {
  fromToModal fromtoModal = fromToModal(from: 'USD', to: "INR");

  changeFrom({required String from}) {
    fromtoModal.from = from;
    notifyListeners();
  }

  changeTo({required String to}) {
    fromtoModal.to = to;
    notifyListeners();
  }
}

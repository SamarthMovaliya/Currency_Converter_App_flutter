import 'package:currency_converter_app_api/Controller/Providers/FromProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Modals/Glpbals/CurrencyGlobal.dart';

class dropDown2 extends StatefulWidget {
  const dropDown2({Key? key}) : super(key: key);

  @override
  State<dropDown2> createState() => _dropDown2State();
}

class _dropDown2State extends State<dropDown2> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade300,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10,
            ),
            child: DropdownButton(
                dropdownColor: Colors.blueGrey.shade300,
                style: const TextStyle(color: Colors.white),
                borderRadius: BorderRadius.circular(20),
                icon: const Icon(
                  Icons.list,
                  color: Colors.white,
                  size: 25,
                ),
                isExpanded: true,
                underline: Container(),
                value: from,
                items: allcountry
                    .map(
                      (e) => DropdownMenuItem(
                        value: e['currency_code'],
                        child: Text(
                          e['country'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  Provider.of<FromProvider>(context, listen: false)
                      .changeFrom(from: val.toString());
                  setState(() {
                    from = val;
                  });
                }),
          ),
        ),
      ),
    );
  }
}

import 'package:currency_converter_app_api/Controller/Providers/FromProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Modals/Glpbals/CurrencyGlobal.dart';

class dropDown extends StatefulWidget {
  const dropDown({Key? key}) : super(key: key);

  @override
  State<dropDown> createState() => _dropDownState();
}

class _dropDownState extends State<dropDown> {
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
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: DropdownButton(
                dropdownColor: Colors.blueGrey.shade300,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                borderRadius: BorderRadius.circular(10),
                icon: const Icon(
                  Icons.more,
                  color: Colors.white,
                  size: 25,
                ),
                isExpanded: true,
                underline: Container(),
                value: to,
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
                  Provider.of<FromProvider>(context, listen: false).changeTo(
                    to: val.toString(),
                  );
                  setState(() {
                    to = val;
                  });
                }),
          ),
        ),
      ),
    );
  }
}

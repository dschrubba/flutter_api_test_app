import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';

Future<void> dialogBuilder(
  BuildContext context,
  Flavor flavor,
  WeatherReqParam weatherParam,
) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: flavor.base,
        contentTextStyle: TextStyle(color: flavor.flamingo),
        title: Text(weatherParam.title),
        content: _getInputField(weatherParam, flavor),
        actions: <Widget>[
          TextButton(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(flavor.flamingo),
              overlayColor: WidgetStatePropertyAll(flavor.flamingo),
            ),
            child: Text("Discard"),
            onPressed: () => {Navigator.of(context).pop()},
          ),
          FilledButton(
            style: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(flavor.crust),
              backgroundColor: WidgetStatePropertyAll(flavor.flamingo),
            ),
            child: Text("Submit"),
            onPressed: () => {Navigator.of(context).pop()},
          ),
        ],
      );
    },
  );
}

Widget _getInputField(WeatherReqParam weatherParam, Flavor flavor) {
  TextEditingController controller = TextEditingController();
  controller.text = weatherParam.valuesAsString();

  return TextField(
    style: TextStyle(color: flavor.flamingo),
    autofocus: true,
    controller: controller,
    decoration: InputDecoration(
      isDense: true,
      border: OutlineInputBorder(),
      fillColor: flavor.text,
      labelText: null,
    ),
    keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.deny(',', replacementString: '.'),
      FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d{0,6})')),
    ],
  );
}

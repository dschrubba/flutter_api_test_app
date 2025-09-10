import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test_app/common/widgets/app_param_input_dialog.dart';
import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class AppParamInput extends StatefulWidget {
  final Flavor flavor;
  final WeatherReqParam weatherParam;
  const AppParamInput({
    super.key,
    required this.flavor,
    required this.weatherParam,
  });

  @override
  State<AppParamInput> createState() => _AppParamInputState();
}

class _AppParamInputState extends State<AppParamInput> {
  bool checkBoxValue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 8
      ),
      padding: EdgeInsets.only(
        left: widget.weatherParam.isRequired ? 16 : 0,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: widget.flavor.crust,
        borderRadius: BorderRadius.circular(8),
      ),
      constraints: BoxConstraints(minHeight: 56),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Row(
              children: [
                if (!widget.weatherParam.isRequired)
                  Checkbox(
                    value: checkBoxValue,
                    onChanged: (bool? value) {
                      setState(() {
                        checkBoxValue = value ?? false;
                      });
                    },
                  ),
                Text(widget.weatherParam.title),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              spacing: 16,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(widget.weatherParam.valuesAsString()),
                IconButton.filled(
                  icon: Icon(LucideIcons.pencil300),
                  onPressed: () => {
                    dialogBuilder(context, widget.flavor, widget.weatherParam),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

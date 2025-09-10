import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test_app/data/domain/weather_req_param.dart';

class AppParamCheckCard extends StatefulWidget {
  final WeatherReqParam weatherParam;
  final Flavor flavor;
  final Function? onChanged;
  const AppParamCheckCard({super.key, required this.weatherParam, required this.flavor, this.onChanged});

  @override
  State<AppParamCheckCard> createState() => _AppParamCheckCardState();
}

class _AppParamCheckCardState extends State<AppParamCheckCard> {
  GlobalKey checkBoxKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: widget.flavor.crust,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      maxLines: 2,
                      "${widget.weatherParam.title}\n",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      ),
                  ),
                  Flexible(
                    child: Checkbox(
                      key: checkBoxKey,
                      value: widget.weatherParam.isSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          widget.weatherParam.isSelected = value ?? false;
                        });
                        if (widget.onChanged != null) {
                          widget.onChanged!(widget.weatherParam.isSelected);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => {
                if ((checkBoxKey.currentWidget is Checkbox) &&
                    (checkBoxKey.currentWidget! as Checkbox).onChanged != null)
                  {
                    (checkBoxKey.currentWidget! as Checkbox).onChanged!(
                      !widget.weatherParam.isSelected,
                    ),
                  },
              },
            ),
          ),
        ],
      ),
    );
  }
}

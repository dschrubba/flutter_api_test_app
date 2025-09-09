import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

class AppCheckbox extends StatefulWidget {
  final String title;
  final Flavor flavor;
  const AppCheckbox({super.key, required this.title, required this.flavor});

  @override
  State<AppCheckbox> createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  GlobalKey? checkBoxKey;
  GlobalKey? inkWellKey;
  bool checkBoxValue = false;
  bool onlySplash = false;
  InteractiveInkFeatureFactory splashFactory = InkRipple.splashFactory;
  @override
  Widget build(BuildContext context) {
    checkBoxKey ??= GlobalKey();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: widget.flavor.flamingo.withAlpha(4)
          ),
          boxShadow: [
            BoxShadow(
              color: widget.flavor.base.withAlpha(32),
              offset: Offset(0, 16),
              blurRadius: 32
            )
          ],
          color: widget.flavor.surface1,
          borderRadius: BorderRadius.circular(16)),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Checkbox(
                      key: checkBoxKey,
                      value: checkBoxValue,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onChanged: (bool? value) {
                        setState(() {
                          checkBoxValue = value ?? false;
                        });
                      },
                    ),
                    Text(widget.title)
                  ],
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashFactory: splashFactory,
                onTap: () => {triggerCheckBoxTap()},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void triggerCheckBoxTap() {
    if (checkBoxKey?.currentWidget is Checkbox &&
        (checkBoxKey?.currentWidget as Checkbox).onChanged != null) {
      (checkBoxKey!.currentWidget as Checkbox).onChanged!(!checkBoxValue);
    }
  }
}

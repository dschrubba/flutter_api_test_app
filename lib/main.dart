import 'package:flutter/material.dart';
import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter_api_test_app/design/flutter_catppuccin.dart';
import 'package:flutter_api_test_app/screens/main/presentation/screen_main.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    final flavor = catppuccin.mocha;

    return MaterialApp(
      theme: catppuccinTheme(catppuccin.mocha).copyWith(
        scaffoldBackgroundColor: Color.lerp(flavor.crust, flavor.lavender, 0.125)
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: flavor.crust,
          title: Text(
            'Flutter: API Test App',
            style: TextStyle(color: flavor.text),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: ScreenMain(flavor: flavor,),
          )
          ),
      ),
    );
  }
}

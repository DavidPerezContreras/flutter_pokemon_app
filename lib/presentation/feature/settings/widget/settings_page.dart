import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsPageWidget extends StatefulWidget {
  SettingsPageWidget(this.themeNotifier, {super.key});

  ValueNotifier<ThemeData> themeNotifier;

  @override
  State<SettingsPageWidget> createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  late bool _isDark;

  @override
  void initState() {
    _isDark = widget.themeNotifier.value == ThemeData.dark();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("flutter_pokemon_app"),
        backgroundColor: Colors.greenAccent[400],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Menu Icon',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ), //AppBar,
      body: Center(
        child: Switch(
          value: _isDark,
          onChanged: (newValue) {
            _isDark = newValue;

            if (_isDark == true) {
              widget.themeNotifier.value = ThemeData.dark();
            } else {
              widget.themeNotifier.value = ThemeData.light();
            }
          },
        ),
      ),
    );
  }
}

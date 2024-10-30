import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CustomThemeApp());
}

class CustomThemeApp extends StatelessWidget {
  const CustomThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CustomTheme(
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: CustomTheme.of(context).data.backgroundColor,
              body: Center(
                child: Text(
                  'Hello, world!',
                  style: TextStyle(
                    color: CustomTheme.of(context).data.foregroundColor,
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => CustomTheme.of(context).toggleDarkMode(),
                child: Icon(CustomTheme.of(context).data.darkMode
                    ? Icons.dark_mode
                    : Icons.light_mode),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CustomTheme extends InheritedNotifier<ValueListenable<CustomThemeData>> {
  CustomTheme({super.key, required super.child});

  static CustomTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CustomTheme>()!;
  }

  final _notifier = ValueNotifier(const CustomThemeData(darkMode: false));

  CustomThemeData get data => _notifier.value;

  @override
  ValueListenable<CustomThemeData>? get notifier => _notifier;

  void toggleDarkMode() {
    final current = _notifier.value.darkMode;
    _notifier.value = CustomThemeData(darkMode: !current);
  }
}

class CustomThemeData {
  final bool darkMode;
  final Color backgroundColor;
  final Color foregroundColor;

  const CustomThemeData({required this.darkMode})
      : backgroundColor = darkMode ? Colors.black : Colors.white,
        foregroundColor = darkMode ? Colors.white : Colors.black;
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DynamicThemeApp());
}

class DynamicThemeApp extends StatelessWidget {
  const DynamicThemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DynamicTheme(
        child: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: DynamicTheme.of(context).data.backgroundColor,
              body: Center(
                child: Text(
                  'Hello, world!',
                  style: TextStyle(
                    color: DynamicTheme.of(context).data.foregroundColor,
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => DynamicTheme.of(context).toggleDarkMode(),
                child: Icon(DynamicTheme.of(context).data.darkMode
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

class DynamicTheme
    extends InheritedNotifier<ValueListenable<DynamicThemeData>> {
  DynamicTheme({super.key, required super.child});

  static DynamicTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DynamicTheme>()!;
  }

  final _notifier = ValueNotifier(const DynamicThemeData(darkMode: false));

  DynamicThemeData get data => _notifier.value;

  @override
  ValueListenable<DynamicThemeData>? get notifier => _notifier;

  void toggleDarkMode() {
    final current = _notifier.value.darkMode;
    _notifier.value = DynamicThemeData(darkMode: !current);
  }
}

class DynamicThemeData {
  final bool darkMode;
  final Color backgroundColor;
  final Color foregroundColor;

  const DynamicThemeData({required this.darkMode})
      : backgroundColor = darkMode ? Colors.black : Colors.white,
        foregroundColor = darkMode ? Colors.white : Colors.black;
}

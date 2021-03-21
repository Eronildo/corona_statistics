import 'package:flutter/material.dart';

class Provider<T> extends InheritedWidget {
  final T data;

  Provider({required this.data, required Widget child}) : super(child: child);

  static T of<T>(BuildContext context) {
    final type = _typeOf<Provider<T>>();
    return context
        .dependOnInheritedWidgetOfExactType<Provider<T>>(aspect: type)!
        .data;
  }

  static Type _typeOf<T>() => T;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

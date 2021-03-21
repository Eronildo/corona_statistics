import 'package:flutter/material.dart';

abstract class Controller<State> extends ValueNotifier<State> {
  Controller(value) : super(value);
  void init();
}

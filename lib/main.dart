import 'package:corona/src/factories/statistics_factory.dart';
import 'package:corona/src/pages/home_page.dart';
import 'package:corona/src/utils/provider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Provider(
        data: makeStatisticsController(),
        child: HomePage(),
      ),
    ),
  );
}

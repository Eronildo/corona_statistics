import 'dart:convert';

import 'package:corona/src/controllers/controller.dart';
import 'package:corona/src/controllers/statistics_controller.dart';
import 'package:corona/src/errors/app_error.dart';
import 'package:corona/src/models/statistics.dart';
import 'package:corona/src/pages/home_page.dart';
import 'package:corona/src/repository/statistics_repository.dart';
import 'package:corona/src/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/statistics_mock.dart';

class RepositoryMock extends Mock implements StatisticsRepository {}

void main() {
  final repositoryMock = RepositoryMock();
  final controller = StatisticsController(repositoryMock);

  testWidgets('Should show a loading and a list of statistics',
      (WidgetTester tester) async {
    when(() => repositoryMock.getStatistics()).thenAnswer((_) async =>
        List<Statistics>.from(jsonDecode(StatisticsMock.jsonData)['data']
            .map((model) => Statistics.fromMap(model))));

    await tester.pumpWidget(MaterialApp(
      home: Provider<Controller>(
        data: controller,
        child: HomePage(),
      ),
    ));

    final loadingWidget = find.byType(CircularProgressIndicator);
    expect(loadingWidget, findsOneWidget);

    final listOfStatistics = find.byType(ListView);
    expect(listOfStatistics, findsNothing);

    await tester.pump();

    expect(listOfStatistics, findsOneWidget);
  });

  Future<List<Statistics>> _getStatisticsWithServerError() {
    throw ServerError(message: 'Error loading statistics.');
  }

  testWidgets('Should show a loading and a error text',
      (WidgetTester tester) async {
    when(() => repositoryMock.getStatistics())
        .thenAnswer((_) async => await _getStatisticsWithServerError());

    await tester.pumpWidget(MaterialApp(
      home: Provider<Controller>(
        data: controller,
        child: HomePage(),
      ),
    ));

    final loadingWidget = find.byType(CircularProgressIndicator);
    expect(loadingWidget, findsOneWidget);

    final listOfStatistics = find.byType(ListView);
    expect(listOfStatistics, findsNothing);

    final errorText = find.byKey(ValueKey('ErrorText'));
    expect(errorText, findsNothing);

    await tester.pump();

    expect(listOfStatistics, findsNothing);

    expect(errorText, findsOneWidget);
  });
}

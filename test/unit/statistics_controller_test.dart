import 'dart:convert';
import 'package:corona/src/controllers/statistics_controller.dart';
import 'package:corona/src/controllers/statistics_state.dart';
import 'package:corona/src/errors/app_error.dart';
import 'package:corona/src/repository/statistics_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:corona/src/models/statistics.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/statistics_mock.dart';

class RepositoryMock extends Mock implements StatisticsRepository {}

void main() {
  final repositoryMock = RepositoryMock();
  final controller = StatisticsController(repositoryMock);

  test('Should return a statistics model', () {
    when(() => repositoryMock.getStatistics()).thenAnswer((_) async =>
        List<Statistics>.from(jsonDecode(StatisticsMock.jsonData)['data']
            .map((model) => Statistics.fromMap(model))));

    bool isLoading = false;
    controller.addListener(() {
      if (!isLoading) {
        expect(controller.value, isA<LoadingState>());
        isLoading = true;
      } else
        expect(controller.value, isA<LoadedState>());
    });
    controller.init();
  });

  Future<List<Statistics>> _getStatisticsWithServerError() {
    throw ServerError(message: 'Error loading statistics.');
  }

  test('Should throw a ServerError', () {
    when(() => repositoryMock.getStatistics())
        .thenAnswer((_) async => await _getStatisticsWithServerError());

    bool isLoading = false;
    controller.addListener(() {
      if (!isLoading) {
        expect(controller.value, isA<LoadingState>());
        isLoading = true;
      } else
        expect(controller.value, isA<ErrorState>());
    });
    controller.init();
  });
}

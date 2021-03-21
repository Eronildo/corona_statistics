import 'dart:io';

import 'package:corona/src/errors/app_error.dart';
import 'package:corona/src/repository/statistics_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/statistics_mock.dart';

class ClientMock extends Mock implements Client {}

void main() {
  final clientMock = ClientMock();
  final repository = StatisticsRepositoryImpl(clientMock);

  setUpAll(() {
    registerFallbackValue<Uri>(Uri());
  });

  test('Should return a statistics', () async {
    when(() => clientMock.get(any())).thenAnswer(
        (_) async => Response(StatisticsMock.jsonData, HttpStatus.ok));
    final statistics = await repository.getStatistics();
    expect(statistics.length, 2);
  });

  test('Should throw a ServerError', () {
    when(() => clientMock.get(any())).thenAnswer(
        (_) async => Response(StatisticsMock.jsonData, HttpStatus.badRequest));
    expect(() => repository.getStatistics(), throwsA(isA<ServerError>()));
  });
}

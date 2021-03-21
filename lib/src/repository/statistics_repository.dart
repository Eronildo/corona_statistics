import 'dart:convert';
import 'dart:io';

import 'package:corona/src/errors/app_error.dart';
import 'package:corona/src/models/statistics.dart';
import 'package:http/http.dart';

abstract class StatisticsRepository {
  Future<List<Statistics>> getStatistics();
}

class StatisticsRepositoryImpl implements StatisticsRepository {
  final Client client;

  StatisticsRepositoryImpl(this.client);

  final String _url = 'https://corona-api.com/countries';

  @override
  Future<List<Statistics>> getStatistics() async {
    final response = await client.get(Uri.parse(_url));
    if (response.statusCode == HttpStatus.ok) {
      final jsonResponse = jsonDecode(response.body) as Map;
      if (jsonResponse.containsKey('data')) {
        final jsonData = jsonResponse['data'];
        return List<Statistics>.from(jsonData
            .map((statisticsJson) => Statistics.fromMap(statisticsJson)));
      } else
        throw ServerError(message: 'No data found.');
    } else {
      throw ServerError(message: 'Error loading statistics.');
    }
  }
}

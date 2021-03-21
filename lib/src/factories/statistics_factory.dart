import 'package:corona/src/controllers/controller.dart';
import 'package:corona/src/controllers/statistics_controller.dart';
import 'package:corona/src/repository/statistics_repository.dart';
import 'package:http/http.dart';

StatisticsRepository makeStatisticsRepository() =>
    StatisticsRepositoryImpl(Client());

Controller makeStatisticsController() =>
    StatisticsController(makeStatisticsRepository());

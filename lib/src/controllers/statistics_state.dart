import 'package:corona/src/models/statistics.dart';

abstract class StatisticsState {}

class EmptyState extends StatisticsState {}

class LoadingState extends StatisticsState {}

class LoadedState extends StatisticsState {
  final List<Statistics> data;

  LoadedState({required this.data});
}

class ErrorState extends StatisticsState {
  final String message;

  ErrorState({required this.message});
}

import 'package:corona/src/controllers/controller.dart';
import 'package:corona/src/errors/app_error.dart';
import 'package:corona/src/repository/statistics_repository.dart';
import 'package:corona/src/controllers/statistics_state.dart';

class StatisticsController extends Controller<StatisticsState> {
  final StatisticsRepository repository;

  StatisticsController(this.repository) : super(EmptyState());

  @override
  void init() {
    _loadState();
  }

  void _loadState() {
    value = LoadingState();
    repository.getStatistics().then((statistics) {
      value = LoadedState(data: statistics);
    }, onError: (e) {
      var message = 'Error!';
      if (e is ServerError) message = e.message;
      value = ErrorState(message: message);
    });
  }
}

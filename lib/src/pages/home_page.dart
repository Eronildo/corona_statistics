import 'package:corona/src/controllers/controller.dart';
import 'package:corona/src/controllers/statistics_state.dart';
import 'package:corona/src/models/statistics.dart';
import 'package:corona/src/utils/controller_builder.dart';
import 'package:corona/src/utils/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Corona Statistics'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh_outlined),
            onPressed: () {
              controller.init();
            },
          ),
        ],
      ),
      body: Center(
        child: ControllerBuilder<Controller, StatisticsState>(
          builder: (context, state) {
            if (state is LoadedState) {
              if (state.data.isEmpty) return Text('Empty!');
              return _getStatisticsWidget(context, state.data);
            } else if (state is LoadingState)
              return CircularProgressIndicator();
            else if (state is ErrorState)
              return Text(
                state.message,
                key: ValueKey('ErrorText'),
              );
            return Container();
          },
          controller: controller..init(),
        ),
      ),
    );
  }

  Widget _getStatisticsWidget(
      BuildContext context, List<Statistics> statistics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // _getHeader(context),
        Divider(),
        _getListOfStatistics(context, statistics),
        Divider(),
        _getFooter(statistics.first.updatedAt.toString()),
      ],
    );
  }

  Widget _getListOfStatistics(
          BuildContext context, List<Statistics> statistics) =>
      Expanded(
        child: ListView.builder(
          itemCount: statistics.length,
          itemBuilder: (_, index) {
            return _getCountryCard(context, statistics[index]);
          },
        ),
      );

  Widget _getCountryCard(BuildContext context, Statistics statistics) {
    return Card(
      elevation: 0.3,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        onTap: () {
          // Dialogs.showDetails(context, statistics);
        },
        title: Text(
          statistics.name,
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: Text(
          statistics.latestData.confirmed.toString(),
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }

  Widget _getFooter(String date) => Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Text(
          "Last Updated at: $date",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

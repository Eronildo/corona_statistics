class StatisticsMock {
  StatisticsMock._();

  static String get jsonData => '''
  {
    "data": [
    {
          "coordinates": {
              "latitude": 33,
              "longitude": 65
          },
          "name": "Afghanistan",
          "code": "AF",
          "population": 29121286,
          "updated_at": "2021-03-13T22:22:34.395Z",
          "today": {
              "deaths": 0,
              "confirmed": 28
          },
          "latest_data": {
              "deaths": 2457,
              "confirmed": 55985,
              "recovered": 49471,
              "critical": 4057,
              "calculated": {
                  "death_rate": 4.38867553809056,
                  "recovery_rate": 88.36474055550593,
                  "recovered_vs_death_ratio": null,
                  "cases_per_million_population": 1091
              }
          }
      },
      {
          "coordinates": {
              "latitude": 41,
              "longitude": 20
          },
          "name": "Albania",
          "code": "AL",
          "population": 2986952,
          "updated_at": "2021-03-13T22:22:34.395Z",
          "today": {
              "deaths": 12,
              "confirmed": 698
          },
          "latest_data": {
              "deaths": 2030,
              "confirmed": 116821,
              "recovered": 79821,
              "critical": 34970,
              "calculated": {
                  "death_rate": 1.737701269463538,
                  "recovery_rate": 68.32761232997491,
                  "recovered_vs_death_ratio": null,
                  "cases_per_million_population": 46
              }
          }
      }
    ]
  }
''';
}

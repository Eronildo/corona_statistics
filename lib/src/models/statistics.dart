// To parse this JSON data, do
//
//     final model = modelFromMap(jsonString);

import 'dart:convert';

Statistics modelFromMap(String str) => Statistics.fromMap(json.decode(str));

String modelToMap(Statistics data) => json.encode(data.toMap());

class Statistics {
    Statistics({
        required this.coordinates,
        required this.name,
        required this.code,
        required this.population,
        required this.updatedAt,
        required this.today,
        required this.latestData,
    });

    final Coordinates coordinates;
    final String name;
    final String code;
    final int population;
    final DateTime updatedAt;
    final Today today;
    final LatestData latestData;

    factory Statistics.fromMap(Map<String, dynamic> json) => Statistics(
        coordinates: Coordinates.fromMap(json["coordinates"]),
        name: json["name"],
        code: json["code"],
        population: json["population"] ?? 0,
        updatedAt: DateTime.parse(json["updated_at"]),
        today: Today.fromMap(json["today"]),
        latestData: LatestData.fromMap(json["latest_data"]),
    );

    Map<String, dynamic> toMap() => {
        "coordinates": coordinates.toMap(),
        "name": name,
        "code": code,
        "population": population,
        "updated_at": updatedAt.toIso8601String(),
        "today": today.toMap(),
        "latest_data": latestData.toMap(),
    };
}

class Coordinates {
    Coordinates({
        required this.latitude,
        required this.longitude,
    });

    final double latitude;
    final double longitude;

    factory Coordinates.fromMap(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble() ?? 0.0,
        longitude: json["longitude"]?.toDouble() ?? 0.0,
    );

    Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class LatestData {
    LatestData({
        required this.deaths,
        required this.confirmed,
        required this.recovered,
        required this.critical,
        required this.calculated,
    });

    final int deaths;
    final int confirmed;
    final int recovered;
    final int critical;
    final Calculated calculated;

    factory LatestData.fromMap(Map<String, dynamic> json) => LatestData(
        deaths: json["deaths"],
        confirmed: json["confirmed"],
        recovered: json["recovered"],
        critical: json["critical"],
        calculated: Calculated.fromMap(json["calculated"]),
    );

    Map<String, dynamic> toMap() => {
        "deaths": deaths,
        "confirmed": confirmed,
        "recovered": recovered,
        "critical": critical,
        "calculated": calculated.toMap(),
    };
}

class Calculated {
    Calculated({
        required this.deathRate,
        required this.recoveryRate,
        this.recoveredVsDeathRatio,
        required this.casesPerMillionPopulation,
    });

    final double deathRate;
    final double recoveryRate;
    final dynamic recoveredVsDeathRatio;
    final int casesPerMillionPopulation;

    factory Calculated.fromMap(Map<String, dynamic> json) => Calculated(
        deathRate: json["death_rate"]?.toDouble() ?? 0.0,
        recoveryRate: json["recovery_rate"]?.toDouble() ?? 0.0,
        recoveredVsDeathRatio: json["recovered_vs_death_ratio"],
        casesPerMillionPopulation: json["cases_per_million_population"],
    );

    Map<String, dynamic> toMap() => {
        "death_rate": deathRate,
        "recovery_rate": recoveryRate,
        "recovered_vs_death_ratio": recoveredVsDeathRatio,
        "cases_per_million_population": casesPerMillionPopulation,
    };
}

class Today {
    Today({
        required this.deaths,
        required this.confirmed,
    });

    final int deaths;
    final int confirmed;

    factory Today.fromMap(Map<String, dynamic> json) => Today(
        deaths: json["deaths"],
        confirmed: json["confirmed"],
    );

    Map<String, dynamic> toMap() => {
        "deaths": deaths,
        "confirmed": confirmed,
    };
}

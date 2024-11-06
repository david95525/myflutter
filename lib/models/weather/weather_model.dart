import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WeatherModel extends Equatable {
  final String id;
  final int temperature;
  final int minTemperature;
  final int maxTemperature;
  final int weatherTypes;
  final String weatherDescription;
  final String? datetime;
  const WeatherModel(
      {required this.id,
      required this.temperature,
      required this.minTemperature,
      required this.maxTemperature,
      required this.weatherTypes,
      required this.weatherDescription,
      this.datetime});
  @override
  String toString() =>
      "$id $temperature $minTemperature $maxTemperature $weatherTypes $weatherDescription $datetime";

  @override
  List<Object?> get props => [
        id,
        temperature,
        minTemperature,
        maxTemperature,
        weatherTypes,
        weatherDescription
      ];
}
